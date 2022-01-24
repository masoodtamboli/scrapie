import 'dart:developer';
import 'package:d_chart/d_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scrapie/Constants/Values.dart';
import 'package:scrapie/Controller/AnalyzeController.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:dropdown_search/dropdown_search.dart';

class Analyze extends StatefulWidget {
  const Analyze({Key? key}) : super(key: key);

  @override
  _AnalyzeState createState() => _AnalyzeState();
}

class _AnalyzeState extends State<Analyze> {
  AnalyzeController _anaControler = Get.put(AnalyzeController());
  String selectedValue = "";

  generateToppersWidget(Size size) {
    int count = 0;
    List<Widget> toppersList = [];
    for (var k in _anaControler.classToppers.entries) {
      toppersList.add(Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [Color(0xffffdd00), Color(0xfffbb034)],
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        width: size.width * 0.5,
        height: 100,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('${k.key.split(" ")[0]} ${k.key.split(" ")[1]}',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            SizedBox(height: 10),
            Text('${k.value} %',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          ],
        ),
      ));
      toppersList.add(SizedBox(width: 20));
      count += 1;
      if (count == 3) return Row(children: toppersList);
    }
  }

  generatePassedAndFailedChart(Size size) {
    Map<String, double> mapData = {};
    List<Color> colorList = [
      Color(0xffF56401),
      Color(0xff00AF87),
      Color(0xffF5C200),
      Color(0xff8CB71E),
      Color(0xff007796),
      Color(0xff95C8AF),
      Color(0xff87043F),
    ];
    for (var k in _anaControler.status.keys) {
      mapData[k] = _anaControler.status[k].toDouble();
    }
    return PieChart(
      dataMap: mapData,
      animationDuration: Duration(milliseconds: 800),
      chartLegendSpacing: 25,
      chartRadius: size.width / 2.2,
      colorList: colorList,
      initialAngleInDegree: 0,
      chartType: ChartType.disc,
      ringStrokeWidth: 32,
      legendOptions: LegendOptions(
        showLegendsInRow: false,
        showLegends: true,
        legendTextStyle: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      chartValuesOptions: ChartValuesOptions(
        showChartValueBackground: false,
        showChartValues: true,
        showChartValuesInPercentage: false,
        showChartValuesOutside: false,
        decimalPlaces: 1,
      ),
    );
  }

  generateSearchMenuButton(Size size) {
    List<String> items = [];
    for (var k in _anaControler.subjectWiseSortedStudents.keys) {
      items.add(k);
    }
    return DropdownSearch<String>(
      mode: Mode.MENU,
      showSelectedItems: true,
      items: items,
      onChanged: (value) => {
        setState(() {
          selectedValue = value!;
        })
      },
      selectedItem: "Select Subject",
      maxHeight: size.height * 0.2,
    );
  }

  generateBarChart(Size size) {
    Map<String, dynamic> items = {};
    for (var k in _anaControler.subjectWiseSortedStudents.keys) {
      if (selectedValue == k)
        items.addAll(_anaControler.subjectWiseSortedStudents[k]);
    }
    return DChartBar(
      data: [
        {
          'id': 'Bar',
          'data': [
            for (var j in items.entries) {'domain': j.key, 'measure': j.value}
          ],
        },
      ],
      barValue: (barData, index) => barData['measure'].toString(),
      domainLabelPaddingToAxisLine: 16,
      axisLineTick: 2,
      axisLinePointTick: 2,
      axisLinePointWidth: 10,
      axisLineColor: Colors.black,
      measureLabelPaddingToAxisLine: 16,
      barColor: (barData, index, id) {
        if (selectedValue.contains("[TH] [ESE]")) {
          if (barData['measure'] < 28)
            return Colors.red;
          else
            return Color(0xffFfa62b);
        } else
          return Color(0xffFfa62b);
      },
      showBarValue: true,
      yAxisTitle: "Marks",
      xAxisTitle: "Seat Number",
      yAxisTitleInPadding: 10,
      xAxisTitleInPadding: 10,
      minimumPaddingBetweenLabel: 10,
    );
  }

  @override
  void initState() {
    super.initState();
    _anaControler.initMethod();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("Analyze",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        backgroundColor: primaryColor,
        elevation: 0,
        leading: Icon(Icons.arrow_back_outlined, color: Colors.black),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 0, 0),
              child: Text('Class Toppers',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22)),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 15, 0, 0),
                child: generateToppersWidget(size),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 40, 0, 0),
              child: Text('Passed & Failed Students',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22)),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 15, 0, 0),
                child: generatePassedAndFailedChart(size),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 40, 0, 0),
              child: Text('Subject wise Toppers',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22)),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
              child: Container(
                width: size.width * 0.9,
                height: 50,
                child: generateSearchMenuButton(size),
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 0, 30),
                child: Container(
                  height: 300,
                  width: size.width * 1.5,
                  child: generateBarChart(size),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
