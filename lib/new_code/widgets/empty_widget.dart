import 'package:flutter/material.dart';

Widget emptyWidget() {
  return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Center(
            child: Image.asset(
              "assets/basket3.png",
              height: 200,
            ),
          ),
          SizedBox(
            height: 20,
          ),
        ],
      ));
}