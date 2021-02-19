import 'dart:async';

import 'package:flappy_duck/barriers.dart';
import 'package:flappy_duck/duck.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Position of the bird vertically
  static double birdYAxis = 0;

  double time = 0;
  double height = 0;
  double initialHeight = birdYAxis;

  // Check if game has started
  bool gameHasStarted = false;

  // Barriers
  static double barrierXOne = 0;
  double barrierXTwo = barrierXOne + 1.5;

  void startGame() {
    gameHasStarted = true;
    Timer.periodic(Duration(milliseconds: 50), (timer) {
      time += 0.04;
      height = -4.9 * time * time + 2.8 * time;
      if (barrierXOne >= -0.3 || barrierXOne <= 0.3 || barrierXTwo >= -0.3 || barrierXTwo <= 0.3) {
        if (birdYAxis > 0.4) {
          timer.cancel();
          gameHasStarted = false;
          birdYAxis = 0;
          time = 0;
          height = 0;
          initialHeight = birdYAxis;
          bringBirdToDefaultPosition();
        }
      }
      setState(() {
        birdYAxis = initialHeight - height;
      });

      setState(() {
        if (barrierXOne < -2) {
          barrierXOne += 3.5;
        } else {
          barrierXOne -= 0.05;
        }
      });

      setState(() {
        if (barrierXTwo < -2) {
          barrierXTwo += 3.5;
        } else {
          barrierXTwo -= 0.05;
        }
      });

      if (birdYAxis > 1.3) {
        timer.cancel();
        gameHasStarted = false;
        birdYAxis = 0;
        time = 0;
        height = 0;
        initialHeight = birdYAxis;
        bringBirdToDefaultPosition();
      }
    });
  }

  void bringBirdToDefaultPosition() {
    birdYAxis = 0;
  }

  void jump() {
    setState(() {
      time = 0;
      initialHeight = birdYAxis;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (gameHasStarted) {
          jump();
        } else {
          startGame();
        }
      },
      child: Scaffold(
        body: Column(
          children: [
            getPlayScreenUI(),
            Container(
              height: 15,
              color: Colors.green,
            ),
            getBottomContainerWithScoreUI(),
          ],
        ),
      ),
    );
  }

  Expanded getPlayScreenUI() {
    return Expanded(
      flex: 2,
      child: Stack(
        children: [
          AnimatedContainer(
            alignment: Alignment(0, birdYAxis),
            duration: Duration(microseconds: 0),
            color: Colors.blue,
            child: MyDuck(),
          ),
          Container(
            alignment: Alignment(0, -0.3),
            child: gameHasStarted
                ? Text("")
                : Text(
                    "T A P  T O  P L A Y !",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
          ),
          AnimatedContainer(
            alignment: Alignment(barrierXOne, 1.3),
            duration: Duration(milliseconds: 0),
            child: MyBarrier(
              size: 200.0,
            ),
          ),
          AnimatedContainer(
            alignment: Alignment(barrierXOne, -1.7),
            duration: Duration(milliseconds: 0),
            child: MyBarrier(
              size: 200.0,
            ),
          ),
          AnimatedContainer(
            alignment: Alignment(barrierXTwo, 1.1),
            duration: Duration(milliseconds: 0),
            child: MyBarrier(
              size: 150.0,
            ),
          ),
          AnimatedContainer(
            alignment: Alignment(barrierXTwo, -1.8),
            duration: Duration(milliseconds: 0),
            child: MyBarrier(
              size: 250.0,
            ),
          ),
        ],
      ),
    );
  }

  Expanded getBottomContainerWithScoreUI() {
    return Expanded(
      child: Container(
        color: Colors.brown,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Score", style: TextStyle(color: Colors.white, fontSize: 20)),
                SizedBox(height: 20),
                Text("0", style: TextStyle(color: Colors.white, fontSize: 35)),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Best", style: TextStyle(color: Colors.white, fontSize: 20)),
                SizedBox(height: 20),
                Text("10", style: TextStyle(color: Colors.white, fontSize: 35)),
              ],
            )
          ],
        ),
      ),
    );
  }
}
