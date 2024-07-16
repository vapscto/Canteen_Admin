import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomGoBackButton extends StatelessWidget {
  const CustomGoBackButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        Get.back();
      },
      icon: const Icon(
        Icons.chevron_left_rounded,
        size: 32,
      ),
    );
  }
}
