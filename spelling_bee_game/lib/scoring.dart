import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:spelling_bee_game/words.dart';
import 'utils/colors.dart';

class Scoring {
  Map states = {
    0: 'Beginner',
    2: 'Good Start',
    7: 'Moving Up',
    10: 'Good',
    20: 'Solid',
    35: 'Nice',
    55: 'Great',
    70: 'Amazing',
    90: 'Genius',
    100: 'Queen Bee'
  };

  Map messages = {4: 'Good!', 5: 'Nice!', 6: 'Nice', 7: 'Awesome!'};

  static bool isPanagram(String word, List letters) {
    return word.toLowerCase().split('').toSet().containsAll(letters);
  }

  int maxScore(String letters) {
    final regexp =
        RegExp(r'^[' + letters + r']*' + letters[0] + r'[' + letters + r']*$');
    List possibleWords = [];
    int score = 0;
    for (final e in allWords) {
      if (e.length > 3) {
        if (regexp.hasMatch(e)) {
          final match = regexp.firstMatch(e);
          final matchedText = match?.group(0).toString();
          possibleWords.add(matchedText);
        }
      }
    }
    for (String w in possibleWords) {
      if (isPanagram(w, letters.toLowerCase().split(''))) {
        score += 7 + w.length;
      } else {
        score += w.length;
      }
    }
    return score;
  }

  int percentScore(String letters, int score) {
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
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: double.infinity,
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: Row(
        children: [
          Text(
            widget.state,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 10),
            //padding: const EdgeInsets.all(4),
            alignment: Alignment.center,
            height: 37,
            width: 37,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: nytYellow,
            ),
            child: Text(
              widget.score.toString(),
              style: const TextStyle(fontSize: 15),
            ),
          ),
        ],
      ),
    );
  }
}



// panagram == 7
// 4 letter 4
// 5 5

// beginner 0
// good start 2
// moving up 5
// good 8
// solid 15
// nice 25
// great 40
// Amazing 50
// genius 70
// Queen bee 90
