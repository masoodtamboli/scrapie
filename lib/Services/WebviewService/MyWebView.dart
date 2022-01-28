import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scrapie/Controller/Firestore.dart';

import 'package:webview_flutter/webview_flutter.dart';
import 'package:zoom_widget/zoom_widget.dart';

class MyWebView extends StatefulWidget {
  final enrNumber, seatNumber;

  const MyWebView(this.enrNumber, this.seatNumber, {Key? key})
      : super(key: key);

  @override
  _MyWebViewState createState() => _MyWebViewState();
}

class _MyWebViewState extends State<MyWebView> {
  FirestoreController _fireController = Get.put(FirestoreController());

  @override
  void initState() {
    super.initState();
    setURL();
  }

  String URL = "";

  void setURL() {
    if (widget.enrNumber.isNotEmpty) {
      print(widget.enrNumber);
      URL = _fireController.enrURL +
          widget.enrNumber[0] +
          widget.enrNumber[1] +
          "/" +
          widget.enrNumber +
          "Marksheet.html";
    } else {
      URL = _fireController.seatURL +
          widget.seatNumber[0] +
          widget.seatNumber[1] +
          "/" +
          widget.seatNumber +
          "Marksheet.html";
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.black,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text("Student Result", style: TextStyle(color: Colors.black)),
        backgroundColor: Color(0xffFFB901),
      ),
      body: Zoom(
        maxZoomWidth: size.width * 3,
        maxZoomHeight: size.height * 3,
        child: WebView(
          initialUrl: URL,
        ),
      ),
    );
  }
}
