import 'package:burgernook/new_code/util/resources/ColorsUtils.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../features/home/domain/entity/slider_entity.dart';
import '../util/network/service.dart';

class HomeSliderWidget extends StatefulWidget {
  final List<SliderHomeModel> slides;

  HomeSliderWidget({required this.slides});

  @override
  _HomeSliderWidgetState createState() => _HomeSliderWidgetState();
}

class _HomeSliderWidgetState extends State<HomeSliderWidget> {
  List<SliderHomeModel> sliders = [];
  bool isLading = true;

  @override
  void initState() {
    super.initState();
  }

  int _current = 0;

  @override
  Widget build(BuildContext context) {
    if (isLading != false) sliders = widget.slides;
    if (sliders.isNotEmpty) {
      isLading = false;
      print('slider work ');
    }
    print('slider work 1');

    return isLading
        ? _ladingWidget()
        : sliders.isEmpty
            ? Container(
                height: 200,
                alignment: Alignment.center,
                child: Text("فارغ"),
              )
            :

    Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
      CarouselSlider(
        options: CarouselOptions(
          // onPageChanged: (index, _) {
          //   setState(() {
          //     _current = index;
          //   });
          // },
          height: 220.h,
          // MediaQuery.of(context).size.height / 3.5,
          aspectRatio: 2,
          viewportFraction: 0.9,

          initialPage: 0,
          enableInfiniteScroll: true,
          reverse: false,
          autoPlay: true,
          autoPlayInterval: Duration(seconds: 3),
          autoPlayAnimationDuration: Duration(milliseconds: 800),
          autoPlayCurve: Curves.fastOutSlowIn,
          // pauseAutoPlayOnTouch: Duration(seconds: 10),
          // enlargeCenterPage: true,
          scrollDirection: Axis.horizontal,
        ),
        items: sliders.map((SliderHomeModel sliderModel) {
          return InkWell(
            onTap: () {
              print(sliderModel.content);
              /*   if (sliderModel.action.isNotEmpty) {
                            switch (sliderModel.action) {
                              case "link":
                                launchURL(sliderModel.content);
                                break;
                            }
                          }*/
            },
            child: Container(
              width: double.infinity,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: CachedNetworkImage(
                  imageUrl:
                  '${ServiceUrls.domain}/slider/uploads/${sliderModel.name}',
                  placeholder: (context, url) => Image.asset(
                    'assets/holder.jpeg',
                    fit: BoxFit.fill,
                  ),
                  errorWidget: (context, url, error) => Image.asset(
                      'assets/holder1.jpeg',
                      fit: BoxFit.fill),
                  fit: BoxFit.fill,
                ),
              ),
              margin:
              EdgeInsets.only(top:10.w,right: 5.w,left: 5.w,bottom: 5.w),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                    Radius.circular(50)),
                // image: DecorationImage(
                //   image: CachedNetworkImage(
                //     imageUrl: '$domain/slider/uploads/${sliderModel.name}',
                //     placeholder: (context, url) => CircularProgressIndicator(),
                //     errorWidget: (context, url, error) => Icon(Icons.error),
                //   ),
                //   //
                //   // NetworkImage(
                //   //   '$domain/slider/uploads/${sliderModel.name}',
                //   // ),
                //   fit: BoxFit.fill,
                // ),
              ),
            ),
          );
        }).toList(),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: sliders.map((url) {
          int index = sliders.indexOf(url);
          return Container(
            width: 8.0,
            height: 8.0,
            margin:
            EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _current == index
                    ? AppColors.mainColor //Color.fromRGBO(0, 0, 0, 0.9)
                    : Color(
                    0xff2f3030) //Color.fromRGBO(0, 0, 0, 0.4),
            ),
          );
        }).toList(),
      ),
    ]);
  }

  Widget _ladingWidget() {
    return CarouselSlider(
      options: CarouselOptions(
        height: 200,
        // MediaQuery.of(context).size.height / 3.5,
        aspectRatio: 16 / 9,
        viewportFraction: 0.8,
        initialPage: 0,
        enableInfiniteScroll: true,
        reverse: false,
        autoPlay: true,
        autoPlayInterval: Duration(seconds: 3),
        autoPlayAnimationDuration: Duration(milliseconds: 800),
        autoPlayCurve: Curves.fastOutSlowIn,
        // pauseAutoPlayOnTouch: Duration(seconds: 10),
        enlargeCenterPage: true,
        scrollDirection: Axis.horizontal,
      ),
      items: [
        Container(
            color: Colors.grey.withOpacity(.3),
            margin: EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
            child: CircularProgressIndicator(color: AppColors.mainColor,)),
        Container(
            color: Colors.grey.withOpacity(.3),
            margin: EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
            child: CircularProgressIndicator(color: AppColors.mainColor,)),
        Container(
            color: Colors.grey.withOpacity(.3),
            margin: EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
            child: CircularProgressIndicator(color: AppColors.mainColor,)),
      ],
    );
  }
}
