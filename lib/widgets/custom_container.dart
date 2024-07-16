import 'package:canteen_management/constants/theme_constants.dart';
import 'package:flutter/material.dart';

class CustomContainer extends StatelessWidget {
  final Widget child;
  final Color? color;
  final LinearGradient? gradient;
  const CustomContainer({
    super.key,
    this.color,
    this.gradient,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: color ?? Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: CustomThemeData.getShadow(),
        gradient: gradient,
      ),
      child: child,
    );
  }
}
