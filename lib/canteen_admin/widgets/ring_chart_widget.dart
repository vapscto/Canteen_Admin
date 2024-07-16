import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pie_chart/pie_chart.dart';

class RingChartWidget extends StatelessWidget {
  final double vegCount;
  final double nonVegCount;
  final String title1;
  final String title2;
  const RingChartWidget(
      {super.key, required this.vegCount, required this.nonVegCount, required this.title1, required this.title2});
  @override
  Widget build(BuildContext context) {
    return PieChart(
      dataMap: {title1: vegCount, title2: nonVegCount},
      chartType: ChartType.ring,
      chartRadius: MediaQuery.of(context).size.height*0.12,
      chartLegendSpacing: 10,
      colorList: const [Color(0xFF3FCF52), Color(0xffF90E07)],

      legendOptions: LegendOptions(

          legendPosition: LegendPosition.left,
          legendShape: BoxShape.circle,
          legendTextStyle: Get.textTheme.titleSmall!.copyWith(fontSize: 10)),
      chartValuesOptions: const ChartValuesOptions(
        showChartValueBackground: true,
        chartValueBackgroundColor: Colors.transparent,
        showChartValues: false,
        showChartValuesInPercentage: false,
        showChartValuesOutside: false,
        decimalPlaces: 0,
        chartValueStyle: TextStyle(fontSize: 14,color: Colors.black)
      ),

    );
  }
}
