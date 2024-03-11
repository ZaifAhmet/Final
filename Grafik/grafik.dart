// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class grafik extends StatefulWidget {
  final String xDegerleri;
  final String yDegerleri;
  final String solbaslik;
  final String altbaslik;

  grafik({
    Key? key,
    required this.xDegerleri,
    required this.yDegerleri,
    required this.solbaslik,
    required this.altbaslik,
  }) : super(key: key);

  @override
  State<grafik> createState() => _grafikState();
}

class _grafikState extends State<grafik> {
  List<SalesData> _chartData = [];
  late String xDegerleri;
  late String yDegerleri;
  late String solbaslik;
  late String altbaslik;
  @override
  void initState() {
    xDegerleri = widget.xDegerleri;
    yDegerleri = widget.yDegerleri;
    solbaslik = widget.solbaslik;
    altbaslik = widget.altbaslik;
    _chartData = getChartData(xDegerleri, yDegerleri);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Grafik"),
        ),
        body: Container(
          height: 500,
          width: 500,
          child: SfCartesianChart(
            title: ChartTitle(text: "Çizilen Grafik"),
            series: <ChartSeries>[
              LineSeries<SalesData, int>(
                dataSource: _chartData,
                xValueMapper: (SalesData sales, _) => sales.year,
                yValueMapper: (SalesData sales, _) => sales.sales,
              )
            ],
            primaryXAxis: NumericAxis(
              title: AxisTitle(text: altbaslik),
              edgeLabelPlacement: EdgeLabelPlacement.shift,
            ),
            primaryYAxis: NumericAxis(title: AxisTitle(text: solbaslik)),
          ),
        ),
      ),
    );
  }

  List<SalesData> getChartData(String xDegerleri, String yDegerleri) {
    List<int> x = xDegerleri.split(' ').map((e) => int.parse(e)).toList();
    List<int> y = yDegerleri.split(' ').map((e) => int.parse(e)).toList();
    final List<SalesData> chartData = [];
    for (int i = 0; i < x.length; i++) {
      chartData.add(SalesData(x[i], y[i]));
    }

    return chartData;
  }
}

class SalesData {
  SalesData(this.year, this.sales);
  final int year;
  final int sales;
}
