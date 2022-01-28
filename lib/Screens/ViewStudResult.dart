import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:scrapie/AdHelper/AdHelper.dart';
import 'package:scrapie/Controller/AnalyzeController.dart';
import 'package:scrapie/Controller/Firestore.dart';
import 'package:scrapie/Services/WebviewService/MyWebView.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ViewStudResult extends StatefulWidget {
  const ViewStudResult({Key? key}) : super(key: key);

  @override
  _ViewStudResultState createState() => _ViewStudResultState();
}

class _ViewStudResultState extends State<ViewStudResult> {
  TextEditingController _seatNumber = new TextEditingController();
  TextEditingController _enrNumber = new TextEditingController();

  //Google Ads Variables
  late BannerAd _bannerAd;
  bool _isBannerAdReady = false;

  @override
  void initState() {
    super.initState();
    //Get Banner Ad
    _bannerAd = BannerAd(
        size: AdSize.banner,
        adUnitId: AdHelper.bannerAdUnitId,
        listener: BannerAdListener(onAdLoaded: (_) {
          setState(() {
            _isBannerAdReady = true;
          });
        }, onAdFailedToLoad: (ad, error) {
          log("Failed to load banner Ad ${error.message}");
          _isBannerAdReady = false;
          ad.dispose();
        }),
        request: AdRequest())
      ..load();
  }

  @override
  void dispose() {
    super.dispose();
    _bannerAd.dispose();
  }

  Widget seatNumberTF() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("  Seat Number",
              style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.bold)),
          SizedBox(height: 10),
          TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            controller: _seatNumber,
            validator: (value) {
              if (value!.length != 6) {
                return 'Please enter valid Seat Number';
              }
              return null;
            },
            keyboardType: TextInputType.number,
            style: TextStyle(color: Colors.black87),
            decoration: InputDecoration(
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
              filled: true,
              fillColor: Colors.white,
              contentPadding: EdgeInsets.only(left: 10),
              hintText: "173280",
              hintStyle: TextStyle(color: Colors.black38),
            ),
          ),
        ],
      ),
    );
  }

  Widget enrNumberTF() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "  Enrollment Number",
            style: TextStyle(
              fontSize: 16.0,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),
          TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            controller: _enrNumber,
            validator: (value) {
              if (value!.length != 10) {
                return 'Please enter valid Seat Number';
              }
              return null;
            },
            keyboardType: TextInputType.number,
            style: TextStyle(color: Colors.black87),
            decoration: InputDecoration(
              contentPadding: EdgeInsets.only(left: 10),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
              filled: true,
              fillColor: Colors.white,
              hintText: "1700150084",
              hintStyle: TextStyle(color: Colors.black38),
            ),
          ),
        ],
      ),
    );
  }

  Widget viewResult() {
    return Container(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(30, 15, 30, 0),
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        MyWebView(_enrNumber.text, _seatNumber.text)));
          },
          style: ElevatedButton.styleFrom(
            primary: Color(0xffFFB901),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            elevation: 5,
          ),
          child: Text(
            "Submit",
            style: TextStyle(
              color: Color(0xffffffff),
              fontSize: 18,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      bottomNavigationBar: _isBannerAdReady
          ? Container(
              width: _bannerAd.size.width.toDouble(),
              height: _bannerAd.size.height.toDouble(),
              child: AdWidget(ad: _bannerAd),
            )
          : SizedBox(),
      appBar: AppBar(
        leading: Icon(
          Icons.arrow_back,
          color: Colors.black,
        ),
        title: Text("Student Result", style: TextStyle(color: Colors.black)),
        backgroundColor: Color(0xffFFB901),
      ),
      body: Center(
        child: Container(
          margin: EdgeInsets.fromLTRB(30, 0, 30, 0),
          width: double.infinity,
          height: MediaQuery.of(context).size.height / 2,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                offset: Offset(5.0, 5.0), //(x,y)
                blurRadius: 10.0,
              ),
            ],
          ),
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                seatNumberTF(),
                SizedBox(height: 20),
                enrNumberTF(),
                SizedBox(height: 20),
                viewResult(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
