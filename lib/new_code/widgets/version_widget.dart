import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../main.dart';

class VersionWidget extends StatelessWidget {
  const VersionWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return

      Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Column(
            children: [

              Text(packageInfo.version,style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold
              ),),
              // Image.asset('assets/images/logo.png')
              // Text('http://sitksa-eg.com',style: TextStyle(
              //     fontSize: 16.sp,
              //     fontWeight: FontWeight.bold,
              //   color: Colors.blue
              // ),),
            ],
    ),
            Text('http://sitksa-eg.com',style: TextStyle(
                fontSize: 16.sp,
                // fontWeight: FontWeight.bold,
                color: Colors.blue
            ),),
            Directionality(
              textDirection: TextDirection.rtl,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/logo_sit.png',height: 20.h,width: 20,),
                  Text('  powered by  ',style: TextStyle(
                    fontSize: 13.sp,
                    // fontWeight: FontWeight.bold
                  ),),

                ],
              ),
            ),
            SizedBox(height: 10.h,)
          ],
        ),
      );
  }
}
