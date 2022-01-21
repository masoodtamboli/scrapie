import 'dart:developer';
import 'package:get/get.dart';
import 'package:scrapie/Controller/FetchController.dart';

class AnalyzeController extends GetxController {
  FetchController _ContentController = Get.find();
  void Test() {
    log('${_ContentController.content}');
  }
}
