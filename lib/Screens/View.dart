import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:scrapie/AdHelper/AdHelper.dart';
import 'package:scrapie/Constants/Values.dart';
import 'package:scrapie/Controller/CsvController.dart';
import 'package:scrapie/Controller/FetchController.dart';

class View extends StatefulWidget {
  @override
  _ViewState createState() => _ViewState();
}

class _ViewState extends State<View> {
  FetchController _controller = Get.put(FetchController());
  CsvController _csvController = Get.put(CsvController());
  var path;
  late Size size;

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
    size = MediaQuery.of(context).size;
    return Scaffold(
      bottomNavigationBar: _isBannerAdReady
          ? Container(
              width: _bannerAd.size.width.toDouble(),
              height: _bannerAd.size.height.toDouble(),
              child: AdWidget(ad: _bannerAd),
            )
          : SizedBox(),
      appBar: AppBar(
        backgroundColor: primaryColor,
        leading: IconButton(
          onPressed: () {},
          icon: Icon(Icons.arrow_back_outlined, color: Colors.black),
        ),
        title: Text(
          "View",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        actions: [
          GestureDetector(
            onTap: () async {
              _csvController
                  .generateCSV()
                  .then((value) async => await FlutterShare.shareFile(
                        title: "Scraped Results",
                        filePath: value,
                      ));
            },
            child: Icon(Icons.share, color: Colors.black, size: 20),
          ),
          SizedBox(width: 15),
          GestureDetector(
            onTap: () {},
            child: Icon(Icons.refresh, color: Colors.black, size: 25),
          ),
          SizedBox(width: 20),
        ],
      ),
      body: _controller.content.isEmpty ? _empty() : _table(),
    );
  }

  Widget _table() {
    try {
      return SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            headingRowColor: MaterialStateColor.resolveWith(
                (states) => Colors.grey.shade300),
            columns: <DataColumn>[
              for (int i = 0; i < _controller.header.length; i++)
                DataColumn(
                  label: Text(
                    _controller.header[i],
                    style: TextStyle(fontStyle: FontStyle.italic),
                  ),
                ),
            ],
            rows: <DataRow>[
              for (int j = 1; j < _controller.content.length; j++)
                DataRow(
                  cells: <DataCell>[
                    for (int i = 0; i < _controller.content[j].length; i++)
                      DataCell(
                        Center(child: Text(_controller.content[j][i])),
                      ),
                  ],
                ),
            ],
          ),
        ),
      );
    } catch (e) {
      return Center(
        child: Text("Something went wrong!"),
      );
    }
  }

  Widget _empty() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: Container(
            width: size.width * 0.8,
            height: size.height * 0.3,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/Illustrations/empty.png"),
              ),
            ),
          ),
        ),
        Center(
          child: Text(
            "No data to show!",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: Color(0xffEEA82A),
            ),
          ),
        ),
      ],
    );
  }
}
