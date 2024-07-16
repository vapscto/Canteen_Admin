import 'dart:io';
import 'dart:typed_data';

import 'package:canteen_management/controller/global_utility.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '../model/report_list_model.dart';

Future<void> generateAndSavePDF(
    List<ReportListModelValues> reportList,
    BuildContext context,
    String fDt,
    String toDt,
    String foodName,
    String category,
    ) async {
  final doc = pw.Document();
  String timeStamp = DateTime.now().millisecondsSinceEpoch.toString(); // Generate a timestamp
  String fileName = (fDt != '')
      ? '$fDt to $toDt-Report-$timeStamp'
      : (foodName != '')
      ? "$foodName-Report-$timeStamp"
      : "$category-Report-$timeStamp";

  final tableHeaders = [
    'SL.No.',
    'Date',
    'Food Name',
    'Amount',
    'Quantity',
    'Total Amount',
  ];

  final tableData = List.generate(reportList.length, (index) {
    final reportItem = reportList[index];
    return [
      (index + 1).toString(),
      dateFormat(DateTime.parse(reportItem.orderedDate!)),
      reportItem.cMMFIFoodItemName ?? '',
      (reportItem.totalAmount! / reportItem.totalQuantity!.toInt())
          .toStringAsFixed(2),
      reportItem.totalQuantity.toString(),
      reportItem.totalAmount!.toStringAsFixed(2),
    ];
  });

  doc.addPage(
    pw.MultiPage(
      pageFormat: PdfPageFormat.a4,
      build: (pw.Context context) {
        return [
          pw.SizedBox(height: 15.00),
          pw.TableHelper.fromTextArray(
            headers: tableHeaders,
            data: tableData,
            border: pw.TableBorder.all(color: const PdfColor.fromInt(0xfffff)),
            headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold),
            cellStyle: const pw.TextStyle(fontSize: 10),
            headerDecoration: pw.BoxDecoration(
              border: pw.Border(
                bottom: pw.BorderSide(color: PdfColor.fromHex('#000000')),
              ),
            ),
            cellAlignment: pw.Alignment.centerLeft,
            headerAlignment: pw.Alignment.center,
          ),
        ];
      },
    ),
  );

  Uint8List bytes = await doc.save();
  final directory = await getDownloadsDirectory();
  final file = File('${directory!.path}/$fileName.pdf');
  await file.writeAsBytes(bytes);
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text('PDF saved to ${file.path}')),
  );
}
