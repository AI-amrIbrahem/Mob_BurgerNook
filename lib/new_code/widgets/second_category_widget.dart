import 'package:burgernook/new_code/features/basket/data/models/order_details_model.dart';
import 'package:burgernook/new_code/features/home/data/models/product_model.dart';
import 'package:burgernook/new_code/util/resources/ColorsUtils.dart';
import 'package:burgernook/new_code/util/resources/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../features/basket/presentation/controllers/basket_controller.dart';
import '../features/home/data/models/category_model.dart';
import '../features/product/presentation/views/product_screen.dart';
import '../util/network/service.dart';

class SecondCategoryWidget extends StatefulWidget {
  CategoryModel category;

  SecondCategoryWidget({required this.category});

  @override
  _SecondCategoryWidgetState createState() => _SecondCategoryWidgetState();
}

class _SecondCategoryWidgetState extends State<SecondCategoryWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
              child: Text(
                Get.locale!.languageCode == "en"
                    ? (widget.category.nameEn)
                    : (widget.category.nameAr),
                style: TextStyle(
                    fontFamily: "GE_Dinar_One_Medium",
                    color:Get.isDarkMode? AppColors.mainColor:AppColors.accentColor5,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Container(
            height: 170.h,
            padding: EdgeInsets.only(right: 5.w, left: 5.w),
            width: MediaQuery.of(context).size.width,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: widget.category.products!.map((ProductModel product) {
                return InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            ProductDetailsScreen(product: product)));
                  },
                  child: MyCard(product),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class MyCard extends StatelessWidget {
  ProductModel product;

  MyCard(this.product);

  @override
  Widget build(BuildContext context) {
    // final basket = Provider.of<Basket>(context);
    return Container(
      margin: EdgeInsets.only(left: 10.w, top: 10.h, bottom: 10.h),
      child: Container(
        decoration: BoxDecoration(

          color: AppColors.White,
          boxShadow: [
            BoxShadow(
                color: AppColors.accentColor5.withOpacity(.3),
                blurRadius: 6,
                offset: Offset.fromDirection(140)),
          ],
          borderRadius: BorderRadius.circular(10.r),
        ),
        // height: 120.h,
        child: Row(
          children: [
            Container(
              width: 135.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.r),
              ),
              padding: EdgeInsets.only(left: 10.w, top: 10.h, right: 10.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                // mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Flexible(
                    child: Text(
                      "${Get.locale!.languageCode != "en" || product.nameEn.isEmpty ? product.nameAr : product.nameEn}",
                      //"${Get.locale!.languageCode != "en" ? product.nameAr : product.nameEn ==null ?(product.nameAr??''): product.nameEn!.isEmpty ? (product.nameAr??'') : (product.nameEn??'') }",
                      style: TextStyle(
                        fontSize: 18.sp,
                        color: AppColors.mainColor,
                        fontWeight: FontWeight.bold,
                      ),
                      // overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 8.0.w, left: 8.0.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                            onTap: () {
                              product.price!.product = product;
                              OrderDetailsModel orderDetails = OrderDetailsModel(
                                  prices: product.price!,
                                  total: product.price!.price,
                                  orderAdditions: []);
                              Get.find<BasketController>().setOrderDetails(orderDetails1: orderDetails);
                            },
                            child: Container(
                              height: 30.h,
                              width: 30.w,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColors.mainColor),
                              child: Icon(
                                Icons.add,
                                color: AppColors.White,
                              ),
                            )),
                        Container(
                          padding: EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: AppColors.colorG,
                            borderRadius: BorderRadius.circular(5.r),
                          ),
                          child: Text(
                            "${product.price!.price} SR",
                            textDirection: TextDirection.ltr,
                            style: TextStyle(
                              fontFamily: "arlrdbd",
                              color: AppColors.accentW,
                              fontSize: 16.sp
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Container(
              // height: 100.h,
              width: 100.w,
              child: Center(
                child: FadeInImage(
                  image: NetworkImage(
                      "${ServiceUrls.domain}/image/uploads/${product.imageName}"),
                  placeholder: AssetImage(AppAssets.loading),
                  imageErrorBuilder: (context, error, stackTrace) {
                    return SizedBox(
                      child: Image.asset('assets/holder.jpeg',
                          fit: BoxFit.fitWidth),
                    );
                  },
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
