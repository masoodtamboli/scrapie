// import 'package:fl_chart/fl_chart.dart';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scrapie/Constants/Values.dart';
import 'package:scrapie/Controller/AnalyzeController.dart';

class Analyze extends StatelessWidget {
  AnalyzeController _anaControler = Get.put(AnalyzeController());
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
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 20.0),
          height: 130.0,
          child: new ListView(
            scrollDirection: Axis.horizontal,
            children: <Widget>[
              SizedBox(width: 10),
              Container(
                width: 180.0,
                color: Colors.blue,
                child: Center(
                  child: Text("57 Students Passed"),
                ),
              ),
              SizedBox(width: 20),
              ElevatedButton(
                  onPressed: () {
                    _anaControler.initMethod();
                  },
                  child: Text("hello")),
              Container(
                width: 180.0,
                color: Colors.green,
              ),
              SizedBox(width: 20),
              Container(
                width: 180.0,
                color: Colors.cyan,
              ),
              SizedBox(width: 20),
            ],
          ),
        ),
      ),
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

// Stack(
//               children: [
//                 Positioned.fill(
//                   child: Align(
//                     alignment: Alignment.center,
//                     child: Container(
//                       width: 150,
//                       height: 100,
//                       color: Color(0xffe1ad01),
//                       child: Center(
//                         child: Column(
//                           children: [
//                             SizedBox(height: 20),
//                             Text("Masood Ismail Tamboli"),
//                             SizedBox(height: 10),
//                             Text("97%"),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//                 Padding(
//                   padding: EdgeInsets.fromLTRB(30, 100, 30, 0),
//                   child: Column(
//                     children: [
//                       Container(
//                         width: size.width,
//                         height: 100,
//                         color: Color(0xffe1ad01),
//                         child: Row(
//                           children: [
//                             SizedBox(width: 10),
//                             Column(
//                               children: [
//                                 SizedBox(height: 20),
//                                 Text("Masood Ismail Tamboli"),
//                                 SizedBox(height: 10),
//                                 Text("97%"),
//                               ],
//                             ),
//                             Spacer(),
//                             Column(
//                               children: [
//                                 SizedBox(height: 20),
//                                 Text("Masood Ismail Tamboli"),
//                                 SizedBox(height: 10),
//                                 Text("97%"),
//                               ],
//                             ),
//                             SizedBox(width: 10),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
