import 'dart:math';

import 'package:flutter/material.dart';
import 'package:spelling_bee_game/letter_setting.dart';
import 'package:spelling_bee_game/scoring.dart';
import 'package:spelling_bee_game/utils/colors.dart';
import 'package:spelling_bee_game/utils/constants.dart';
import 'package:spelling_bee_game/words.dart';
import './letter_hex.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final TextEditingController mycontroller = TextEditingController();
  final Scoring _score = Scoring();
  //final List<String> _letterList = allLetters;
  List _letters = initialList;
  final List<String> _foundWords = [];
  int score = 0;
  late String state = _score.states[0];

  @override
  void initState() {
    Random random = Random();
    int randomNumber = random.nextInt(16600);
    String val = scrambleLetters[randomNumber];
    _letters = val.toUpperCase().split('');
    // _letterList.shuffle();
    // _letters = _letterList.sublist(0, 7);
    // DateTime now = DateTime.now();
    // DateTime date = DateTime(now.year, now.month, now.day);
    // if (yesterday.toString() != date.toString()) {
    //   yesterday = date.toString();
    //   setting();
    // }

    super.initState();
  }

  void _shuffle() {
    var list2 = _letters.sublist(1);
    list2.shuffle();
    var a = _letters.sublist(0, 1);
    var newList = a + list2;
    setState(() {
      _letters = newList;
    });
  }

  void _wordCheck() {
    var word = mycontroller.text.toLowerCase();
    if (word.contains(_letters[0].toString().toLowerCase()) != true) {
      dialog("Missing center letter", context, Colors.black, Colors.white);
    } else if (word.length < 4) {
      dialog("Too short", context, Colors.black, Colors.white);
    } else if (_foundWords.contains(word.capitalize())) {
      dialog("Already found", context, Colors.black, Colors.white);
    } else if (Scoring.isPanagram(
        word, _letters.join().toLowerCase().split(''))) {
      dialog("Panagram", context, nytYellow, Colors.black);
      setState(() {
        _foundWords.add(word.capitalize());
        score += 7 + word.length;
        int percent = _score.percentScore(_letters.join().toLowerCase(), score);
        state = _score.states[percent];
      });
    } else if (allWords.contains(word) &&
        word.contains(_letters[0].toString().toLowerCase())) {
      dialog(
          _score.getMessage(word.length), context, Colors.white, Colors.black);
      setState(() {
        _foundWords.add(word.capitalize());
        score += word.length == 4 ? 1 : word.length;
        int percent = _score.percentScore(_letters.join().toLowerCase(), score);
        state = _score.states[percent];
      });
    } else {
      dialog("Not in word list", context, Colors.black, Colors.white);
    }

    mycontroller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(40),
        child: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.5,
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
          ),
        ),
      ),
      body: Container(
          color: Colors.white,
          child: Column(
            children: [
              ScoreWidget(
                score: score,
                letters: _letters.join().toLowerCase(),
                state: state,
              ),
              // SizedBox(
              //   height: 50,
              //   width: double.infinity,
              //   child: Container(
              //     padding: const EdgeInsets.only(
              //         top: 15, bottom: 10, left: 10, right: 10),
              //     child: Row(
              //       children: [
              //         Text(
              //           "Beginner",
              //           style: TextStyle(
              //             fontSize: 18,
              //             fontWeight: FontWeight.bold,
              //           ),
              //         ),
              //         Container(
              //           margin: const EdgeInsets.only(left: 10),
              //           //padding: const EdgeInsets.all(4),
              //           alignment: Alignment.center,
              //           height: 30,
              //           width: 30,

              //           decoration: const BoxDecoration(
              //             shape: BoxShape.circle,
              //             color: nytYellow,
              //           ),
              //           child: Text(
              //             score.toString(),
              //             style: const TextStyle(fontSize: 15),
              //           ),
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
              _foundWords.isNotEmpty
                  ? SizedBox(
                      height: 60,
                      width: double.infinity,
                      child: Container(
                          margin: const EdgeInsets.only(
                              bottom: 10, left: 10, right: 10),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey,
                              width: 2.0,
                            ),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            padding: const EdgeInsets.only(
                              right: 10.0,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              textDirection: TextDirection.ltr,
                              children:
                                  _foundWords.reversed.toList().map((word) {
                                return Container(
                                  margin: const EdgeInsets.only(left: 8),
                                  child: Text(
                                    word,
                                    style: const TextStyle(
                                      fontSize: 17,
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          )),
                    )
                  : SizedBox(
                      height: 60,
                      child: Container(
                        margin: const EdgeInsets.only(
                            bottom: 10, left: 10, right: 10),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey,
                            width: 2.0,
                          ),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                      ),
                    ),
              Expanded(
                child: Container(
                  color: Colors.white,
                ),
              ),
              TextField(
                controller: mycontroller,
                showCursor: false,
                style: const TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.center,
                keyboardType: TextInputType.none,
                enableInteractiveSelection: false,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: "Type Here",
                ),
              ),
              SizedBox(
                height: 10,
                child: Container(),
              ),
              LetterButton(
                controller: mycontroller,
                letters: _letters,
                delete: () {
                  if (mycontroller.text.isNotEmpty) {
                    mycontroller.text = mycontroller.text
                        .substring(0, mycontroller.text.length - 1);
                  }
                },
                shuffle: _shuffle,
                onSubmit: _wordCheck,
              ),
              SizedBox(
                height: 10,
                child: Container(),
              ),
              Expanded(
                child: Container(),
              ),
            ],
          )),
    );
  }

  Future dialog(
      String message, BuildContext context, Color color, Color textColor) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          Future.delayed(const Duration(milliseconds: 800), () {
            Navigator.of(context).pop(true);
          });
          return Dialog(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
            child: Container(
              color: color,
              height: 30,
              width: 50,
              padding: const EdgeInsets.all(8),
              alignment: Alignment.center,
              child: Text(
                message,
                style: TextStyle(
                  color: textColor,
                ),
              ),
            ),
          );
        });
  }
}
