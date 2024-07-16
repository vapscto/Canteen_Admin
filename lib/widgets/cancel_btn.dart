import 'package:flutter/material.dart';

class RejectBtn extends StatelessWidget {
  final String title;
  final Size? size;
  final Function() onPress;
  const RejectBtn(
      {super.key, required this.title, this.size, required this.onPress});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        fixedSize: size,
        backgroundColor: Colors.red,
        padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 14.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
      ),
      onPressed: onPress,
      child: Text(
        title,
        style: Theme.of(context).textTheme.labelSmall!.merge(
          const TextStyle(
            color: Colors.white,
            letterSpacing: 0.3,
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
