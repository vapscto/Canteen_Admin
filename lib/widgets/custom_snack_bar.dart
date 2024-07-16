import 'package:flutter/material.dart';

class CustomSnackBar extends StatelessWidget {
  final String message;
  final double width;
  final double height;
  final Color backgroundColor;

  const CustomSnackBar({
    Key? key,
    required this.message,
    this.width = 100.0,
    this.height = 50.0,
    this.backgroundColor = Colors.black87,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        width: width,
        height: height,
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Center(
          child: Text(
            message,
            style: const TextStyle(color: Colors.white),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
