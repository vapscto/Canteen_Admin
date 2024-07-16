import 'package:canteen_management/canteen_admin/widgets/pay_by_cash_bill_preview.dart';
import 'package:canteen_management/canteen_management/controller/canteen_controller.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:pdf/widgets.dart' as pw;
class PayByCashBill{
  PayByCashBill.init();
  static final PayByCashBill instance = PayByCashBill.init();
  generateBill({required CanteenManagementController controller,
    String? date, }) async {
    final pdf = pw.Document();
    String dateFormat(DateTime dt) {
      return '${dt.day}-${dt.month}-${dt.year}';
    }
    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw. Container(
              child: pw.Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 24.0),
                  pw.ListView.separated(
                      itemBuilder: (pw.Context context, index) {
                        return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Bill No.: ${1234}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: PdfColor.fromHex("#000000"),
                                ),
                              ),
                              SizedBox(height: 6),
                              Text(
                                'Date  :${dateFormat(DateTime.parse(date ?? DateTime.now().toIso8601String()))} ',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: PdfColor.fromHex("#000000"),
                                ),
                              ),
                              SizedBox(height: 8.0),
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
                                            controller.itemDetails[index]['CMTRANSI_name'] ?? '',
                                            maxLines: 2),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                            controller.itemDetails[index]['itemCount'].toString()),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          controller.itemDetails[index]['unitRate']
                                              .toString(),
                                        ),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          (controller.itemDetails[index]['unitRate']*
                                              controller.itemDetails[index]['itemCount']!)
                                              .toString(),
                                        ),
                                      ),
                                    ])
                                  ])]
                        );
                      },
                      separatorBuilder: (pw.Context context, index) {
                        return pw.SizedBox(height: 16);
                      },
                      itemCount: controller.itemDetails.length),
                ],
              ));
        },
      ),
    );
    Uint8List rawData = await pdf.save();
    Get.to(() => PayByCashBillPreview(rawData: rawData,));
  }
}