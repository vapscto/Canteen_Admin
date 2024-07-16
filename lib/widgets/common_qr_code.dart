
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
getQrCode(int id) {

  return pw.BarcodeWidget(
    data: id.toString(),
    barcode: pw.Barcode.qrCode(),
    height: 50,
    width: 50,
    color: PdfColor.fromHex("#000000"),
  );
}