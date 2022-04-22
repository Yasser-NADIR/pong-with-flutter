// ignore_for_file: prefer_const_constructors, curly_braces_in_flow_control_structures

import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'ball.dart';
import 'bat.dart';

class Pong extends StatefulWidget {
  const Pong({Key? key}) : super(key: key);

  @override
  State<Pong> createState() => _PongState();
}

class _PongState extends State<Pong> with SingleTickerProviderStateMixin {
  double width = 0;
  double height = 0;
  double posX = 0;
  double posY = 0;
  double batWidth = 0;
  double batHeight = 0;
  double batPosition = 0;
  late Animation<double> animation;
  late AnimationController controller;
  var vDir = Direction.down;
  var hDir = Direction.right;
  double vSpeed = 9;
  double hSpeed = 3;
  double randX = 1;
  double randY = 1;
  int score = -1;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => LayoutBuilder(
        builder: (context, constraints) {
          width = constraints.maxWidth;
          height = constraints.maxHeight;
          batWidth = width / 5;
          batHeight = height / 20;
          return Stack(
            children: [
              Positioned(
                child: Text("Score: $score"),
                top: 0,
                right: 0,
              ),
              Positioned(
                child: Ball(),
                top: posY,
                left: posX,
              ),
              Positioned(
                bottom: 0,
                left: batPosition,
                child: GestureDetector(
                  onHorizontalDragUpdate: (details) {
                    move(details);
                  },
                  child: Bat(
                    width: batWidth,
                    height: batHeight,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  @override
  void initState() {
    posX = 0;
    posY = 0;
    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 100000000000000000),
    );
    animation = Tween<double>(begin: 0, end: 100).animate(controller);
    animation.addListener(() {
      safeSetState(() {
        var increment = 8;
        (hDir == Direction.right)
            ? posX += (increment * randX).round()
            : posX -= (increment * randX).round();
        (vDir == Direction.down)
            ? posY += (increment * randY).round()
            : posY -= (increment * randY).round();
      });
      checkBorders();
    });
    controller.forward();
    super.initState();
  }

  void checkBorders() {
    if (posX <= 0 && hDir == Direction.left) {
      hDir = Direction.right;
      randX = randomNumber();
    }
    if (posX >= width - 50 && hDir == Direction.right) {
      hDir = Direction.left;
      randX = randomNumber();
    }
    if (posY >= height - 50 - batHeight && vDir == Direction.down) {
      if (posX >= batPosition - 50 && posX <= batPosition + 50 + batWidth) {
        vDir = Direction.up;
        randY = randomNumber();
        safeSetState(() {
          score++;
        });
      } else {
        controller.stop();
        showDialog(
          context: context,
          builder: (buildContext) {
            return AlertDialog(
              title: Text(
                "You Lost",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
              content: Text(
                "Your score is : $score",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
              actions: [
                MaterialButton(
                  onPressed: () {
                    posX = 0;
                    posY = 0;
                    batPosition = 0;
                    score = 0;
                    Navigator.of(context).pop();
                    controller.forward();
                  },
                  child: Text(
                    "Restart",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                    ),
                  ),
                )
              ],
              
            );
          },
        );
        //dispose();
      }
    }
    if (posY <= 0 && vDir == Direction.up) {
      vDir = Direction.down;
      randY = randomNumber();
    }
  }

  void move(DragUpdateDetails update) {
    safeSetState(() {
      if (update.delta.dx >= 0 && batPosition < width - batWidth)
        batPosition += update.delta.dx;
      if (update.delta.dx <= 0 && batPosition >= 0)
        batPosition += update.delta.dx;
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void safeSetState(Function function) {
    if (mounted && controller.isAnimating) {
      setState(() => function());
    }
  }

  double randomNumber() {
    var rand = Random();
    int Num = rand.nextInt(101);
    return (50 + Num) / 150;
  }
}

enum Direction { up, down, left, right }
