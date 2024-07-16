import 'package:canteen_management/canteen_management/constants/canteen_constants.dart';
import 'package:canteen_management/controller/mskool_controller.dart';
import 'package:canteen_management/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/global_utility.dart';

class MonthWiseOrderScreen extends StatefulWidget {
  final MskoolController mskoolController;
  final int miId;

  const MonthWiseOrderScreen(
      {super.key, required this.mskoolController, required this.miId});

  @override
  State<MonthWiseOrderScreen> createState() => _MonthWiseOrderScreenState();
}

class _MonthWiseOrderScreenState extends State<MonthWiseOrderScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Month Wise Order").getAppBar(),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: SizedBox(
                  height: 40,
                  width: MediaQuery.of(context).size.width*0.3,
                  child: TextFormField(
                    onChanged: (value){},
                    style: Get.textTheme.titleSmall!,
                    decoration: InputDecoration(
                        hintStyle: Get.textTheme.titleSmall!.copyWith(color: Colors.grey),
                        hintText: 'Search',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(color: Colors.grey)
                        )
                    ),
                  ),
                ),
              ),
              Expanded(child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(getMonthName(dt.month),style: Get.textTheme.titleMedium!.copyWith(color: Theme.of(context).primaryColor),),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: DataTable(
                        headingRowHeight: 40,
                        columnSpacing: 20,
                        headingTextStyle:
                        Get.textTheme.titleSmall!.copyWith(color: Colors.white),
                        dataTextStyle: Get.textTheme.titleSmall,
                        border: TableBorder.all(
                          color: Colors.black,
                          width: 0.6,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        headingRowColor: WidgetStateColor.resolveWith(
                                (states) => Theme.of(context).primaryColor),
                        columns: const[
                          DataColumn(label: Text("Sl No.")),
                          DataColumn(label: Text("Name")),
                          DataColumn(label: Text("Total Quantity")),
                          DataColumn(label: Text("Total Amount Collected"))
                        ],
                        rows: List.generate(currentDayData.length, (index) {
                          var i = index+1;
                          var data = currentDayData.elementAt(index);
                          return DataRow(cells: [
                            DataCell(Text(i.toString())),
                            DataCell(Text(data['name'])),
                            DataCell(Text(data['qty'])),
                            DataCell(Text(data['amount'])),
                          ]);
                        }),
                      ),
                    ),
                  ),
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }
  DateTime dt = DateTime.now();

}
