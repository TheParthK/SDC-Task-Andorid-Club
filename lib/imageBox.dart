import 'package:flutter/material.dart';

class CustomImageBox extends StatelessWidget {
  final Size size;
  final Image ? image;
  const CustomImageBox({super.key, required this.size, this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size.height/5.5,
      width: size.height/5.5,
      decoration: BoxDecoration(
        color: Colors.white,
        // image: const DecorationImage(image: NetworkImage(''), fit: BoxFit.cover),
        border: Border.all(width: 1, color: Colors.black),
        // borderRadius: BorderRadius.all(Radius.circular(size.height/10)),
      ),
      child: Center(
        child: Material(
          borderRadius: BorderRadius.all(Radius.circular(size.height/10)),
          child: image ?? const Text(
            '-add an image-',
            style: TextStyle(fontSize: 12),
          ),
        ),
      ),
    );
  }
}