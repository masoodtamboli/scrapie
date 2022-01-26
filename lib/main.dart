import 'dart:developer';

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:scrapie/AdHelper/AdHelper.dart';
import 'package:scrapie/Constants/Values.dart';
import 'package:scrapie/Controller/init.dart';
import 'package:scrapie/Screens/Analyze.dart';
import 'package:scrapie/Screens/Home.dart';
import 'package:scrapie/Screens/Settings.dart';
import 'package:scrapie/Screens/View.dart';
import 'package:scrapie/Screens/ViewStudResult.dart';

// ^ Start of the app
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  MobileAds.instance.initialize();
  runApp(
    GetMaterialApp(
      title: "Scrapie",
      debugShowCheckedModeBanner: false,
      home: Scrapie(),
    ),
  );
}

class Scrapie extends StatefulWidget {
  @override
  _ScrapieState createState() => _ScrapieState();
}

class _ScrapieState extends State<Scrapie> {
  // ^ Variables required for Navigation Bar
  int _page = 0;
  List<Widget> _screens = [
    Home(),
    View(),
    Analyze(),
    ViewStudResult(),
    Settings(),
  ];

  //Google Ads Variables
  late InterstitialAd _interstitialAd;
  bool _isInterstitialReady = false;

  @override
  void initState() {
    super.initState();
    InterstitialAd.load(
      adUnitId: AdHelper.interstitialAdUnitId,
      request: AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(onAdLoaded: (ad) {
        this._interstitialAd = ad;
        _isInterstitialReady = true;
      }, onAdFailedToLoad: (error) {
        log("Failed to load Interstitial Ad ${error.message}");
      }),
    );
  }

  @override
  void dispose() {
    _interstitialAd.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_page], //& Show pages according to Navigation Index.
      bottomNavigationBar: CurvedNavigationBar(
        index: 0,
        height: 60,
        items: <Widget>[
          Icon(Icons.home),
          Icon(Icons.remove_red_eye),
          Icon(Icons.bar_chart),
          Icon(Icons.public),
          Icon(Icons.settings),
        ],
        color: primaryColor,
        buttonBackgroundColor: primaryColor,
        backgroundColor: Color(0xffffffff),
        animationCurve: Curves.linear,
        animationDuration: Duration(milliseconds: 300),
        onTap: (index) {
          if (index == 2) {
            if (_isInterstitialReady) {
              _interstitialAd.show();
            }
          }
          setState(() {
            _page = index;
          });
        },
        letIndexChange: (index) => true,
      ),
    );
  }
}
