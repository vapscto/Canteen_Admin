import 'package:flutter/material.dart';

class SuccessWidget extends StatelessWidget {
  final String title;
  final String message;
  final Function() onPressed;
  const SuccessWidget(
      {super.key,
        required this.title,
        required this.message,
        required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const CircleAvatar(
            backgroundColor: Colors.green,
            radius: 36.0,
            child: Icon(
              Icons.check,
              color: Colors.white,
              size: 36,
            ),
          ),
          const SizedBox(
            height: 16.0,
          ),
          Text(
            title,
            style: Theme.of(context).textTheme.titleMedium!.merge(
              const TextStyle(fontSize: 20.0),
            ),
          ),
          const SizedBox(
            height: 8.0,
          ),
          Text(
            message,
            style: Theme.of(context).textTheme.labelMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 16.0,
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0),
                )),
            onPressed: onPressed,
            child: Text(
              "OK",
              style: Theme.of(context).textTheme.titleMedium!.merge(
                const TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
