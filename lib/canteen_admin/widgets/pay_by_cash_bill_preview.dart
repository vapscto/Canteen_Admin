import 'dart:typed_data';

import 'package:canteen_management/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PayByCashBillPreview extends StatefulWidget {
  final Uint8List? rawData;

  const PayByCashBillPreview({super.key, required this.rawData});

  @override
  State<PayByCashBillPreview> createState() => _PayByCashBillPreviewState();
}

class _PayByCashBillPreviewState extends State<PayByCashBillPreview> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Preview', action: [
        IconButton(
            onPressed: () {
              printDocument('${DateTime.now().toIso8601String()}-food-bill');
            },
            icon: const Icon(Icons.print))
      ]).getAppBar(),
      body: widget.rawData != null
          ? SfPdfViewer.memory(widget.rawData!)
          : const SizedBox(),
    );
  }

  void printDocument(String name) {
    Printing.layoutPdf(
      name: "$name.Pdf",
      // usePrinterSettings: true,
      format: const PdfPageFormat(80, 80),
      onLayout: (PdfPageFormat format) {
        return Future.value(widget.rawData);
      },
    ).then((value) {
      if (value == true) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            elevation: 2,
            content: Text(
              "printed Successfully.",
              style: Get.textTheme.titleSmall!.copyWith(color: Colors.white),
            ),
            backgroundColor: Colors.green,
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            elevation: 2,
            content: Text(
              "Failed to print",
              style: Get.textTheme.titleSmall!.copyWith(color: Colors.white),
            ),
            backgroundColor: Colors.red,
          ),
        );
      }
    });
  }
}
