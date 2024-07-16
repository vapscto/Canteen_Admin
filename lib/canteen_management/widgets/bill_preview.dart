import 'package:canteen_management/canteen_admin/admin_api/admin_api.dart';
import 'package:canteen_management/canteen_admin/admin_controller/admin_controller.dart';
import 'package:canteen_management/controller/global_utility.dart';
import 'package:canteen_management/controller/mskool_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../../widgets/custom_appbar.dart';

// ignore: must_be_immutable
class BillPreview extends StatefulWidget {
  final Uint8List? rawData;
  final bool loadFromRawData;
  final String name;
  final String orderId;
  final MskoolController mskoolController;

  const BillPreview(
      {super.key,
      this.rawData,
      required this.loadFromRawData,
      required this.name,
      required this.orderId,
      required this.mskoolController});

  @override
  State<BillPreview> createState() => _BillPreviewState();
}

class _BillPreviewState extends State<BillPreview> {
  bool _isVisible = false;

  @override
  void initState() {
    super.initState();
    _showIconAfterDelay();
  }

  void _showIconAfterDelay() {
    Future.delayed(const Duration(milliseconds: 800), () {
      setState(() {
        _isVisible = true;
      });
    });
  }

  AdminController controller = Get.put(AdminController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Preview', action: [
        _isVisible
            ? Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                child: IconButton(
                    onPressed: () async {
                      await quickSearch(
                              base: baseUrlFromInsCode(
                                  'canteen', widget.mskoolController),
                              orderId: int.parse(widget.orderId),
                              controller: controller, flag: '')
                          .then((value) async {
                        if (value!.values!.isNotEmpty) {
                          await oneTimePrint(
                                  base: baseUrlFromInsCode(
                                      "canteen", widget.mskoolController),
                                  orderId: value.values!.last.cMOrderID!)
                              .then((value) {
                            if (value!.values!.isNotEmpty) {
                              printDocument('${widget.name}-${widget.orderId}');
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  elevation: 2,
                                  content: Text(
                                    "Already been printed. ",
                                    style: Get.textTheme.titleSmall!
                                        .copyWith(color: Colors.white),
                                  ),
                                  backgroundColor: Colors.red,
                                ),
                              );
                            }
                          });
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              elevation: 2,
                              content: Text(
                                "Already been printed",
                                style: Get.textTheme.titleSmall!
                                    .copyWith(color: Colors.white),
                              ),
                              backgroundColor: Colors.red,
                            ),
                          );
                        }
                        setState(() {});
                      });
                    },
                    icon: const Icon(
                      Icons.print,
                      color: Colors.white,
                    )),
              )
            : const SizedBox()
      ]).getAppBar(),
      body: widget.loadFromRawData && widget.rawData != null
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

  void printDocument(String name) {
    Printing.layoutPdf(
      name: "$name.Pdf",
      usePrinterSettings: true,
      format: const PdfPageFormat(80, 80),
      onLayout: (PdfPageFormat format) {
        return Future.value(widget.rawData);
      },
    ).then((value) {
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
  }
}
