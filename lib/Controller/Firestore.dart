import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FirestoreController extends GetxController {
  String seatURL = "";
  String enrURL = "";
  final CollectionReference urlData =
      FirebaseFirestore.instance.collection("URL Data");
  void initFirestore() {
    urlData.get().then((value) => value.docs.forEach((element) {
          seatURL = element["Seat URL"];
          enrURL = element["Enr URL"];
        }));
  }
}
