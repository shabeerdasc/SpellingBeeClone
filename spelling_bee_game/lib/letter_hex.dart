import 'package:flutter/material.dart';
import 'package:spelling_bee_game/utils/colors.dart';
import 'package:spelling_bee_game/utils/constants.dart';

class LetterButton extends StatefulWidget {
  final List letters;
  final TextEditingController controller;
  final Function? delete;
  final Function? onSubmit;
  final Function? shuffle;
  final double buttonSize = 80;
  final Color buttonColor = const Color(0xffe6e6e6);
  const LetterButton({
    Key? key,
    required this.letters,
    required this.controller,
    required this.delete,
    required this.onSubmit,
    required this.shuffle,
  }) : super(key: key);

  @override
  State<LetterButton> createState() => _LetterButtonState();
}

class _LetterButtonState extends State<LetterButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      alignment: Alignment.center,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    height: widget.buttonSize / 2,
                  ),
                  HexButton(
                    char: widget.letters[1],
                    size: widget.buttonSize,
                    color: widget.buttonColor,
                    controller: widget.controller,
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  HexButton(
                    char: widget.letters[2],
                    size: widget.buttonSize,
                    color: widget.buttonColor,
                    controller: widget.controller,
                  ),
                  SizedBox(
                    height: widget.buttonSize / 2,
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  HexButton(
                    char: widget.letters[3],
                    size: widget.buttonSize,
                    color: widget.buttonColor,
                    controller: widget.controller,
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  HexButton(
                    char: widget.letters[0],
                    size: widget.buttonSize,
                    color: nytYellow,
                    controller: widget.controller,
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  HexButton(
                    char: widget.letters[4],
                    size: widget.buttonSize,
                    color: widget.buttonColor,
                    controller: widget.controller,
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    height: widget.buttonSize / 2,
                  ),
                  HexButton(
                    char: widget.letters[5],
                    size: widget.buttonSize,
                    color: widget.buttonColor,
                    controller: widget.controller,
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  HexButton(
                    char: widget.letters[6],
                    size: widget.buttonSize,
                    color: widget.buttonColor,
                    controller: widget.controller,
                  ),
                  SizedBox(
                    height: widget.buttonSize / 2,
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Expanded(
                child: Container(),
              ),
              OutlinedButton(
                onPressed: () => widget.delete!(),
                style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                  ),
                ),
                child: const Text(
                  "Delete",
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              MaterialButton(
                onPressed: () => widget.shuffle!(),
                shape: const CircleBorder(),
                color: Colors.white,
                child: const Icon(
                  Icons.shuffle,
                  color: Colors.black,
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              OutlinedButton(
                onPressed: () => widget.onSubmit!(),
                style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                  ),
                ),
                child: const Text(
                  "Enter",
                  style: TextStyle(color: Colors.black),
                ),
              ),
              Expanded(
                child: Container(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class HexButton extends StatelessWidget {
  final String char;
  final double size;
  final Color color;
  final TextEditingController controller;

  const HexButton(
      {Key? key,
      required this.char,
      required this.size,
      required this.color,
      required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {controller.text += char},
      child: CustomPaint(
        size: Size(size + 10, size),
        painter: Hexpainter(color),
        foregroundPainter: LetterPainter(char),
        //child: Text(char),
      ),
    );
  }
}

class LetterPainter extends CustomPainter {
  final String letter;
  const LetterPainter(this.letter);

  @override
  void paint(Canvas canvas, Size size) {
    final TextPainter textPainter = TextPainter(
      text: TextSpan(
        text: letter,
        style: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w600,
          fontSize: 30.0,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();

    textPainter.paint(
        canvas,
        Offset((size.width - textPainter.width) * 0.5,
            (size.height - textPainter.height) * 0.5));
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class Hexpainter extends CustomPainter {
  final Color color;
  const Hexpainter(this.color);
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    var path = Path()
      ..moveTo(size.width * hexFactor1, 0)
      ..lineTo(size.width * hexFactor2, 0)
      ..lineTo(size.width, size.height * 0.5)
      ..lineTo(size.width * hexFactor2, size.height)
      ..lineTo(size.width * hexFactor1, size.height)
      ..lineTo(0, size.height * 0.5)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

// class LetterButton extends StatelessWidget {
//   final List<String> letters = [];
//   final TextEditingController controller;
//   final Function? delete;
//   final Function? onSubmit;
//   final double buttonSize = 80;
//   final Color buttonColor = Colors.indigo;

//   // const LetterButton(
//   //     {this.buttonSize = 80,
//   //     this.buttonColor = Colors.indigo,
//   //     this.iconColor = Colors.amber,
//   //     required this.delete,
//   //     required this.onSubmit,
//   //     required this.controller});
//   LetterButton(
//       {Key? key,
//       required this.controller,
//       required this.delete,
//       required this.onSubmit})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.all(20),
//       alignment: Alignment.center,
//       child: Column(
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Column(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   SizedBox(
//                     height: buttonSize / 2,
//                   ),
//                   HexButton(
//                     char: "A",
//                     size: buttonSize,
//                     color: buttonColor,
//                     controller: controller,
//                   ),
//                   const SizedBox(
//                     height: 10.0,
//                   ),
//                   HexButton(
//                     char: "B",
//                     size: buttonSize,
//                     color: buttonColor,
//                     controller: controller,
//                   ),
//                   SizedBox(
//                     height: buttonSize / 2,
//                   ),
//                 ],
//               ),
//               Column(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   HexButton(
//                     char: "A",
//                     size: buttonSize,
//                     color: buttonColor,
//                     controller: controller,
//                   ),
//                   const SizedBox(
//                     height: 10.0,
//                   ),
//                   HexButton(
//                     char: "A",
//                     size: buttonSize,
//                     color: buttonColor,
//                     controller: controller,
//                   ),
//                   const SizedBox(
//                     height: 10.0,
//                   ),
//                   HexButton(
//                     char: "A",
//                     size: buttonSize,
//                     color: buttonColor,
//                     controller: controller,
//                   ),
//                 ],
//               ),
//               Column(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   SizedBox(
//                     height: buttonSize / 2,
//                   ),
//                   HexButton(
//                     char: "A",
//                     size: buttonSize,
//                     color: buttonColor,
//                     controller: controller,
//                   ),
//                   const SizedBox(
//                     height: 10.0,
//                   ),
//                   HexButton(
//                     char: "B",
//                     size: buttonSize,
//                     color: buttonColor,
//                     controller: controller,
//                   ),
//                   SizedBox(
//                     height: buttonSize / 2,
//                   ),
//                 ],
//               ),
//             ],
//           ),
//           const SizedBox(
//             height: 20,
//           ),
//           Row(
//             children: [
//               Expanded(
//                 child: Container(),
//               ),
//               OutlinedButton(
//                 onPressed: () => delete!(),
//                 style: ElevatedButton.styleFrom(
//                   primary: Colors.white,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(18.0),
//                   ),
//                 ),
//                 child: const Text(
//                   "Delete",
//                   style: TextStyle(
//                     color: Colors.black,
//                   ),
//                 ),
//               ),
//               const SizedBox(
//                 width: 5,
//               ),
//               MaterialButton(
//                 onPressed: () {},
//                 shape: const CircleBorder(),
//                 color: Colors.white,
//                 child: const Icon(
//                   Icons.shuffle,
//                   color: Colors.black,
//                 ),
//               ),
//               const SizedBox(
//                 width: 5,
//               ),
//               OutlinedButton(
//                 onPressed: () {},
//                 style: ElevatedButton.styleFrom(
//                   primary: Colors.white,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(18.0),
//                   ),
//                 ),
//                 child: const Text(
//                   "Enter",
//                   style: TextStyle(color: Colors.black),
//                 ),
//               ),
//               Expanded(
//                 child: Container(),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }