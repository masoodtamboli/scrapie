import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:scrapie/AdHelper/AdHelper.dart';
import 'package:scrapie/Constants/Values.dart';
import 'package:scrapie/Controller/FetchController.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //Google Banner Ads Variables
  late BannerAd _bannerAd;
  bool _isBannerAdReady = false;

  //Google Interstitial Ads Variables
  late InterstitialAd _interstitialAd;
  bool _isInterstitialReady = false;

  bool isRememberMe = false; //^ Required for Checkbox

  //^ Required for Form
  final _formKey = GlobalKey<FormState>();
  TextEditingController _startSeat = new TextEditingController();
  TextEditingController _endSeat = new TextEditingController();
  TextEditingController _email = new TextEditingController();

  //^ FetchConroller Getx Initiliazition
  FetchController _fetchController = Get.put(FetchController());

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

    InterstitialAd.load(
      adUnitId: AdHelper.interstitialAdUnitId,
      request: AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(onAdLoaded: (ad) {
        setState(() {
          this._interstitialAd = ad;
          _isInterstitialReady = true;
        });
      }, onAdFailedToLoad: (error) {
        log("Failed to load Interstitial Ad ${error.message}");
      }),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _bannerAd.dispose();
    _interstitialAd.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Home",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        backgroundColor: primaryColor,
        elevation: 0,
        leading: Icon(Icons.arrow_back_outlined, color: Colors.black),
      ),
      bottomNavigationBar: _isBannerAdReady
          ? Container(
              width: _bannerAd.size.width.toDouble(),
              height: _bannerAd.size.height.toDouble(),
              child: AdWidget(ad: _bannerAd),
            )
          : SizedBox(),
      body: Align(
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                topLogo(),
                SizedBox(height: 40),
                startSeatNumberTF(),
                SizedBox(height: 30),
                endSeatNumberTF(),
                SizedBox(height: 20),
                getResults(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget topLogo() {
    return CircleAvatar(
      backgroundImage: AssetImage("assets/Images/msbteLogo.png"),
      radius: 50.0,
    );
  }

  Widget emailTF() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
      child: Form(
        child: TextFormField(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          controller: _email,
          validator: (value) {
            String pattern =
                r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$";
            RegExp regex = new RegExp(pattern);
            if (value == null || value.isEmpty) {
              return 'Email address should not be empty';
            }
            if (!regex.hasMatch(value)) {
              return 'Please enter valid email address';
            }
            return null;
          },
          keyboardType: TextInputType.emailAddress,
          style: TextStyle(color: Colors.black87),
          decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
            filled: true,
            fillColor: Colors.white,
            contentPadding: EdgeInsets.only(left: 10),
            hintText: "someone@example.com",
            hintStyle: TextStyle(color: Colors.black38),
          ),
        ),
      ),
    );
  }

  Widget startSeatNumberTF() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("  Start Seat Number",
              style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.bold)),
          SizedBox(height: 10),
          TextFormField(
            controller: _startSeat,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Seat Number should not be empty';
              }
              if (value.length != 6) {
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

  Widget endSeatNumberTF() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "  End Seat Number",
            style: TextStyle(
              fontSize: 16.0,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),
          TextFormField(
            controller: _endSeat,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Seat Number should not be empty';
              }
              if (value.length != 6) {
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
              hintText: "173356",
              hintStyle: TextStyle(color: Colors.black38),
            ),
          ),
        ],
      ),
    );
  }

  Widget getResults() {
    return Container(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(30, 15, 30, 0),
        child: ElevatedButton(
          onPressed: () {
            if (_isInterstitialReady) {
              log('Hello');
              _interstitialAd.show();
            }
            //^ If conditions are valid then fetch Results
            if (_formKey.currentState!.validate()) {
              if (!(int.parse(_startSeat.text) < int.parse(_endSeat.text))) {
                //* Check if Start Seat is less thant end Seat if True Display DIalog
                Get.defaultDialog(
                  title: "Alert",
                  titleStyle:
                      TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                  barrierDismissible: false,
                  middleText:
                      "Start Seat No. should be smaller than End Seat No.",
                  confirm: Align(
                    alignment: Alignment.bottomRight,
                    child: TextButton(
                      onPressed: () {
                        Get.back();
                      },
                      child: Text(
                        "Ok",
                        style: TextStyle(
                            color: primaryColor, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                );
              } else {
                _fetchController.fetchResults(
                    _startSeat.text, _endSeat.text); //* Start fetching results
                //*Show Progress

                Get.defaultDialog(
                  title: "Scraping Results",
                  titlePadding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                  titleStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                  barrierDismissible: false,
                  content: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                        child: LinearProgressIndicator(),
                      ),
                      SizedBox(height: 10),
                      Obx(() => Text(
                          "${_fetchController.completedSeats.toString()} / ${_endSeat.text}"))
                    ],
                  ),
                  cancel: TextButton(
                    onPressed: () {
                      _fetchController.interrupt = true;
                      Get.back();
                    },
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: Text(
                        "Cancel",
                        style: TextStyle(
                          color: primaryColor,
                        ),
                      ),
                    ),
                  ),
                );
              }
            }
          },
          style: ElevatedButton.styleFrom(
            primary: primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            elevation: 5,
          ),
          child: Text(
            "Submit",
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
            ),
          ),
        ),
      ),
    );
  }
}
