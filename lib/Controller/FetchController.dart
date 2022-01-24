import 'dart:developer';

import 'package:beautiful_soup_dart/beautiful_soup.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:scrapie/Constants/Values.dart';

class FetchController extends GetxController {
  var response;
  String url = "";
  var completedSeats = 0.obs;
  bool interrupt = false;
  var subjects1, header1, names, marks, percentage, totalMarks, credits;

  List<String> subjects = [];
  List<String> header = [];

  List<List<String>> content = [];

  generateSubjects(BeautifulSoup _bs) {
    // & Fetches all Subject field i.e empty and non-empty
    var fetchedSubjects = _bs
        .findAll('table')[1]
        .findAll('td')
        .where((element) => element.attributes.length == 0);

    //& Select Subject names from fetchedSubjects which are not empty
    fetchedSubjects.forEach((element) {
      if (element.text.isNotEmpty) {
        subjects.add(element.text);
      }
    });
  }

  //& Subjects are required to generate Header
  generateHeader(BeautifulSoup _bs) {
    int count = 2;
    header.add("Seat Number");
    header.add("Name");
    var _table1 = _bs.findAll('table')[1];
    for (int i = 0; i < subjects.length; i++) {
      //Iterate in Subjects
      for (int j = count; j < _table1.findAll('tr').length; j++) {
        //Iteraet in tr's
        if (_table1
            .findAll('tr')[j]
            .find('td')!
            .findNextElement('td')!
            .text
            .isEmpty) {
          count = j;
          continue;
        } else if (_table1.findAll('tr')[j].findAll('td')[0].text.isEmpty) {
          header.add(subjects[i] +
              " [" +
              _table1.findAll('tr')[j].find('td')!.findNextElement('td')!.text +
              "]" +
              " [ESE]");

          header.add(subjects[i] +
              " [" +
              _table1.findAll('tr')[j].find('td')!.findNextElement('td')!.text +
              "]" +
              " [PA]");
          count = j;
        } else if (_table1.findAll('tr')[j].findAll('td')[0].text ==
            subjects[i]) {
          header.add(subjects[i] +
              " [" +
              _table1.findAll('tr')[j].find('td')!.findNextElement('td')!.text +
              "]" +
              " [ESE]");
          header.add(subjects[i] +
              " [" +
              _table1.findAll('tr')[j].find('td')!.findNextElement('td')!.text +
              "]" +
              " [PA]");
          count = j;
        } else {
          break;
        }
        count++;
      }
    }
    header.add('Percentage');
    header.add('Total Marks Obtained');
    header.add('Credits');
    header.add('Status');
    return header;
  }

  getName(BeautifulSoup _bs) {
    var name = _bs.findAll('table')[0].findAll('tr')[0].findAll('td')[1].text;
    return name;
  }

  getMarks(BeautifulSoup _bs) {
    List<String> marks = [];
    for (int i = 2; i < _bs.findAll('table')[1].findAll('tr').length; i++) {
      marks.add(_bs.findAll('table')[1].findAll('tr')[i].findAll('td')[5].text);
    }
    return marks;
  }

  getPercentage(BeautifulSoup _bs) {
    var percentage =
        _bs.findAll('table')[2].findAll('tr')[1].findAll('td')[1].text;
    return percentage;
  }

  getTotalMarksObtained(BeautifulSoup _bs) {
    var totalMarksObtained =
        _bs.findAll('table')[2].findAll('tr')[1].findAll('td')[2].text;
    return totalMarksObtained;
  }

  getCreditsObtained(BeautifulSoup _bs) {
    var credits =
        _bs.findAll('table')[2].findAll('tr')[1].findAll('td')[3].text;
    return credits;
  }

  getStatus(BeautifulSoup _bs) {
    var status = _bs.findAll('table')[2].findAll('tr')[2].findAll('td')[1].text;
    return status;
  }

  fetchResults(String startSeat, String endSeat) async {
    content.clear();
    header.clear();

    for (int i = int.parse(startSeat); i <= int.parse(endSeat); i++) {
      url =
          "https://msbte.org.in/DISRESLIVE2021CRSLDSEP/COV6139QS21LIVEResult/SeatNumber/" +
              startSeat[0] +
              endSeat[1] +
              "/" +
              i.toString() +
              "Marksheet.html";

      try {
        response = await http.get(Uri.parse(url));
      } catch (e) {
        Get.defaultDialog(
          title: "Error",
          titleStyle: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
          middleText: "Network Error!",
          confirm: Align(
            alignment: Alignment.bottomRight,
            child: TextButton(
              onPressed: () {
                Get.back();
              },
              child: Text(
                "Ok",
                style: TextStyle(
                  color: primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        );
        break;
      }

      BeautifulSoup _bs = BeautifulSoup(response.body);

      generateSubjects(_bs);

      if (header.isEmpty) {
        content.add(generateHeader(_bs));
      }

      content.add([
        i.toString(),
        getName(_bs),
        for (int k = 0; k < getMarks(_bs).length; k++) getMarks(_bs)[k],
        getPercentage(_bs),
        getTotalMarksObtained(_bs),
        getCreditsObtained(_bs),
        getStatus(_bs)
      ]);

      completedSeats.value = i;

      if (interrupt) {
        Get.snackbar("Alert", "Task Interrupted",
            icon: Icon(Icons.error, color: Colors.red, size: 30),
            duration: Duration(seconds: 5));
        interrupt = false;
        content.clear();
        header.clear();
        Get.back();
        break;
      }

      if (i == int.parse(endSeat)) {
        content.forEach((element) {
          log('${element}');
        });
        Get.back();
        completedSeats.value = 0;
        interrupt = false;
      }
    }
  }
}
