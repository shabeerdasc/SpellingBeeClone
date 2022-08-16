import 'package:flutter/material.dart';
import 'package:spelling_bee_game/letter_setting.dart';
import 'package:spelling_bee_game/utils/colors.dart';
import 'homepage.dart';
import 'utils/constants.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({Key? key}) : super(key: key);
  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  @override
  // void initState() {
  //   DateTime now = DateTime.now();
  //   DateTime date = DateTime(now.year, now.month, now.day);
  //   if (yesterday.toString() != date.toString()) {
  //     yesterday = date.toString();
  //     setting();
  //   }
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          color: nytYellow,
          child: Column(
            children: [
              SizedBox(
                height: 70,
                child: Container(
                  padding: const EdgeInsets.all(10),
                  alignment: Alignment.center,
                  child: const Text(
                    "Spelling Bee",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Expanded(child: Container()),
              Container(
                padding: const EdgeInsets.only(
                    left: 50, right: 50, top: 30, bottom: 20),
                width: double.infinity,
                child: const Text(
                  "How many words can you make with 7 letters?",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 22,
                    color: Color(0xff170000),
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Homepage()));
                },
                style: ElevatedButton.styleFrom(
                  fixedSize: const Size(120, 20),
                  primary: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                  ),
                ),
                child: const Text(
                  "Play",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              Expanded(
                child: Container(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
