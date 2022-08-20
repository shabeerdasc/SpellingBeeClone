import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:spelling_bee_game/utils/colors.dart';

class ScoreAdder extends StatefulWidget {
  final List levelList;
  final int score;
  const ScoreAdder({Key? key, required this.levelList, required this.score})
      : super(key: key);

  @override
  State<ScoreAdder> createState() => _ScoreAdderState();
}

class _ScoreAdderState extends State<ScoreAdder> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      //width: double.infinity,
      //color: Colors.red,
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          widget.levelList[0] ? circleNumber(widget.score) : greyCircle(),
          horizontalLine(),
          widget.levelList[1] ? circleNumber(widget.score) : greyCircle(),
          horizontalLine(),
          widget.levelList[2] ? circleNumber(widget.score) : greyCircle(),
          horizontalLine(),
          widget.levelList[3] ? circleNumber(widget.score) : greyCircle(),
          horizontalLine(),
          widget.levelList[4] ? circleNumber(widget.score) : greyCircle(),
          horizontalLine(),
          widget.levelList[5] ? circleNumber(widget.score) : greyCircle(),
          horizontalLine(),
          widget.levelList[6] ? circleNumber(widget.score) : greyCircle(),
          horizontalLine(),
          widget.levelList[7] ? circleNumber(widget.score) : greyCircle(),
          horizontalLine(),
          widget.levelList[8] ? circleNumber(widget.score) : greyCircle(),
        ],
      ),
    );
  }
}

Widget circleNumber(int number) {
  return Container(
    alignment: Alignment.center,
    height: 37,
    width: 37,
    decoration: const BoxDecoration(
      shape: BoxShape.circle,
      color: nytYellow,
    ),
    child: Text(
      "$number",
      style: const TextStyle(fontSize: 15),
    ),
  );
}

Widget horizontalLine() {
  return Container(
    height: 1,
    width: 25,
    color: nytGrey,
  );
}

Widget greyCircle() {
  return Container(
    height: 8,
    width: 8,
    decoration: const BoxDecoration(
      shape: BoxShape.circle,
      color: nytGrey,
    ),
  );
}
