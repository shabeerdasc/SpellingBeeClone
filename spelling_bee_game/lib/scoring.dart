import 'package:flutter/cupertino.dart';
import 'package:spelling_bee_game/scorewidget.dart';
import 'package:spelling_bee_game/words.dart';

class Scoring {
  Map states = {
    0: 'Beginner',
    1: 'Good Start',
    5: 'Moving Up',
    7: 'Good',
    10: 'Solid',
    25: 'Nice',
    35: 'Great',
    45: 'Amazing',
    60: 'Genius',
    //100: 'Queen Bee'
  };
  static Map statesMap = {
    'Beginner': 0,
    'Good Start': 1,
    'Moving Up': 2,
    'Good': 3,
    'Solid': 4,
    'Nice': 5,
    'Great': 6,
    'Amazing': 7,
    'Genius': 8,
    //100: 'Queen Bee'
  };

  Map messages = {4: 'Good!', 5: 'Nice!', 6: 'Nice', 7: 'Awesome!'};

  static bool isPanagram(String word, List letters) {
    return word.toLowerCase().split('').toSet().containsAll(letters);
  }

  int maxScore(String letters) {
    final regexp =
        RegExp(r'^[' + letters + r']*' + letters[0] + r'[' + letters + r']*$');
    List possibleWords = [];
    // int score = 0;
    for (final e in allWords) {
      if (e.length > 3) {
        if (regexp.hasMatch(e)) {
          final match = regexp.firstMatch(e);
          final matchedText = match?.group(0).toString();
          possibleWords.add(matchedText);
        }
      }
    }
    // for (String w in possibleWords) {
    //   if (isPanagram(w, letters.toLowerCase().split(''))) {
    //     score += 7 + w.length;
    //   } else if (w.length == 4) {
    //     score += 1;
    //   } else {
    //     score += w.length;
    //   }
    // }
    return possibleWords.length;
  }

  int percentScore(String letters, int score) {
    //int max = maxScore(letters);
    int max = maxScore(letters);
    int percent = ((score / max) * 100).floor();
    int mappedPercent = 0;
    for (var e in states.keys) {
      if (percent >= e) {
        mappedPercent = e;
      }
    }
    return mappedPercent;
  }

  String getMessage(int length) {
    int message = 4;
    if (length > 7) {
      return messages[7];
    }
    for (var e in messages.keys) {
      if (length >= e) {
        message = e;
      }
    }
    return messages[message];
  }
}

class ScoreWidget extends StatefulWidget {
  final int score;
  final String letters;
  final String state;
  const ScoreWidget(
      {Key? key,
      required this.score,
      required this.letters,
      required this.state})
      : super(key: key);

  @override
  State<ScoreWidget> createState() => _ScoreWidgetState();
}

class _ScoreWidgetState extends State<ScoreWidget> {
  List levels = [false, false, false, false, false, false, false, false, false];
  @override
  void initState() {
    int index = Scoring.statesMap[widget.state];
    levels[index] = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    int index = Scoring.statesMap[widget.state];
    levels[index] = true;
    if (index > 0) {
      levels[index - 1] = false;
    }
    return Container(
      height: 50,
      width: double.infinity,
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            widget.state,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          ScoreAdder(
            levelList: levels,
            score: widget.score,
          )
        ],
      ),
    );
  }
}
