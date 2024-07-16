import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class AnimatedProgressWidget extends StatelessWidget {
  final String title;
  final String desc;
  final double? animatorHeight;
  final String animationPath;
  const AnimatedProgressWidget(
      {super.key,
        required this.title,
        required this.desc,
        required this.animationPath,
        this.animatorHeight});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            LottieBuilder.asset(
              animationPath,
              height: animatorHeight ?? 100,
              //fit: BoxFit.cover,
            ),
            const SizedBox(
              height: 24.0,
            ),
            Text(
              title,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleSmall!.merge(
                const TextStyle(
                    fontSize: 16.0, fontWeight: FontWeight.w600),
              ),
            ),
            const SizedBox(
              height: 6.0,
            ),
            Text(
              desc,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.labelSmall!.merge(
                const TextStyle(
                  letterSpacing: 0.2,
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
