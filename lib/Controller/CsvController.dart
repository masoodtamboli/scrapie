import 'dart:io';

import 'package:csv/csv.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:scrapie/Controller/FetchController.dart';

class CsvController extends GetxController {
  FetchController _controller = Get.find();
  Future<String> generateCSV() async {
    String csvData = ListToCsvConverter().convert(_controller.content);
    final String directory = (await getExternalStorageDirectory())!.path;
    final path = "$directory/StudentData.csv";
    final File file = File(path);
    file.writeAsString(csvData);
    return path;
  }
}
