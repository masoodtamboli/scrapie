import 'dart:collection';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:scrapie/Controller/FetchController.dart';

class AnalyzeController extends GetxController {
  FetchController _ContentController = Get.find();
  Map<String, dynamic> contentDict = {};
  Map<String, double> classToppers = {};
  var status = Map();
  var subjectWiseSortedStudents = Map();

  void initMethod() {
    Map<String, double> temp = {};
    //Convert List<List<string>> i.e content to Dictionary to access easily all subjects
    for (int i = 0; i < _ContentController.content[0].length; i++) {
      //Adding Header value as key and further fields as values
      //for e.g contentDict["Seat Number"] = ["148351", "148352"....]
      contentDict[_ContentController.content[0][i]] = [
        for (int j = 1; j < _ContentController.content.length; j++)
          _ContentController.content[j][i]
      ];
    }

    //Get Toppers of Class.
    //Creating Map: Seat Number: Percentage
    //for e.g 14353:92.44
    temp = {};
    for (int i = 0; i < contentDict['Seat Number'].length; i++) {
      if (contentDict['Percentage'][i] == "" ||
          contentDict['Percentage'][i] == null) continue;
      temp[contentDict['Seat Number'][i]] =
          double.parse(contentDict['Percentage'][i]);
    }
    //Sorting Map to get Top3 of class
    classToppers = Map.fromEntries(
        temp.entries.toList()..sort((e1, e2) => e2.value.compareTo(e1.value)));
    temp = {};
    //Get Status of Students
    //for e.g FIRST CLASS DIST: 22, A.T.K.T: 2.
    status = {};
    contentDict['Status'].forEach((element) {
      if (!status.containsKey(element))
        status[element] = 1;
      else
        status[element] += 1;
    });

    //1) Getting all the subject names and creating a dictionary to find marks of each subject with each value refernce to seat Number.
    // For e.g Subject Name : {Seat Number: Value}
    var subjectWiseStudents = {};
    contentDict.keys.forEach((element) {
      temp = {};
      if (![
        'Seat Number',
        'Name',
        'Percentage',
        'Total Marks Obtained',
        'Credits',
        'Status'
      ].contains(element)) {
        for (int i = 0; i < contentDict['Seat Number'].length; i++) {
          if (contentDict[element][i] == "" || contentDict[element][i] == null)
            continue;

          temp[contentDict['Seat Number'][i]] = double.parse(
              contentDict[element][i].replaceAll(new RegExp(r'[^0-9]'), ''));
        }
        subjectWiseStudents.addAll({element: temp});
      }
    });

    //here I have sorted marks of each subject.
    for (var k in subjectWiseStudents.keys) {
      temp = subjectWiseStudents[k];
      subjectWiseSortedStudents[k] = Map.fromEntries(temp.entries.toList()
        ..sort((e1, e2) => e2.value.compareTo(e1.value)));
    }
  }
}
