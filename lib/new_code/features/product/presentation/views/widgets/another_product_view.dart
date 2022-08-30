//
// body: SafeArea(
//   child: SingleChildScrollView(
//     child: Stack(children: [
//       Stack(
//         children: <Widget>[
//           InkWell(
//             onTap: () {
//               Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                       builder: (context) => ShowImage(
//                         url:
//                         '${ServiceUrls.domain}/image/uploads/${widget.product.imageName}',
//                       )));
//             },
//             child: Container(
//               width: MediaQuery.of(context).size.width,
//               height: MediaQuery.of(context).size.height / 2,
//               child: FadeInImage(
//                 image: NetworkImage('${ServiceUrls.domain}/image/uploads/${widget.product.imageName}'),
//                 placeholder: AssetImage(AppAssets.loading),
//                 imageErrorBuilder:
//                     (context, error, stackTrace) {
//                   return SizedBox(
//                     child: Image.asset(
//                         'assets/holder.jpeg',
//                         fit: BoxFit.cover),
//                   );
//                 },
//                 fit: BoxFit.cover,
//               ),
//             ),
//           ),
//           Align(
//             alignment: Alignment.topRight,
//             child: Padding(
//               padding: const EdgeInsets.all(8),
//               child: IconButton(
//                 icon: Icon(
//                   Icons.arrow_back,
//                   color: AppColors.accentColor1,
//                 ),
//                 onPressed: () {
//                   Navigator.of(context).pop();
//                 },
//                 color: Colors.white,
//               ),
//             ),
//           ),
//         ],
//       ),
//       Container(
//         decoration: BoxDecoration(
//           boxShadow: [
//             BoxShadow(
//                 color: AppColors.accentColor5.withOpacity(.3),
//                 blurRadius: 6,
//                 offset: Offset.fromDirection(140)),
//           ],
//           color: AppColors.White,
//           borderRadius: BorderRadius.only(
//               topLeft: Radius.circular(30),
//               topRight: Radius.circular(30)),
//         ),
//         margin: EdgeInsets.only(
//           top: MediaQuery.of(context).size.width - 150,
//         ),
//         child: Padding(
//           padding:
//           EdgeInsets.only(top: 25, bottom: 5, left: 15, right: 15),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: <Widget>[
//               Text(
//                 "${Get.locale!.languageCode != "en" || widget.product.nameEn.isEmpty ? widget.product.nameAr : widget.product.nameEn}",
//                 style:
//                 TextStyle(color: AppColors.titleText, fontSize: 25),
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: <Widget>[
//                     Container(
//                       margin: EdgeInsets.symmetric(vertical: 10),
//                       child: Text(
//                         "the ingredients".tr,
//                         //   'المكونات',
//                         style: TextStyle(
//                             color: AppColors.titleText,
//                             fontWeight: FontWeight.bold,
//                             fontSize: 15.sp),
//                       ),
//                     ),
//                     Container(
//                       child: Text(
//                         //    '${widget.product.prduct_components}',
//                         "${Get.locale!.languageCode != "en" || widget.product.prduct_componentsEn.isEmpty ? widget.product.prduct_components : widget.product.prduct_componentsEn}",
//                         style: TextStyle(
//                             color: AppColors.subText,
//                             fontWeight: FontWeight.bold,
//                             fontSize: 13.sp),
//                         textAlign: TextAlign.center,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               SizedBox(
//                 height: 10.h,
//               ),
//               widget.product.prices![0].size_id == "16"
//                   ? Container()
//                   : Container(
//                 width: MediaQuery.of(context).size.width,
//                 color: AppColors.White,
//                 alignment: Alignment.center,
//                 child: widget.product.prices == null
//                     ? Container()
//                     : Column(
//                   children: <Widget>[
//                     widget.product.prices!.isEmpty
//                         ? Container()
//                         : Container(
//                       width: MediaQuery.of(context)
//                           .size
//                           .width,
//                       padding:
//                       const EdgeInsets.all(8.0),
//                       child: Text(
//                         "Choose the size".tr,
//                         //     'اختر الحجم',
//                         style: TextStyle(
//                             color: AppColors.accentColor5,
//                             fontSize: 15.sp,
//                             fontWeight:
//                             FontWeight.bold),
//                       ),
//                     ),
//                     GetBuilder<ProductController>(
//                       builder:(_)=> Container(
//                         child: ListView.builder(
//                           shrinkWrap: true,
//                           physics:
//                           NeverScrollableScrollPhysics(),
//                           itemCount:
//                           widget.product.prices!.length,
//                           itemBuilder: (context, index) {
//                             return RadioListTile(
//                               value: index,
//                               groupValue: productController.value,
//                               onChanged: (index) =>
//                                   productController.changeSize(index),
//                               title: Row(
//                                 mainAxisAlignment:
//                                 MainAxisAlignment
//                                     .spaceBetween,
//                                 children: <Widget>[
//                                   Text(
//                                       "${Get.locale!.languageCode == "en" ? widget.product.prices![index].size_name == "وسط" ? "Middle" : "Large" : widget.product.prices![index].size_name}"),
//                                   Text(
//                                     "${widget.product.prices![index].price} SR",
//                                     textDirection:
//                                     TextDirection.ltr,
//                                     style: TextStyle(
//                                         fontFamily: "arlrdbd",
//                                         fontSize: 13.sp),
//                                   ),
//                                 ],
//                               ),
//                             );
//                           },
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               SizedBox(
//                 height: 20.h,
//               ),
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: <Widget>[
//                   widget.product.additions!.isNotEmpty
//                       ? Container(
//                     margin: EdgeInsets.symmetric(vertical: 10),
//                     child: Text(
//                       "Additions".tr,
//                       //     'الاضافات',
//                       style: TextStyle(
//                           color: AppColors.titleText,
//                           fontWeight: FontWeight.bold,
//                           fontSize: 15.sp),
//                     ),
//                   )
//                       : Container(),
//                   GetBuilder<ProductController>(
//                     builder:(_)=> Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: (widget.product.additions != null)
//                             ? widget.product.additions!
//                             .map((AdditionModel addition) {
//                           if (addition != null) {
//                             if (addition.addition_data!.nameAr
//                                 .isNotEmpty &&
//                                 addition.addition_data!.nameEn
//                                     .isNotEmpty) {
//                               productController.counter++;
//                               return CheckboxListTile(
//                                 value: addition.isActive,
//                                 onChanged: (value) {
//                                  productController.changeAdditions(value,addition);
//                                 },
//                                 secondary: Text(
//                                   ' ${Get.locale!.languageCode != "en" || addition.addition_data!.nameEn.isEmpty ? addition.addition_data!.nameAr : addition.addition_data!.nameEn}',
//                                   style: TextStyle(
//                                       color: AppColors.accentColor5,
//                                       fontSize: 13.sp),
//                                 ),
//                                 title: Text(
//                                   "${addition.price} SR",
//                                   textDirection: TextDirection.ltr,
//                                   style: TextStyle(
//                                     fontFamily: "arlrdbd",
//                                     fontSize: 13.sp,
//                                     color: AppColors.accentColor,
//                                   ),
//                                 ),
//                               );
//                             }
//                           }
//                           return Container();
//                         }).toList()
//                             : []),
//                   ),
//                 ],
//               ),
//               SizedBox(
//                 height: 20.h,
//               ),
//               widget.product.has_drink == "Yes"
//                   ? Container(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: <Widget>[
//                     Container(
//                       child: Text(
//                         "Choose a drink type"
//                             .tr, // 'اختر نوع المشروب',
//                         style: TextStyle(
//                             color: AppColors.titleText,
//                             fontWeight: FontWeight.bold,
//                             fontSize: 15.sp),
//                       ),
//                     ),
//                     GetBuilder<ProductController>(
//                       builder:(_)=> Container(
//                         margin: EdgeInsets.symmetric(horizontal: 14),
//                         padding:
//                         EdgeInsets.symmetric(horizontal: 8.0),
//                         child: DropdownButton<String>(
//                           isExpanded: true,
//                           value: productController.orderDetails.drink,
//                           items: <String>[
//                             "Pepsi",
//                             "7-UP",
//                             //     "water",
//                             "Miranda",
//                             "mountain dew",
//                             "Diet Pepsi",
//                             //    "ice Tea",
//                             //    "cocktail juice",
//                             //    "Apple juice",
//                             //    "Orange juice",
//                           ].map((String value) {
//                             return new DropdownMenuItem<String>(
//                               value: value,
//                               child: new Text(
//                                 value,
//                                 style: TextStyle(fontSize: 15.sp),
//                               ),
//                             );
//                           }).toList(),
//                           onChanged: (value) {
//                             productController.changeJuice(value);
//
//                           },
//                         ),
//                       ),
//                     )
//                   ],
//                 ),
//               )
//                   : Container(),
//               SizedBox(
//                 height: 20.h,
//               ),
//               Container(
//                 margin: EdgeInsets.symmetric(
//                   horizontal: 15,
//                 ),
//                 child: TextField(
//                   maxLines: 20,
//                   maxLength: 900,
//                   minLines: 4,
//                   keyboardType: TextInputType.emailAddress,
//                   decoration: InputDecoration(
//                     errorText: productController.errorNote ? productController.errorN : null,
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(5),
//                     ),
//                     prefixIcon: Icon(Icons.details),
//                     labelText:
//                     "Add more details".tr, //'اضف المذيد من التفاصيل',
//                   ),
//                   onChanged: (input) {
//                     //   widget.product.price.note = input;
//                     productController.orderDetails.note = input;
//                   },
//                   onSubmitted: (input) {},
//                 ),
//               ),
//               SizedBox(
//                 height: 15.h,
//               ),
//               Container(
//                 margin: EdgeInsets.symmetric(vertical: 10),
//                 padding: EdgeInsets.symmetric(vertical: 10),
//                 width: MediaQuery.of(context).size.width,
//                 alignment: Alignment.center,
//                 child: Row(
//                   children: [
//                     Text(
//                       ' ${"Total".tr} ',
//                       textDirection: TextDirection.ltr,
//                       style: TextStyle(
//                           color: AppColors.titleText,
//                           fontWeight: FontWeight.bold,
//                           fontSize: 25.sp,
//                           fontFamily: "arlrdbd"),
//                     ),
//                     Text(
//                       ' : ',
//                       textDirection: TextDirection.ltr,
//                       style: TextStyle(
//                           color: AppColors.titleText,
//                           fontSize: 25.sp,
//                           fontFamily: "arlrdbd"),
//                     ),
//                     GetBuilder<ProductController>(
//                       builder:(_)=> Container(
//                         padding: EdgeInsets.all(4),
//                         decoration: BoxDecoration(
//                           color: AppColors.colorG,
//                           borderRadius: BorderRadius.circular(5.r),
//                         ),
//                         child: Text(
//                           '${productController.orderDetails.total} SR',
//                           textDirection: TextDirection.ltr,
//                           style: TextStyle(
//                               fontFamily: "arlrdbd",
//                               color: AppColors.accentW,
//                               fontSize: 15.sp),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               Center(
//                 child: Container(
//                   width: 130.w,
//                   child: InkWell(
//                     onTap: () {
//                       productController.addProduct();
//                       basket.setOrderDetails(orderDetails1: productController.orderDetails);
//                       Get.back();
//                     },
//                     child: Stack(
//                       children: [
//                         Align(
//                           alignment: Alignment.center,
//                           child: Container(
//                               margin: EdgeInsets.only(bottom: 20.h, top: 20.h),
//                               width: 130.w,
//                               alignment: Alignment.center,
//                               decoration: BoxDecoration(
//                                   color: AppColors.mainColor,
//                                   borderRadius: BorderRadius.circular(5.r)),
//                               child: Padding(
//                                 padding: EdgeInsets.all(5),
//                                 child: Text(
//                                   "addition".tr, // 'إضافة',
//                                   style: TextStyle(
//                                       fontSize: 24.sp, color: AppColors.accentColor5),
//                                 ),
//                               )),
//                         ),
//                         Align(
//                           alignment: AlignmentDirectional.topStart,
//                           child: Image.asset(
//                             "assets/basket1.png",
//                             height: 30.h,
//                             width: 30.w,
//                           ),
//                         )
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     ]),
//   ),
// ),