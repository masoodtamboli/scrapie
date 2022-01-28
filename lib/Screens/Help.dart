import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:scrapie/Constants/Values.dart';
import 'package:url_launcher/url_launcher.dart';

class Help extends StatefulWidget {
  const Help({Key? key}) : super(key: key);

  @override
  _HelpState createState() => _HelpState();
}

class _HelpState extends State<Help> {
  openWhatsapp() async {
    var whatsappURL = "https://wa.me/+917385122355";
    var smsURL = "sms:7385122355?body=hello%20there";
    if (await canLaunch(whatsappURL)) {
      await launch(whatsappURL);
    } else if (await canLaunch(smsURL)) {
      await launch(smsURL);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: new Text("Whatsapp or Messaging app is not installed")));
    }
  }

  openYoutube() async {
    var url = "https://www.youtube.com/watch?v=HNYN0j5Fak8";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: new Text("Something went wrong")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text("Request Help",
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
          backgroundColor: primaryColor,
          elevation: 0,
          leading: Icon(Icons.arrow_back_outlined, color: Colors.black),
        ),
        body: Align(
          alignment: Alignment.topCenter,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
                child: Image.asset("assets/Images/help.png"),
              ),
              Spacer(),
              Text(
                "How can we help you?",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                  letterSpacing: 1,
                  wordSpacing: 0.3,
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
                child: Text(
                  "It looks like you are experiencing some problem with Scrapie. Please watch the Tutorial if you haven't or if your problems have not resolved we are here to help so please get in touch with us.",
                  textAlign: TextAlign.center,
                  style: TextStyle(letterSpacing: 1, wordSpacing: 0.3),
                ),
              ),
              Spacer(),
              Row(
                children: [
                  Spacer(),
                  InkWell(
                    onTap: () {
                      openWhatsapp();
                    },
                    child: Material(
                      elevation: 10,
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                        ),
                        width: 100,
                        height: 100,
                        child: Column(
                          children: [
                            Image.asset(
                              "assets/Icons/chat.jpg",
                              width: 70,
                              height: 70,
                            ),
                            Text(
                              "Chat to us",
                              style: TextStyle(
                                letterSpacing: 0.8,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Spacer(),
                  InkWell(
                    onTap: () {
                      openYoutube();
                    },
                    child: Material(
                      elevation: 10,
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                        ),
                        width: 100,
                        height: 100,
                        child: Column(
                          children: [
                            Image.asset(
                              "assets/Icons/youtube.png",
                              width: 70,
                              height: 70,
                            ),
                            Text(
                              "Tutorial",
                              style: TextStyle(
                                letterSpacing: 0.8,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Spacer(),
                  InkWell(
                    onTap: () {},
                    child: Material(
                      elevation: 10,
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                        ),
                        width: 100,
                        height: 100,
                        child: Column(
                          children: [
                            Image.asset(
                              "assets/Icons/email.jpg",
                              width: 70,
                              height: 70,
                            ),
                            Text(
                              "Email us",
                              style: TextStyle(
                                letterSpacing: 0.8,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Spacer(),
                ],
              ),
              Spacer(),
            ],
          ),
        ));
  }
}
