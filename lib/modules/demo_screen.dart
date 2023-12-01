import 'dart:async';

import 'package:flutter/material.dart';

class MyTimerApp extends StatefulWidget {
  @override
  _MyTimerAppState createState() => _MyTimerAppState();
}

class _MyTimerAppState extends State<MyTimerApp> {
  int hours = 1;
  int minutes = 6; // 360 minutes
  int seconds = 0;

  Timer? walkTimer;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Timer App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Time: $hours:$minutes:$seconds',
              style: TextStyle(fontSize: 24),
            ),
            const SizedBox(
              height: 10,
            ),

            FloatingActionButton(
              onPressed: () {
                startTimer();
              },
              child: Icon(Icons.play_arrow),
            ),

            const SizedBox(
              height: 10,
            ),
            FloatingActionButton(
              onPressed: () {
                walkTimer?.cancel();
              },
              child: Icon(Icons.pause),
            ),


          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          startTimer();
        },
        child: Icon(Icons.play_arrow),
      ),




    );
  }

  void startTimer() {
 walkTimer = Timer.periodic(Duration(seconds: 1), (Timer timer) {
      setState(() {
        if (seconds == 59) {
          seconds = 0;
          if (minutes == 59) {
            minutes = 0;
            hours++;
          } else {
            minutes++;
          }
        } else {
          seconds++;
        }
      });
    });
  }
}