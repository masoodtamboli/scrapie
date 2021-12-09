import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:scrapie/Constants/Values.dart';

class Analyze extends StatelessWidget {
  const Analyze({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Analyze",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: primaryColor,
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  SizedBox(height: 70),
                  Container(
                    width: size.width / 3,
                    height: 100,
                    color: Colors.red,
                  ),
                ],
              ),
              Column(
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    color: Colors.red,
                  ),
                ],
              ),
              Column(
                children: [
                  SizedBox(height: 70),
                  Container(
                    width: 100,
                    height: 100,
                    color: Colors.red,
                  ),
                ],
              ),
            ],
          )
        ],
      )),
    );
  }
}

// AspectRatio(
//           aspectRatio: 2,
//           child: BarChart(
//             BarChartData(
//               barGroups: [
//                 BarChartGroupData(
//                   x: 1,
//                   barRods: [
//                     BarChartRodData(y: 10),
//                   ],
//                 ),
//                 BarChartGroupData(
//                   x: 2,
//                   barRods: [
//                     BarChartRodData(y: 4),
//                   ],
//                 ),
//                 BarChartGroupData(
//                   x: 3,
//                   barRods: [
//                     BarChartRodData(y: 3),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),