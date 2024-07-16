import 'dart:typed_data';

import 'package:canteen_management/canteen_admin/admin_api/admin_api.dart';
import 'package:canteen_management/canteen_management/controller/canteen_controller.dart';
import 'package:canteen_management/canteen_management/screens/kiosk_bill_preview.dart';
import 'package:canteen_management/controller/global_utility.dart';
import 'package:canteen_management/controller/mskool_controller.dart';
import 'package:canteen_management/main.dart';
import 'package:canteen_management/widgets/common_qr_code.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:number_to_words_english/number_to_words_english.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:printing/printing.dart';


class GenerateBillKiosk {
  GenerateBillKiosk.init();

  static final GenerateBillKiosk instance = GenerateBillKiosk.init();

  generateNow(
      {required CanteenManagementController controller,
      String? date,
      int? id,
      required MskoolController mskoolController}) async {
    final document = Document();
    String dateFormat(DateTime dt) {
      return '${dt.day}-${dt.month}-${dt.year}';
    }

    String getTime(DateTime dt) {
      final DateFormat formatter = DateFormat('h:mm a');
      return formatter.format(dt);
    }

    var logo = await networkImage(controller.billModel.first.logo!);
    document.addPage(
      Page(
        margin: const EdgeInsets.only(
          top: 0,
        ),
        pageFormat: PdfPageFormat.a4,
        build: (Context context) {
          return Container(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 100,
                width: 100,
                child: Image(logo),
              ),
              SizedBox(height: 3.0),
              Text(
                "Bill No.: ${controller.billModel.first.cMOrderID}",
                style: TextStyle(
                  fontSize: 10,
                  color: PdfColor.fromHex("#000000"),
                ),
              ),
              Container(
                width: 120,
                child: Text(
                  'Name  : ${controller.billModel.first.aMSTFirstName}',
                  maxLines: 2,
                  style: TextStyle(
                    fontSize: 10,
                    color: PdfColor.fromHex("#000000"),
                  ),
                ),
              ),
              (staffStudentFlag == 's')
                  ? Text(
                      'Roll No. : ${controller.billModel.first.rollNo} Class  :${controller.billModel.first.className} | ${controller.billModel.first.sectionName}',
                      style: TextStyle(
                        fontSize: 10,
                        color: PdfColor.fromHex("#000000"),
                      ),
                    )
                  : Text(
                      'Emp Code : ${controller.billModel.first.rollNo} ',
                      style: TextStyle(
                        fontSize: 10,
                        color: PdfColor.fromHex("#000000"),
                      ),
                    ),
              Text(
                'Date/Time: ${dateFormat(DateTime.parse(date!))} / ${getTime(DateTime.parse(date))}',
                style: TextStyle(
                  fontSize: 10,
                  color: PdfColor.fromHex("#000000"),
                ),
              ),
              SizedBox(height: 3),
              Table(
                tableWidth: TableWidth.min,
                children: [
                  TableRow(
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                                color: PdfColor.fromHex('#000000')))),
                    children: [
                      Container(
                        padding: const EdgeInsets.all(1.0),
                        child: Text(
                          "Name",
                          style: TextStyle(
                            fontSize: 10,
                            color: PdfColor.fromHex("#000000"),
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(3.0),
                        child: Text(
                          "Qty",
                          style: TextStyle(
                            fontSize: 10,
                            color: PdfColor.fromHex("#000000"),
                          ),
                        ),
                      ),
                      Container(
                          padding: const EdgeInsets.all(3.0),
                          child: Text(
                            "Price",
                            style: TextStyle(
                              fontSize: 10,
                              color: PdfColor.fromHex("#000000"),
                            ),
                          )),
                      Container(
                          padding: const EdgeInsets.all(1.0),
                          child: Text(
                            "Amount",
                            style: TextStyle(
                              fontSize: 10,
                              color: PdfColor.fromHex("#000000"),
                            ),
                          )),
                    ],
                  ),
                  ...List.generate(controller.billModel.length, (index) {
                    return TableRow(children: [
                      Container(
                        padding: const EdgeInsets.all(3.0),
                        child: Text(
                          controller.billModel[index].cMTRANSIName ?? '',
                          maxLines: 2,
                          style: TextStyle(
                            fontSize: 10,
                            color: PdfColor.fromHex("#000000"),
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(3.0),
                        child: Text(
                          controller.billModel[index].cMTRANSQty.toString(),
                          style: TextStyle(
                            fontSize: 10,
                            color: PdfColor.fromHex("#000000"),
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(3.0),
                        child: Text(
                          controller.billModel[index].cMTRANSIUnitRate
                              .toString(),
                          style: TextStyle(
                            fontSize: 10,
                            color: PdfColor.fromHex("#000000"),
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(1.0),
                        child: Text(
                          (controller.billModel[index].cMTRANSIUnitRate! *
                                  controller.billModel[index].cMTRANSQty!)
                              .toString(),
                          style: TextStyle(
                            fontSize: 10,
                            color: PdfColor.fromHex("#000000"),
                          ),
                        ),
                      ),
                    ]);
                  })
                ],
              ),
              SizedBox(height: 3.0),
              Text(
                "Total Quantity : ${controller.quantity}",
                style: TextStyle(
                  fontSize: 10,
                  color: PdfColor.fromHex("#000000"),
                ),
              ),
              SizedBox(height: 3.0),
              Text(
                "Total Amount : ${controller.billModel.first.cMTRANSTotalAmount}",
                style: TextStyle(
                  fontSize: 10,
                  color: PdfColor.fromHex("#000000"),
                ),
              ),
              SizedBox(height: 3.0),
              Text(
                "Amount In Words : ${NumberToWordsEnglish.convert(controller.billModel.first.cMTRANSTotalAmount!.toInt())} rupee only",
                style: TextStyle(
                  fontSize: 10,
                  color: PdfColor.fromHex("#000000"),
                ),
              ),
              SizedBox(height: 5.0),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(2),
                    border: Border.all(color: PdfColors.black)),
                child: getQrCode(controller.billModel.first.cMOrderID!),
              ),

            ],
          ));
        },
      ),
    );
    Uint8List rawData = await document.save();
    Get.to(() => KioskBillPreview(
          rawData: rawData,
          name: controller.billModel.first.aMSTFirstName!,
          orderId: controller.billModel.first.cMOrderID.toString(),
          mskoolController: mskoolController,
        ));
      try {
        bool printResult = await Printing.directPrintPdf(
          onLayout: (PdfPageFormat format) async => document.save(),
          printer: await _getRpc327Printer(),
        );
        if (printResult) {
          await oneTimePrint(
            base: baseUrlFromInsCode("canteen", mskoolController),
            orderId: controller.billModel.first.cMOrderID!,
          );
          Get.back();
          Get.back();
          logger.i("Print successful");
        } else {
          logger.i("Print failed");
        }
      } catch (e) {
        logger.i("Error during printing: $e");
      }

  }

  Future<Printer> _getRpc327Printer() async {
    final printers = await Printing.listPrinters();
    for (var element in printers) {
      logger.w(element.name);
    }
    return printers.first;
    //   printers.firstWhere((printer)
    // => printer.name == 'RP327 Printer');
  }
}
