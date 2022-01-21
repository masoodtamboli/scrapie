import 'package:get/get.dart';
import 'package:scrapie/Controller/FetchController.dart';

Future<void> init() async {
  Get.put(FetchController());
}
