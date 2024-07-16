import 'package:canteen_management/canteen_admin/admin_api/admin_api.dart';
import 'package:canteen_management/controller/global_utility.dart';
import 'package:canteen_management/controller/mskool_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../../widgets/custom_appbar.dart';
import '../admin_controller/admin_controller.dart';

// ignore: must_be_immutable
class AdminBillPreview extends StatefulWidget {
  final Uint8List? rawData;
  final String orderId;
  final String name;
  final MskoolController mskoolController;

  const AdminBillPreview(
      {super.key,
      this.rawData,
      required this.orderId,
      required this.name,
      required this.mskoolController});

  @override
  State<AdminBillPreview> createState() => _AdminBillPreviewState();
}

class _AdminBillPreviewState extends State<AdminBillPreview> {

  @override
  void initState() {
    super.initState();
    _showIconAfterDelay();
  }

  void _showIconAfterDelay() {
    Future.delayed(const Duration(milliseconds: 800), () {
      setState(() {
      });
    });
  }
  AdminController controller = Get.put(AdminController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  const CustomAppBar(title: 'Preview', action: [
             Padding(
                padding:
                    EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                child: Row(
                  children: [
                    SizedBox(width: 10),
                    // IconButton(
                    //     onPressed: () async {
                    //       await quickSearch(
                    //           base: baseUrlFromInsCode(
                    //               'canteen', widget.mskoolController),
                    //           orderId: int.parse(widget.orderId),
                    //           controller:controller, flag: '')
                    //           .then((value) async {
                    //         if (value!.values!.isNotEmpty) {
                    //               printDocument('${widget.name}-${widget.orderId}', int.parse(widget.orderId));
                    //         } else {
                    //           ScaffoldMessenger.of(context).showSnackBar(
                    //             SnackBar(
                    //               elevation: 2,
                    //               content: Text(
                    //                 "Already been printed",
                    //                 style: Get.textTheme.titleSmall!
                    //                     .copyWith(color: Colors.white),
                    //               ),
                    //               backgroundColor: Colors.red,
                    //             ),
                    //           );
                    //         }
                    //         setState(() {});
                    //       });
                    //     },
                    //     icon: const Icon(
                    //       Icons.print,
                    //       color: Colors.white,
                    //     )),
                  ],
                ),
              )
          ,
      ]).getAppBar(),
      body: widget.rawData != null
          ? SfPdfViewer.memory(widget.rawData!)
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


  void printDocument(String name, int id) {
      Printing.layoutPdf(
        name: "$name.Pdf",
        usePrinterSettings: true,
        format: const PdfPageFormat(80, 80),
        onLayout: (PdfPageFormat format) {
          return Future.value(widget.rawData);
        },
      ).then((value) async {
        if (value == true) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              elevation: 2,
              duration: const Duration(seconds: 1),
              content: Text(
                "printed Successfully.",
                style: Get.textTheme.titleSmall!.copyWith(color: Colors.white),
              ),
              backgroundColor: Colors.green,
            ),
          );
          await oneTimePrint(
          base: baseUrlFromInsCode(
              "canteen", widget.mskoolController),
          orderId: id);

        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              elevation: 2,
              duration: const Duration(seconds: 1),
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
