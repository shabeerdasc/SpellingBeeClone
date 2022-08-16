import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:spelling_bee_game/utils/colors.dart';

class ScoreAdder extends StatefulWidget {
  const ScoreAdder({Key? key}) : super(key: key);

  @override
  State<ScoreAdder> createState() => _ScoreAdderState();
}

class _ScoreAdderState extends State<ScoreAdder> {
  bool isOn = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: 70,
          width: double.infinity,
          //color: Colors.red,
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              circleNumber(),
              horizontalLine(),
              isOn ? greyCircle() : circleNumber(),
              horizontalLine(),
              circleNumber(),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            if (isOn) {
              isOn = false;
            } else {
              isOn = true;
            }
          });
        },
      ),
    );
  }
}

Widget circleNumber() {
  return Container(
    alignment: Alignment.center,
    height: 37,
    width: 37,
    decoration: const BoxDecoration(
      shape: BoxShape.circle,
      color: nytYellow,
    ),
    child: const Text(
      "23",
      style: TextStyle(fontSize: 15),
    ),
  );
}

Widget horizontalLine() {
  return Container(
    height: 1,
    width: 30,
    color: nytGrey,
  );
}

Widget greyCircle() {
  return Container(
    height: 9,
    width: 9,
    decoration: const BoxDecoration(
      shape: BoxShape.circle,
      color: nytGrey,
    ),
  );
}
