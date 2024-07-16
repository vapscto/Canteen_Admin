import 'package:canteen_management/canteen_admin/widgets/admin_bill_preview.dart';
import 'package:canteen_management/canteen_management/controller/canteen_controller.dart';
import 'package:canteen_management/controller/mskool_controller.dart';
import 'package:canteen_management/widgets/common_qr_code.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class AdminGenerateBill {
  AdminGenerateBill.init();

  static final AdminGenerateBill instance = AdminGenerateBill.init();

  generateNow({
    required CanteenManagementController controller,
    String? date,
    int? id,
    required MskoolController mskoolController,
    required String paymentType,
  }) async {
    final pdf = pw.Document();
    String dateFormat(DateTime dt) {
      return '${dt.day}-${dt.month}-${dt.year}';
    }

    String getTime(DateTime dt) {
      final DateFormat formatter = DateFormat('h:mm a');
      return formatter.format(dt);
    }

    final fontData = await rootBundle.load("assets/NotoSans-Regular.ttf");
    final ttf = pw.Font.ttf(fontData.buffer.asByteData());

    var logo = await networkImage(controller.billModel.first.logo!);
    double gstAmount = 0.0;
    double calculateGstAmount(double totalAmount, double gstRate) {
      gstAmount = (totalAmount * gstRate) / 100;
      return (totalAmount * gstRate) / 100;
    }

    double calculateFinalPrice(double originalPrice) {
      return originalPrice + gstAmount * 2;
    }

    pdf.addPage(
      pw.MultiPage(
          pageFormat: PdfPageFormat.a4,
          build: (pw.Context context) => [
                pw.Container(
                    width: 200,
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Align(
                          alignment: pw.Alignment.topCenter,
                          child: pw.Container(
                            alignment: pw.Alignment.center,
                            width: 100,
                            child: pw.Image(logo),
                          ),
                        ),
                        pw.Divider(height: 1),
                        pw.Text(
                          'Name: ${controller.billModel.first.aMSTFirstName}',
                          style: pw.TextStyle(
                            fontSize: 10,
                            color: PdfColor.fromHex("#000000"),
                          ),
                        ),
                        pw.Divider(height: 1),
                        pw.Text(
                          "Bill No.: ${controller.billModel.first.cMOrderID}",
                          style: pw.TextStyle(
                            fontSize: 10,
                            color: PdfColor.fromHex("#000000"),
                          ),
                        ),
                        pw.Text(
                          'Date: ${dateFormat(DateTime.parse(date!))} / ${getTime(DateTime.parse(date))}',
                          style: pw.TextStyle(
                            fontSize: 10,
                            color: PdfColor.fromHex("#000000"),
                          ),
                        ),
                        pw.SizedBox(height: 4.0),
                        pw.Table(
                          border: pw.TableBorder(
                              top: pw.BorderSide(
                                  color: PdfColor.fromHex("#000000"))),
                          children: [
                            pw.TableRow(
                              decoration: pw.BoxDecoration(
                                  border: pw.Border(
                                      bottom: pw.BorderSide(
                                          color: PdfColor.fromHex('#000000')))),
                              children: [
                                pw.Container(
                                  padding: const pw.EdgeInsets.all(1.0),
                                  child: pw.Text(
                                    "No.",
                                    maxLines: 2,
                                    style: pw.TextStyle(
                                      fontSize: 10,
                                      color: PdfColor.fromHex("#000000"),
                                    ),
                                  ),
                                ),
                                pw.Container(
                                  padding: const pw.EdgeInsets.all(1.0),
                                  child: pw.Text(
                                    "Item",
                                    maxLines: 2,
                                    style: pw.TextStyle(
                                      fontSize: 10,
                                      color: PdfColor.fromHex("#000000"),
                                    ),
                                  ),
                                ),
                                pw.Container(
                                  padding: const pw.EdgeInsets.all(1.0),
                                  child: pw.Text(
                                    "Qty",
                                    style: pw.TextStyle(
                                      fontSize: 10,
                                      color: PdfColor.fromHex("#000000"),
                                    ),
                                  ),
                                ),
                                pw.Container(
                                    padding: const pw.EdgeInsets.all(1.0),
                                    child: pw.Text(
                                      "Price",
                                      style: pw.TextStyle(
                                        fontSize: 10,
                                        color: PdfColor.fromHex("#000000"),
                                      ),
                                    )),
                                pw.Container(
                                    alignment: pw.Alignment.topRight,
                                    padding: const pw.EdgeInsets.all(1.0),
                                    child: pw.Text(
                                      "Amount",
                                      style: pw.TextStyle(
                                        fontSize: 10,
                                        color: PdfColor.fromHex("#000000"),
                                      ),
                                    )),
                              ],
                            ),
                            ...List.generate(controller.billModel.length,
                                (index) {
                              var v = index + 1;
                              return pw.TableRow(children: [
                                pw.Container(
                                  padding: const pw.EdgeInsets.all(1.0),
                                  child: pw.Text(
                                    v.toString(),
                                    style: pw.TextStyle(
                                      fontSize: 10,
                                      color: PdfColor.fromHex("#000000"),
                                    ),
                                  ),
                                ),
                                pw.Container(
                                  padding: const pw.EdgeInsets.all(1.0),
                                  child: pw.Row(
                                    children: [
                                      pw.Text(
                                        controller.billModel[index].cMTRANSIName ??
                                            '',
                                        maxLines: 2,
                                        style: pw.TextStyle(
                                          fontSize: 10,
                                          color: PdfColor.fromHex("#000000"),
                                        ),
                                      ),
                                      (controller.billModel[index].voidItemFlag == true)?
                                       pw.Container(
                                         decoration: pw.BoxDecoration(
                                           borderRadius: pw.BorderRadius.circular(6),
                                           color: PdfColor.fromHex('#0AFC06'),
                                         ),
                                             padding: const pw.EdgeInsets.all(2),
                                         child: pw.Center(
                                           child: pw.Text("Refunded", style: pw.TextStyle(
                                             fontSize: 8,
                                             color: PdfColor.fromHex("#F6F9F6"),
                                           ), ),
                                         )
                                       )
                                          :pw.SizedBox()
                                    ]
                                  )
                                ),
                                pw.Container(
                                  padding: const pw.EdgeInsets.all(1.0),
                                  child: pw.Text(
                                    controller.billModel[index].cMTRANSQty
                                        .toString(),
                                    style: pw.TextStyle(
                                      fontSize: 10,
                                      color: PdfColor.fromHex("#000000"),
                                    ),
                                  ),
                                ),
                                pw.Container(
                                  padding: const pw.EdgeInsets.all(1.0),
                                  child: pw.Text(
                                    controller.billModel[index].cMTRANSIUnitRate
                                        .toString(),
                                    style: pw.TextStyle(
                                      fontSize: 10,
                                      color: PdfColor.fromHex("#000000"),
                                    ),
                                  ),
                                ),
                                pw.Container(
                                  alignment: pw.Alignment.topRight,
                                  padding: const pw.EdgeInsets.all(1.0),
                                  child: pw.Text(
                                    (controller.billModel[index]
                                                .cMTRANSIUnitRate! *
                                            controller
                                                .billModel[index].cMTRANSQty!)
                                        .toString(),
                                    style: pw.TextStyle(
                                      fontSize: 10,
                                      color: PdfColor.fromHex("#000000"),
                                    ),
                                  ),
                                ),
                              ]);
                            })
                          ],
                        ),
                        pw.Divider(height: 1),
                        pw.SizedBox(height: 4.0),
                        pw.Align(
                          alignment: pw.Alignment.topRight,
                          child: pw.Row(
                              // crossAxisAlignment: pw.CrossAxisAlignment.end,
                              mainAxisAlignment: pw.MainAxisAlignment.end,
                              children: [
                                pw.Text(
                                  "Total Qty : ${controller.quantity}",
                                  style: pw.TextStyle(
                                    fontSize: 10,
                                    color: PdfColor.fromHex("#000000"),
                                  ),
                                ),
                                pw.SizedBox(width: 5),
                                pw.Text(
                                  "Sub Amount : ${controller.billModel.first.cMTRANSTotalAmount}",
                                  style: pw.TextStyle(
                                    fontSize: 10,
                                    color: PdfColor.fromHex("#000000"),
                                  ),
                                ),
                              ]),
                        ),
                        pw.SizedBox(height: 4.0),
                        pw.Text(
                          "[Net Total Inclusive of GST]",
                          style: pw.TextStyle(
                            fontSize: 10,
                            color: PdfColor.fromHex("#000000"),
                          ),
                        ),
                        pw.SizedBox(height: 4.0),
                        pw.Align(
                          alignment: pw.Alignment.topRight,
                          child: pw.Column(
                              crossAxisAlignment: pw.CrossAxisAlignment.end,
                              children: [
                                pw.Text(
                                  "CGST${controller.billModel.first.cGST}% : ${calculateGstAmount(controller.billModel.first.cMTRANSTotalAmount,double.parse(controller.billModel.first.cGST!) )}",
                                  style: pw.TextStyle(
                                    fontSize: 10,
                                    color: PdfColor.fromHex("#000000"),
                                  ),
                                ),
                                pw.Text(
                                  "SGST ${controller.billModel.first.sGST}% : ${calculateGstAmount(controller.billModel.first.cMTRANSTotalAmount, double.parse(controller.billModel.first.sGST!))}",
                                  style: pw.TextStyle(
                                    fontSize: 10,
                                    color: PdfColor.fromHex("#000000"),
                                  ),
                                ),
                              ]),
                        ),
                        pw.SizedBox(height: 4.0),
                        pw.Divider(height: 1),
                        pw.Align(
                          alignment: pw.Alignment.topRight,
                          child: pw.Column(
                              crossAxisAlignment: pw.CrossAxisAlignment.end,
                              children: [
                                pw.Text(
                                  "Grand Total ₹ ${calculateFinalPrice(controller.billModel.first.cMTRANSTotalAmount)}0",
                                  style: pw.TextStyle(
                                      fontSize: 10,
                                      fontWeight: pw.FontWeight.bold,
                                      color: PdfColor.fromHex("#000000"),
                                      font: ttf),
                                ),
                              ]),
                        ),
                        pw.Divider(height: 1),
                        pw.Align(
                          alignment: pw.Alignment.center,
                          child: pw.Column(
                              crossAxisAlignment: pw.CrossAxisAlignment.center,
                              children: [
                                pw.Text(
                                  "GSTIN : ${controller.billModel.first.gstIn}",
                                  style: pw.TextStyle(
                                    fontSize: 10,
                                    color: PdfColor.fromHex("#000000"),
                                  ),
                                ),
                                pw.Text(
                                  "FSSAI : ${controller.billModel.first.fssai}",
                                  style: pw.TextStyle(
                                    fontSize: 10,
                                    color: PdfColor.fromHex("#000000"),
                                  ),
                                ),
                                pw.Text(
                                  "E. &O .E . Thank You Visit Again",
                                  style: pw.TextStyle(
                                    fontSize: 10,
                                    color: PdfColor.fromHex("#000000"),
                                  ),
                                ),
                              ]),
                        ),
                        pw.SizedBox(height: 5.0),
                        pw.Align(
                          alignment: pw.Alignment.bottomCenter,
                          child: pw.Container(
                            decoration: pw.BoxDecoration(
                                borderRadius: pw.BorderRadius.circular(2),
                                border: pw.Border.all(color: PdfColors.black)),
                            child: getQrCode(
                                controller.billModel.first.cMOrderID!),
                          ),
                        ),
                      ],
                    )),
              ]),
    );
    Uint8List rawData = await pdf.save();
    Get.to(() => AdminBillPreview(
          rawData: rawData,
          name: controller.billModel.first.aMSTFirstName!,
          orderId: controller.billModel.first.cMOrderID.toString(),
          mskoolController: mskoolController,
        ));
  }
}
