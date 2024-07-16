import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CardWidget extends StatelessWidget {
  final Color color;
  final String title;
  final String value;
  final Icon icon;
  final TextStyle style;

  const CardWidget(
      {super.key,
      required this.color,
      required this.title,
      required this.value,
      required this.icon, required this.style});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      color: color,
      elevation: 100,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  value,
                  style: style,
                ),
                Text(
                  title,
                  style: Get.textTheme.titleMedium!
                      .copyWith(color: Theme.of(context).secondaryHeaderColor),
                )
              ],
            ),
            Align(
              alignment: Alignment.topRight,
              child: (icon),
            )
          ],
        ),
      ),
    );
  }
}
