import 'dart:io';

import 'package:canteen_management/canteen_admin/model/report_list_model.dart';
import 'package:canteen_management/controller/global_utility.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart';

Future<void> generateAndSaveExcel(
    List<ReportListModelValues> reportList,
    BuildContext context,
    String fDt,
    String toDt,
    String foodName,
    String category) async {
  String timeStamp = DateTime.now().millisecondsSinceEpoch.toString();
  final Workbook workbook = Workbook(); // create a new excel workbook
  final Worksheet sheet = workbook
      .worksheets[0]; // the sheet we will be populating (only the first sheet)

  // Setting global styles for cells
  Style globalStyle = workbook.styles.add('globalStyle');
  globalStyle.borders.all.lineStyle = LineStyle.thin;

  // Setting header styles
  Style headerStyle = workbook.styles.add('headerStyle');
  headerStyle.bold = true;
  headerStyle.fontColorRgb =
      const Color.fromARGB(255, 255, 255, 255); // White color
  headerStyle.backColorRgb =
      const Color.fromARGB(255, 96, 125, 139); // Teal color
  headerStyle.borders.all.lineStyle = LineStyle.medium;

  // Applying header text and styles
  sheet.getRangeByIndex(1, 1).setText('SL No.');
  sheet.getRangeByIndex(1, 2).setText('Date');
  sheet.getRangeByIndex(1, 3).setText('Food Name');
  sheet.getRangeByIndex(1, 4).setText('Amount');
  sheet.getRangeByIndex(1, 5).setText('Quantity');
  sheet.getRangeByIndex(1, 6).setText('Total Amount');
  sheet.getRangeByIndex(1, 1).cellStyle = headerStyle;
  sheet.getRangeByIndex(1, 2).cellStyle = headerStyle;
  sheet.getRangeByIndex(1, 3).cellStyle = headerStyle;
  sheet.getRangeByIndex(1, 4).cellStyle = headerStyle;
  sheet.getRangeByIndex(1, 5).cellStyle = headerStyle;
  sheet.getRangeByIndex(1, 6).cellStyle = headerStyle;

  // Setting column widths
  sheet.getRangeByIndex(1, 1).columnWidth = 8.0;
  sheet.getRangeByIndex(1, 2).columnWidth = 15.0;
  sheet.getRangeByIndex(1, 3).columnWidth = 25.0;
  sheet.getRangeByIndex(1, 4).columnWidth = 15.0;
  sheet.getRangeByIndex(1, 5).columnWidth = 15.0;
  sheet.getRangeByIndex(1, 6).columnWidth = 15.0;

  // Filling data rows
  for (var i = 0; i < reportList.length; i++) {
    var data = reportList.elementAt(i);

    // Alternate row colors
    if (i % 2 == 0) {
      sheet.getRangeByIndex(i + 2, 1).cellStyle.backColorRgb =
          const Color.fromARGB(255, 245, 245, 245); // Light gray
    } else {
      sheet.getRangeByIndex(i + 2, 1).cellStyle.backColorRgb =
          Colors.white; // White
    }

    // Populate data in cells
    sheet.getRangeByIndex(i + 2, 1).setText((i + 1).toString());
    sheet
        .getRangeByIndex(i + 2, 2)
        .setText(dateFormat(DateTime.parse(data.orderedDate!)));
    sheet.getRangeByIndex(i + 2, 3).setText(data.cMMFIFoodItemName ?? '');
    sheet.getRangeByIndex(i + 2, 4).setText(
        (data.totalAmount! / data.totalQuantity!.toInt()).toStringAsFixed(2));
    sheet.getRangeByIndex(i + 2, 5).setText(data.totalQuantity.toString());
    sheet
        .getRangeByIndex(i + 2, 6)
        .setText(data.totalAmount!.toStringAsFixed(2));

    // Apply global style to data cells
    sheet.getRangeByIndex(i + 2, 1).cellStyle = globalStyle;
    sheet.getRangeByIndex(i + 2, 2).cellStyle = globalStyle;
    sheet.getRangeByIndex(i + 2, 3).cellStyle = globalStyle;
    sheet.getRangeByIndex(i + 2, 4).cellStyle = globalStyle;
    sheet.getRangeByIndex(i + 2, 5).cellStyle = globalStyle;
    sheet.getRangeByIndex(i + 2, 6).cellStyle = globalStyle;
  }

  final List<int> bytes = workbook.saveAsStream();
  final directory = await getDownloadsDirectory();
  String excelFile = (fDt != '')
      ? '$fDt to $toDt-Report-$timeStamp'
      : (foodName != '')
          ? "$foodName-Report-$timeStamp"
          : "$category-Report-$timeStamp";
  File('${directory!.path}/$excelFile.xlsx').writeAsBytes(bytes);

  // Dispose the workbook to free up resources
  workbook.dispose();

  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(
      content: Text('Excel file successfully downloaded'),
    ),
  );
}
