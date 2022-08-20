import 'package:flutter/material.dart';
import 'package:spelling_bee_game/start_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: "Spelling Bee",
      debugShowCheckedModeBanner: false,
      home: MenuPage(),
      // home: ScoreAdder(
      //   levelList: [
      //     true,
      //     false,
      //     false,
      //     false,
      //     false,
      //     false,
      //     false,
      //     false,
      //     false
      //   ],
      // ),
    );
  }
}
