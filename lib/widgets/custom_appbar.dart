import 'package:flutter/material.dart';
import 'custom_back_button.dart';

class CustomAppBar {
  final String title;
  final List<Widget>? action;
  final PreferredSize? bottom;
  const CustomAppBar({
    required this.title,
    this.action,
    this.bottom,
  });

  PreferredSizeWidget getAppBar() {
    return AppBar(
      elevation: 0,
      title: Text(
        title,
      ),
      leadingWidth: 30.0,
      actions: action,
      bottom: bottom,
      leading: const CustomGoBackButton(),
    );
  }
}
