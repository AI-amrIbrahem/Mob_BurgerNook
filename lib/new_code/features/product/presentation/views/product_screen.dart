import 'package:burgernook/new_code/features/home/data/models/product_model.dart';
import 'package:burgernook/new_code/features/product/presentation/views/widgets/DrinkWidget.dart';
import 'package:burgernook/new_code/features/product/presentation/views/widgets/addtions_widget.dart';
import 'package:burgernook/new_code/features/product/presentation/views/widgets/button_product.dart';
import 'package:burgernook/new_code/features/product/presentation/views/widgets/comment_widget.dart';
import 'package:burgernook/new_code/features/product/presentation/views/widgets/component_widget.dart';
import 'package:burgernook/new_code/features/product/presentation/views/widgets/size_widget.dart';
import 'package:burgernook/new_code/features/product/presentation/views/widgets/total_widget.dart';
import 'package:burgernook/new_code/util/resources/ColorsUtils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../util/network/service.dart';
import '../../../../util/resources/app_assets.dart';
import '../../../basket/presentation/controllers/basket_controller.dart';
import '../controllers/product_controller.dart';

class ProductDetailsScreen extends StatefulWidget {
  ProductModel product;
  var productController = Get.put(ProductController());

  ProductDetailsScreen({required this.product});

  @override
  _ProductDetailsScreenState createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  ScrollController? _scrollController;
  bool lastStatus = true;
  double height = 200;

  void _scrollListener() {
    if (_isShrink != lastStatus) {
      setState(() {
        lastStatus = _isShrink;
      });
    }
  }

  bool get _isShrink {
    return _scrollController != null &&
        _scrollController!.hasClients &&
        _scrollController!.offset > (height - kToolbarHeight);
  }

  @override
  void dispose() {
    _scrollController?.removeListener(_scrollListener);
    _scrollController?.dispose();
    super.dispose();
  }

  var basket = Get.find<BasketController>();
  late ProductController productController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    productController = widget.productController;
    productController.init(widget.product);
    _scrollController = ScrollController()..addListener(_scrollListener);
  }

  @override
  Widget build(BuildContext context) {
    // final basket = Provider.of<Basket>(context);

    return Scaffold(
        backgroundColor: AppColors.White,
        body: CustomScrollView(
          controller: _scrollController,

          slivers: <Widget>[
            SliverAppBar(
              snap: false,
              pinned: true,
              floating: false,
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                title: _isShrink
                    ? Text(
                        "${Get.locale!.languageCode != "en" || widget.product.nameEn.isEmpty ? widget.product.nameAr : widget.product.nameEn}",
                        style:
                            TextStyle(color: AppColors.White, fontSize: 25.sp),
                      )
                    : null, //Text
                background: FadeInImage(
                  image: NetworkImage(
                      '${ServiceUrls.domain}/image/uploads/${widget.product.imageName}'),
                  placeholder: AssetImage(AppAssets.loading),
                  imageErrorBuilder: (context, error, stackTrace) {
                    return SizedBox(
                      child:
                          Image.asset('assets/holder.jpeg', fit: BoxFit.cover),
                    );
                  },
                  fit: BoxFit.cover,
                ),
              ),
              //FlexibleSpaceBar
              expandedHeight: 230.h,
              backgroundColor:Get.isDarkMode? AppColors.darkColor: AppColors.mainColor,
              leading: IconButton(
                icon: Icon(Icons.arrow_back),
                tooltip: 'back',
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ), //IconButton
            ), //SliverAppBar
            SliverToBoxAdapter(
              child: Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        color: AppColors.accentColor5.withOpacity(.3),
                        blurRadius: 6,
                        offset: Offset.fromDirection(140)),
                  ],
                  color:Get.isDarkMode? AppColors.darkColor:AppColors.White,

                  // color: AppColors.White,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30.r),
                      topRight: Radius.circular(30.r)),
                ),
                // margin: EdgeInsets.only(
                //   top: MediaQuery.of(context).size.width - 150,
                // ),
                child: Padding(
                  padding: EdgeInsets.only(
                      top: 25.h, bottom: 5.h, left: 15.w, right: 15.w),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      !_isShrink
                          ? Text(
                              "${Get.locale!.languageCode != "en" || widget.product.nameEn.isEmpty ? widget.product.nameAr : widget.product.nameEn}",
                              style: TextStyle(
                                   fontSize: 25.sp),
                            )
                          : Container(),
                      DetailsWidget(product: widget.product),
                      SizedBox(
                        height: 10.h,
                      ),
                      widget.product.prices![0].size_id == "16"
                          ? Container()
                          : SizeWidget(
                              product: widget.product,
                              productController: productController),
                      SizedBox(
                        height: 20.h,
                      ),
                      AdditionsWidget(
                          product: widget.product,
                          productController: productController),
                      SizedBox(
                        height: 20.h,
                      ),
                      widget.product.has_drink == "Yes"
                          ? DrinkWidget(productController: productController)
                          : Container(),
                      SizedBox(
                        height: 20.h,
                      ),
                      CommentWidget(productController: productController),
                      SizedBox(
                        height: 15.h,
                      ),
                      TotalWidget(productController: productController),
                      ButtonProduct(
                          productController: productController, basket: basket),
                    ],
                  ),
                ),
              ),
            )
          ], //<Widget>[]
        ));
  }
}
