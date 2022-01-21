import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scrapie/Controller/AnalyzeController.dart';

class ViewStudResult extends StatefulWidget {
  const ViewStudResult({Key? key}) : super(key: key);

  @override
  _ViewStudResultState createState() => _ViewStudResultState();
}

class _ViewStudResultState extends State<ViewStudResult> {
  AnalyzeController _anaControler = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Text("hello"),
    ));
  }
}
