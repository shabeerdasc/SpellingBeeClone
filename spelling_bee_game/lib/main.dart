import 'package:flutter/material.dart';
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
  final TextEditingController controller = TextEditingController();
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
              SizedBox(
                height: 70,
                child: Container(
                  color: Colors.red,
                ),
              ),
              Expanded(
                child: Container(
                  color: Colors.white,
                ),
              ),
              TextField(
                controller: controller,
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
                controller: controller,
                letters: const ['A', 'B', 'C', 'D', 'E', 'F', 'G'],
                delete: () {
                  if (controller.text.isNotEmpty) {
                    controller.text = controller.text
                        .substring(0, controller.text.length - 1);
                  }
                },
                onSubmit: null,
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
