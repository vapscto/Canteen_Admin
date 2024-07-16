import 'dart:typed_data';

import 'package:canteen_management/controller/mskool_controller.dart';
import 'package:get/get.dart';
import 'package:number_to_words_english/number_to_words_english.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:printing/printing.dart';

import '../../widgets/common_qr_code.dart';
import '../controller/canteen_controller.dart';
import 'bill_preview.dart';

class GenerateBill {
  GenerateBill.init();

  static final GenerateBill instance = GenerateBill.init();

  generateNow(
      {required CanteenManagementController controller,
      String? date,
      int? id,
      required MskoolController mskoolController}) async {
    final Document document = Document();
    String dateFormat(DateTime dt) {
      return '${dt.day}-${dt.month}-${dt.year}';
    }

    var logo = await networkImage(controller.billModel.first.logo!);
    for (int i = 0; i < controller.billModel.length; i++) {}
    document.addPage(
      Page(
        pageFormat: PdfPageFormat.a4,
        build: (_) {
          return Container(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image(logo),
              // Text(
              //   controller.salarySlipDetail.first.institutionDetails!.mIName
              //       .toString(),
              //   style: TextStyle(
              //     fontSize: 20,
              //     fontBold: Font.courierBold(),
              //     color: PdfColor.fromHex("#000000"),
              //   ),
              // ),
              // Text(),
              SizedBox(height: 24.0),
              Text(
                "Bill No.: ${controller.billModel.first.cMOrderID}",
                style: TextStyle(
                  fontSize: 12,
                  color: PdfColor.fromHex("#000000"),
                ),
              ),
              SizedBox(height: 8.0),
              Table(tableWidth: TableWidth.min, children: [
                TableRow(children: [
                  Text(
                    'Name  : ${controller.billModel.first.aMSTFirstName}  ',
                    style: TextStyle(
                      fontSize: 12,
                      color: PdfColor.fromHex("#000000"),
                    ),
                  ),
                  Text(
                    'Roll No. : ${controller.billModel.first.rollNo} ',
                    style: TextStyle(
                      fontSize: 12,
                      color: PdfColor.fromHex("#000000"),
                    ),
                  ),
                ]),
                TableRow(children: [
                  Text(
                    'Class  :${controller.billModel.first.className} | ${controller.billModel.first.sectionName} ',
                    style: TextStyle(
                      fontSize: 12,
                      color: PdfColor.fromHex("#000000"),
                    ),
                  ),
                  Text(
                    'Date  :${dateFormat(DateTime.parse(date ?? DateTime.now().toIso8601String()))} ',
                    style: TextStyle(
                      fontSize: 12,
                      color: PdfColor.fromHex("#000000"),
                    ),
                  ),
                ]),
              ]),
              SizedBox(height: 20.0),
              Table(
                // border: TableBorder.all(),
                tableWidth: TableWidth.min,
                children: [
                  TableRow(
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                                color: PdfColor.fromHex('#000000')))),
                    children: [
                      // Container(
                      //   padding: const EdgeInsets.all(8.0),
                      //   child: Text("S No."),
                      // ),
                      Container(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Food Name", maxLines: 2),
                      ),
                      Container(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Quantity"),
                      ),
                      Container(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("Price")),
                      Container(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("Amount")),
                    ],
                  ),
                  ...List.generate(controller.billModel.length, (index) {
                    // var a = index + 1;

                    return TableRow(children: [
                      // Container(
                      //   padding: const EdgeInsets.all(8.0),
                      //   child: Text("$a"),
                      // ),
                      Container(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                            controller.billModel[index].cMTRANSIName ?? '',
                            maxLines: 2),
                      ),
                      Container(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                            controller.billModel[index].cMTRANSQty.toString()),
                      ),
                      Container(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          controller.billModel[index].cMTRANSIUnitRate
                              .toString(),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          (controller.billModel[index].cMTRANSIUnitRate! *
                                  controller.billModel[index].cMTRANSQty!)
                              .toString(),
                        ),
                      ),
                    ]);
                  })
                ],
              ),
              SizedBox(height: 16.0),
              Text("Total Quantity : ${controller.quantity}"),
              SizedBox(height: 8.0),
              Text(
                  "Total Amount : ${controller.billModel.first.cMTRANSTotalAmount}"),
              SizedBox(height: 8.0),
              Text(
                  "Amount In Words : ${NumberToWordsEnglish.convert(controller.billModel.first.cMTRANSTotalAmount!.toInt())} rupee only"),
              SizedBox(height: 10.0),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(2),
                    border: Border.all(color: PdfColors.black)),
                child: getQrCode(controller.billModel.first.cMOrderID!),
              ),
              SizedBox(height: 40),
              Container(
                child: ListView.separated(
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                      Text(
                      "Bill No.: ${controller.billModel.first.cMOrderID}",
                        style: TextStyle(
                          fontSize: 12,
                          color: PdfColor.fromHex("#000000"),
                        ),
                      ),
                      SizedBox(height: 8.0),
                      Table(tableWidth: TableWidth.min, children: [
                      TableRow(children: [
                      Text(
                      'Name  : ${controller.billModel.first.aMSTFirstName}  ',
                      style: TextStyle(
                      fontSize: 12,
                      color: PdfColor.fromHex("#000000"),
                      ),
                      ),
                      Text(
                      'Roll No. : ${controller.billModel.first.rollNo} ',
                      style: TextStyle(
                      fontSize: 12,
                      color: PdfColor.fromHex("#000000"),
                      ),
                      ),
                      ]),
                      TableRow(children: [
                      Text(
                      'Class  :${controller.billModel.first.className} | ${controller.billModel.first.sectionName} ',
                      style: TextStyle(
                      fontSize: 12,
                      color: PdfColor.fromHex("#000000"),
                      ),
                      ),
                      Text(
                      'Date  :${dateFormat(DateTime.parse(date ?? DateTime.now().toIso8601String()))} ',
                      style: TextStyle(
                      fontSize: 12,
                      color: PdfColor.fromHex("#000000"),
                      ),
                      ),
                      ]),
                      ]),
                      SizedBox(height: 20.0),
                      Table(
                      // border: TableBorder.all(),
                      tableWidth: TableWidth.min,
                      children: [
                      TableRow(
                      decoration: BoxDecoration(
                      border: Border(
                      bottom: BorderSide(
                      color: PdfColor.fromHex('#000000')))),
                      children: [
                      Container(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Food Name", maxLines: 2),
                      ),
                      Container(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Quantity"),
                      ),
                      Container(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Price")),
                      Container(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Amount")),
                      ],
                      ),
                        TableRow(children: [

                          Container(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                                controller.billModel[index].cMTRANSIName ?? '',
                                maxLines: 2),
                          ),
                          Container(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                                controller.billModel[index].cMTRANSQty.toString()),
                          ),
                          Container(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              controller.billModel[index].cMTRANSIUnitRate
                                  .toString(),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              (controller.billModel[index].cMTRANSIUnitRate! *
                                  controller.billModel[index].cMTRANSQty!)
                                  .toString(),
                            ),
                          ),
                        ])
                        ])]
                      );
                    },
                    separatorBuilder: (context, index) {
                      return SizedBox(height: 16);
                    },
                    itemCount: controller.billModel.length),
              ),
            ],
          ));
        },
      ),
    );
    Uint8List rawData = await document.save();
    Get.to(() => BillPreview(
          loadFromRawData: true,
          rawData: rawData,
          name: controller.billModel.first.aMSTFirstName!,
          orderId: controller.billModel.first.cMOrderID.toString(),
          mskoolController: mskoolController,
        ));
  }
}
