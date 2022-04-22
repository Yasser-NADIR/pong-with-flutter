// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:pong_game/pong.dart';

void main(List<String> args) => runApp(MyApp());

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "Pong game",
        theme: ThemeData(
          primaryColor: Colors.blue,
        ),
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(
            title: Text("Ping Pong Game"),
          ),
          body: Pong(),
        ));
  }
}
