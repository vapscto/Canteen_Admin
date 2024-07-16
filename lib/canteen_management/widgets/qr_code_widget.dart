import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrCodeWidgets extends StatelessWidget {
  final String amount;
  final String upiId;

  const QrCodeWidgets({super.key, required this.amount, required this.upiId});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey),
      ),
      child: QrImageView(
        data: 'upi://pay?pa=$upiId&am=$amount',
        version: QrVersions.auto,
        size: MediaQuery.of(context).size.width * 0.2,
      ),
    );
  }
}
