import 'dart:math';

import 'package:flutter/material.dart';
import 'package:spelling_bee_game/words.dart';
import './letter_hex.dart';

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
      home: Homepage(),
    );
  }
}

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final TextEditingController mycontroller = TextEditingController();
  final List<String> _letterList = allLetters;
  late List _letters;
  final List<String> _foundWords = [];

  @override
  void initState() {
    _letterList.shuffle();
    _letters = _letterList.sublist(0, 7);
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
    if (allWords.contains(word)) {
      setState(() {
        _foundWords.add(word.capitalize());
      });
    } else {
      print("not in word list");
    }

    mycontroller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Spelling Bee"),
      ),
      body: Container(
          color: Colors.white,
          child: Column(
            children: [
              // SizedBox(
              //   height: 70,
              //   child: Container(
              //     color: Colors.red,
              //   ),
              // ),
              _foundWords.isNotEmpty
                  ? SizedBox(
                      height: 70,
                      width: double.infinity,
                      child: Container(
                          margin: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey,
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
                              children: _foundWords.map((word) {
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
                      height: 70,
                      child: Container(
                        margin: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey,
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
}
