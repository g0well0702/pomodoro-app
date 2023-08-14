import 'package:flutter/material.dart';
import 'dart:async';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const tewentyFiveMinutes = 1500;
  int totalSeconds = tewentyFiveMinutes;
  bool isRunnig = false;
  int totalPomodoros = 0;

  late Timer timer; // timer는 지정된 시간마다 어떤 동작을 수행하게 될 거라고 계약, 나중에 만들게

  void onStartPressed() {
    timer = Timer.periodic(
        const Duration(seconds: 1), onTick); //periodic 타이머는 입력한 시간마다 함수를 실행함
    setState(() {
      isRunnig = true;
    });
  }

  void onPausePressed() {
    timer.cancel();
    setState(() {
      isRunnig = false;
    });
  }

  void onRestartPressed() {
    timer.cancel();
    setState(() {
      isRunnig = false;
      totalSeconds = tewentyFiveMinutes;
    });
  }

  void onTick(Timer timer) {
    if (totalSeconds == 0) {
      setState(() {
        isRunnig = false;
        totalPomodoros = totalPomodoros + 1;
        totalSeconds = tewentyFiveMinutes;
      });
      timer.cancel();
    } else {
      setState(() {
        totalSeconds = totalSeconds - 1;
      });
    }
  }

  String format(int seconds) {
    var duration = Duration(
      seconds: seconds,
    );
    return duration.toString().split(".").first.substring(2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Column(
        children: [
          Flexible(
            flex: 1,
            child: Container(
              alignment:
                  Alignment.bottomCenter, //다음 Flexible과 맞닿아 있는 곳에서 중앙이라는 의미
              child: Text(
                format(totalSeconds),
                style: TextStyle(
                    color: Theme.of(context).cardColor,
                    fontSize: 89,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ),
          Flexible(
            flex: 2,
            child: Center(
              child: Column(
                children: [
                  IconButton(
                    color: Theme.of(context).cardColor,
                    iconSize: 120,
                    onPressed: isRunnig ? onPausePressed : onStartPressed,
                    icon: Icon(isRunnig
                        ? Icons.pause_circle_outlined
                        : Icons.play_circle_outlined),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  IconButton(
                      color: Theme.of(context).cardColor,
                      iconSize: 120,
                      onPressed: onRestartPressed,
                      icon: const Icon(Icons.restart_alt_rounded)),
                ],
              ),
            ),
          ),
          Flexible(
            flex: 1,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(40),
                      ),
                      color: Theme.of(context).cardColor,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Pomodoros',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color:
                                Theme.of(context).textTheme.displayLarge!.color,
                          ),
                        ),
                        Text(
                          '$totalPomodoros',
                          style: TextStyle(
                            fontSize: 58,
                            fontWeight: FontWeight.w600,
                            color:
                                Theme.of(context).textTheme.displayLarge!.color,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
