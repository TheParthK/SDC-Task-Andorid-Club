import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatefulWidget {
  final Size size;
  final VoidCallback buttonAction;
  const CustomButton({
    required this.size,
    super.key, required this.buttonAction,
    });

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  bool pressed = false;
  @override
  Widget build(BuildContext context) {
    double width = widget.size.width/2;
    double height = 55;
    return  GestureDetector(
      onTap: widget.buttonAction,
      onTapDown: (details) {
        setState(() {
          pressed = true;
        });
      },
      onTapUp: (details) {
        setState(() {
          pressed = false;
        });
      },
      onTapCancel: () {
        setState(() {
          pressed = false;
        });
      },
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 3, right: 2),
            child: Container(
              width: width,
              height: height,
              decoration: const BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.all(Radius.circular(30))
              ),
            ),
          ),
          AnimatedPadding(
            duration: const Duration(milliseconds: 100),
            padding: !pressed?const EdgeInsets.only(top: 3.0, left: 2):const EdgeInsets.all(0),
            child: Container(
              width: width,
              height: height,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 247, 247, 247),
                borderRadius: const BorderRadius.all(Radius.circular(30)),
                border: Border.all(width: 1, color: const Color.fromARGB(255, 0, 0, 0))
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 100),
                    width: !pressed?0:20,
                  ),
                  const Icon(CupertinoIcons.arrow_right),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}