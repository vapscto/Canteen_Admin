import 'dart:typed_data';

import 'package:canteen_management/canteen_admin/admin_api/admin_api.dart';
import 'package:canteen_management/controller/global_utility.dart';
import 'package:canteen_management/controller/mskool_controller.dart';
import 'package:canteen_management/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class KioskBillPreview extends StatelessWidget {
  final Uint8List? rawData;
  final String name;
  final String orderId;
  final MskoolController mskoolController;

  const KioskBillPreview(
      {super.key,
      this.rawData,
      required this.name,
      required this.orderId,
      required this.mskoolController});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Preview', action: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: IconButton(
              onPressed: () {
      Printing.layoutPdf(
        name: "$name.Pdf",
        usePrinterSettings: false,
        onLayout: (PdfPageFormat format) {
          format = format.copyWith(
            marginTop: -15,
            marginBottom: 0,
            marginLeft: 0,
            marginRight: 0,
          );
          return Future.value(rawData);
        },
      ).then((value) async {
        if (value == true) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              elevation: 2,
              content: Text(
                "printed Successfully.",
                style: Get.textTheme.titleSmall!.copyWith(color: Colors.white),
              ),
              backgroundColor: Colors.green,
            ),
          );
          await oneTimePrint(
              base: baseUrlFromInsCode(
                  "canteen", mskoolController),
              orderId: int.parse(orderId));

        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
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
              },
              icon: const Icon(
                Icons.print,
                color: Colors.white,
              )),
        )
      ]).getAppBar(),
      body: rawData != null
          ? SfPdfViewer.memory(rawData!)
          : Column(
              children: [
                Icon(
                  Icons.preview_outlined,
                  size: 36.0,
                  color: Theme.of(context).primaryColor,
                ),
                const SizedBox(
                  height: 8.0,
                ),
                Text(
                  "No Preview Available",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleMedium!.merge(
                        const TextStyle(fontSize: 18),
                      ),
                ),
              ],
            ),
    );
  }
  // Future<void> printPdf(Uint8List rawData, String name, BuildContext c) async {
  //   final PdfPageFormat customFormat = PdfPageFormat(
  //     PdfPageFormat.a4.width,
  //     PdfPageFormat.a4.height,
  //     marginAll: 0,
  //   );
  //
  //   await Printing.layoutPdf(
  //     name: "$name.pdf",
  //     usePrinterSettings: false,
  //     onLayout: (PdfPageFormat format) {
  //       return Future.value(rawData);
  //     },
  //     format: customFormat, // Use the custom format with zero margins
  //   ).then((value) async{
  //     if (value == true) {
  //       await oneTimePrint(
  //           base: baseUrlFromInsCode(
  //               "canteen", mskoolController),
  //           orderId: int.parse(orderId));
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(
  //           shape:
  //           RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
  //           elevation: 2,
  //           content: Text(
  //             "printed Successfully.",
  //             style: Get.textTheme.titleSmall!.copyWith(color: Colors.white),
  //           ),
  //           backgroundColor: Colors.green,
  //         ),
  //       );
  //     } else {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(
  //           shape:
  //           RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
  //           elevation: 2,
  //           content: Text(
  //             "Failed to print",
  //             style: Get.textTheme.titleSmall!.copyWith(color: Colors.white),
  //           ),
  //           backgroundColor: Colors.red,
  //         ),
  //       );
  //     }
  //   });
  // }
}
