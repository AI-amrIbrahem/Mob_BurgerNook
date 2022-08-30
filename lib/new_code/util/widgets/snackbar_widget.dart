import 'package:get/get.dart';
import 'package:flutter/material.dart';


void successSnackBar(String head,String body){
   Get.showSnackbar(
       GetSnackBar(
         duration: Duration(seconds: 1),
           messageText: Directionality(
             textDirection: TextDirection.rtl,
             child: Text(head, style: TextStyle(
                 color: Colors.white,
             ),),
           ),
       )
  );
}

void failSnackBar(String head,String body){
  Get.showSnackbar(
      GetSnackBar(
        duration: Duration(seconds: 1),
        messageText: Directionality(
          textDirection: TextDirection.rtl,
          child: Text(head, style: TextStyle(
            color: Colors.white,
          ),),
        ),
      )
  );
}

showLoadingDialog(BuildContext context,{bool dismissible = true}) {
  showDialog(
      barrierDismissible: dismissible,
      context: context,
      builder: (ctx) => AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
                height: 50, width: 50, child: CircularProgressIndicator()),
          ],
        ),
      ));
}


dismissLoadingDialog(var context) {
  Navigator.pop(context);
}
