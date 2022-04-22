import 'package:flutter/material.dart';

class Ball extends StatelessWidget {
  final double diam = 50;
  const Ball({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: diam,
      height: diam,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.yellow,
      ),
    );
  }
}
