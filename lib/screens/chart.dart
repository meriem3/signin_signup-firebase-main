import 'package:flutter/material.dart';
import'package:syncfusion_flutter_charts/charts.dart';


class chart extends StatefulWidget {

  @override
  _chartState createState() => _chartState();
}

class _chartState extends State<chart> {
  List<SalesData> _chartData=[];

  TooltipBehavior? _tooltipBehavior;

  @override
  void initState() {
    super.initState();
    _chartData = getChartData();
    _tooltipBehavior = TooltipBehavior(enable: true);

  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: SfCartesianChart(
              title: ChartTitle(text: 'Contractions Monotiring'),
              legend: Legend(isVisible: true),
              tooltipBehavior: _tooltipBehavior,
              series: <ChartSeries>[
                LineSeries<SalesData, double>(
                    name: 'value',
                    dataSource: _chartData,
                    xValueMapper: (SalesData sales, _) => sales.time,
                    yValueMapper: (SalesData sales, _) => sales.values,
                    dataLabelSettings: DataLabelSettings(isVisible: true),
                    enableTooltip: true)
              ],
            )));
  }

  List<SalesData> getChartData() {

     final List<SalesData> chartData = [
      SalesData(0, 24),
      SalesData(1, 33),
      SalesData(2, 23),
       SalesData(3, 41),
       SalesData(4, 10),
       SalesData(5, 7),
       SalesData(6, 61),
       SalesData(7, 23),
       SalesData(8, 71),
       SalesData(9, 35),
       SalesData(10, 61),
       SalesData(11, 42),
       SalesData(12, 31),
       SalesData(13, 51),
       SalesData(14, 39),
       SalesData(15, 42),
       SalesData(16, 35),
       SalesData(17, 65),
      SalesData(18, 20),
       SalesData(19, 07),
       SalesData(20,42),
       SalesData(21, 45)];
     return chartData;


}}

class NumberFormat {
}

class SalesData {
  SalesData(this.time, this.values);
  final double time;
  final double values;
}