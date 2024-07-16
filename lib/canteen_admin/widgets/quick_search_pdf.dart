
import 'package:canteen_management/canteen_admin/admin_api/admin_api.dart';
import 'package:canteen_management/canteen_admin/admin_controller/admin_controller.dart';
import 'package:canteen_management/controller/global_utility.dart';
import 'package:canteen_management/controller/mskool_controller.dart';
import 'package:canteen_management/main.dart';
import 'package:canteen_management/widgets/common_qr_code.dart';
import 'package:intl/intl.dart';
import 'package:number_to_words_english/number_to_words_english.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/widgets.dart';
import 'package:printing/printing.dart';

class QuickSearchPdf {
  QuickSearchPdf.init();

  static final QuickSearchPdf i = QuickSearchPdf.init();

  generateNow(
      {required AdminController controller,
      String? date,
      int? id,
      required MskoolController mskoolController}) async {
    final pdf = pw.Document();
    String dateFormat(DateTime dt) {
      return '${dt.day}-${dt.month}-${dt.year}';
    }

    String getTime(DateTime dt) {
      final DateFormat formatter = DateFormat('h:mm a');
      return formatter.format(dt);
    }

    for (int i = 0; i < controller.quickSearchList.length; i++) {}
    var logo = await networkImage(controller.quickSearchList.first.logo!);
    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) => [
          pw.Container(
              child: pw.Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              pw.Container(
                height: 100,
                width: 100,
                child: pw.Image(logo),
              ),
              SizedBox(height: 24.0),
              Text(
                "Bill No.: ${controller.quickSearchList.first.cMOrderID}",
                style: TextStyle(
                  fontSize: 10,
                  color: PdfColor.fromHex("#000000"),
                ),
              ),
              SizedBox(height: 4.0),
              Text(
                'Name : ${controller.quickSearchList.first.aMSTFirstName}',
                style: TextStyle(
                  fontSize: 10,
                  color: PdfColor.fromHex("#000000"),
                ),
              ),
              Text(
                'Date/Time: ${dateFormat(DateTime.parse(date!))}/${getTime(DateTime.parse(date))}',
                maxLines: 2,
                style: TextStyle(
                  fontSize: 10,
                  color: PdfColor.fromHex("#000000"),
                ),
              ),
              SizedBox(height: 4.0),
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
                          "Food Name",
                          maxLines: 2,
                          style: TextStyle(
                            fontSize: 10,
                            color: PdfColor.fromHex("#000000"),
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(1.0),
                        child: Text(
                          "Qty",
                          style: TextStyle(
                            fontSize: 10,
                            color: PdfColor.fromHex("#000000"),
                          ),
                        ),
                      ),
                      Container(
                          padding: const EdgeInsets.all(1.0),
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
                  ...List.generate(controller.quickSearchList.length, (index) {
                    return TableRow(children: [
                      Container(
                        padding: const EdgeInsets.all(1.0),
                        child: Text(
                          controller.quickSearchList[index].cMTRANSIName ?? '',
                          maxLines: 2,
                          style: TextStyle(
                            fontSize: 10,
                            color: PdfColor.fromHex("#000000"),
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(1.0),
                        child: Text(
                          controller.quickSearchList[index].cMTRANSQty
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
                          controller.quickSearchList[index].cMTRANSIUnitRate
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
                          (controller.quickSearchList[index].cMTRANSIUnitRate! *
                                  controller.quickSearchList[index].cMTRANSQty!)
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
                "Total Quantity : ${controller.quickSearchList.length}",
                style: TextStyle(
                  fontSize: 10,
                  color: PdfColor.fromHex("#000000"),
                ),
              ),
              SizedBox(height: 3.0),
              Text(
                "Total Amount : ${controller.quickSearchList.first.cMTRANSTotalAmount}",
                style: TextStyle(
                  fontSize: 10,
                  color: PdfColor.fromHex("#000000"),
                ),
              ),
              SizedBox(height: 3.0),
              Text(
                "Amount In Words : ${NumberToWordsEnglish.convert(controller.quickSearchList.first.cMTRANSTotalAmount!.toInt())} rupees only",
                maxLines: 3,
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
                child: getQrCode(controller.quickSearchList.first.cMOrderID!),
              ),
              SizedBox(height: 3),
            ],
          ))
        ],
      ),
    );
    // Get.to(() => AdminBillPreview(
    //       rawData: rawData,
    //       name: controller.quickSearchList.first.aMSTFirstName!,
    //       orderId: controller.quickSearchList.first.cMOrderID.toString(),
    //       mskoolController: mskoolController,
    //     ));
    try {
      bool printResult = await Printing.directPrintPdf(
        onLayout: (PdfPageFormat format) async => pdf.save(),
        printer: await _getRpc327Printer(),
      );
      if (printResult) {
        await oneTimePrint(
          base: baseUrlFromInsCode("canteen", mskoolController),
          orderId: controller.quickSearchList.first.cMOrderID!,
        );
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
  }
}
