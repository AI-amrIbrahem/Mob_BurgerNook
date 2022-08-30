import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AboutUsViewScreen extends StatefulWidget {
  @override
  _AboutUsScreenState createState() => _AboutUsScreenState();
}

class _AboutUsScreenState extends State<AboutUsViewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(
                          Get.locale!.languageCode == "en"
                              ? "assets/abouts-en.jpeg"
                              : "assets/abouts-ar.jpeg"),
                      fit: BoxFit.fill)),
            ),
            Align(
              alignment: Get.locale!.languageCode == "en"
                  ? Alignment.topLeft
                  : Alignment.topRight,
              child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 50),
                  child: IconButton(
                      icon: Icon(
                        Icons.arrow_back,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      })),
            )
          ],
        ));
  }
}
