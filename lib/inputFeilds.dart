import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class CustomInputFeilds extends StatefulWidget {
  final double width;
  final String hintText;
  final TextEditingController? editingController;
  const CustomInputFeilds({super.key, required this.hintText, this.editingController, required this.width});
  @override
  State<CustomInputFeilds> createState() => _CustomInputFeildsState();
}

class _CustomInputFeildsState extends State<CustomInputFeilds> {
  bool active = false;
  late bool isPassFeild = widget.hintText == 'Password' || widget.hintText == 'Set a Password';
  bool passVisible = false;
  late bool numericalKeyboard = widget.hintText == 'Mobile';
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: widget.width,
          height: 60,
          decoration: const BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.only(bottomRight: Radius.circular(10))
          ),
        ),
        AnimatedPadding(
          duration: const Duration(milliseconds: 300),
          padding: active?const EdgeInsets.only(left: 3, top: 3):const EdgeInsets.all(0),
          child: Container(
              width: widget.width,
              height: 60,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(width: 1),
              borderRadius: const BorderRadius.only(bottomRight: Radius.circular(10))
            ),
            child: Row(
              children: [
                const SizedBox(width: 15,),
                Expanded(
                  child: TextField(
                    controller: widget.editingController,
                    cursorColor: const Color.fromARGB(255, 0, 0, 0),
                    onTap: () {
                      setState(() {
                        active = true;
                      });
                    },
                    onSubmitted: (e) {
                      setState(() {
                        active = false;
                        FocusManager.instance.primaryFocus?.unfocus();
                      });
                    },
                    onTapOutside: (e) {
                      setState(() {
                        active = false;
                      });
                    },
                    onEditingComplete: () {
                      setState(() {
                        active = false;
                      });
                    },
                    inputFormatters: numericalKeyboard?[FilteringTextInputFormatter.digitsOnly]:[],
                    obscureText: isPassFeild?(!passVisible?true:false):false,
                    keyboardType: numericalKeyboard?TextInputType.number:null,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: widget.hintText,
                    ),
                  )
                ),
                const SizedBox(width: 15,),

                isPassFeild?Row(
                  children: [
                    GestureDetector(
                      onTap: (){
                        setState(() {
                          passVisible = !passVisible;
                        });
                      },
                      child: Icon(passVisible?Icons.circle_outlined:Icons.circle)),
                    const SizedBox(width: 15,),
                  ],
                ):const SizedBox(),
              ],
            ),
          ),
        ),
      ],
    );
  }
}