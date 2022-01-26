import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:scrapie/AdHelper/AdHelper.dart';
import 'package:scrapie/Controller/AnalyzeController.dart';

class ViewStudResult extends StatefulWidget {
  const ViewStudResult({Key? key}) : super(key: key);

  @override
  _ViewStudResultState createState() => _ViewStudResultState();
}

class _ViewStudResultState extends State<ViewStudResult> {
  AnalyzeController _anaControler = Get.put(AnalyzeController());
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: _isBannerAdReady
          ? Container(
              width: _bannerAd.size.width.toDouble(),
              height: _bannerAd.size.height.toDouble(),
              child: AdWidget(ad: _bannerAd),
            )
          : SizedBox(),
      body: Center(
        child: Text("hello"),
      ),
    );
  }
}
