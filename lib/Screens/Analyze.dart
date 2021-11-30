import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:scrapie/Constants/Values.dart';

class Analyze extends StatelessWidget {
  const Analyze({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Analyze",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: primaryColor,
      ),
      body: SingleChildScrollView(
        child: AspectRatio(
          aspectRatio: 2,
          child: BarChart(
            BarChartData(
              barGroups: [
                BarChartGroupData(
                  x: 1,
                  barRods: [
                    BarChartRodData(y: 10),
                  ],
                ),
                BarChartGroupData(
                  x: 2,
                  barRods: [
                    BarChartRodData(y: 4),
                  ],
                ),
                BarChartGroupData(
                  x: 3,
                  barRods: [
                    BarChartRodData(y: 3),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
