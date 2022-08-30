import 'package:burgernook/new_code/features/Auth/presentation/controllers/login_controller.dart';
import 'package:burgernook/new_code/features/orders/data/models/order_model.dart';
import 'package:burgernook/new_code/features/orders/presentation/controllers/track_order_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class TrackOrderScreen extends StatefulWidget {
  OrderModel order;
  bool isDriver;
  TrackOrderScreen(this.order, this.isDriver);

  @override
  _TrackOrderState createState() => _TrackOrderState();
}

class _TrackOrderState extends State<TrackOrderScreen> {

  var trackOrderController = Get.put(TrackOrderController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.isDriver == true) {
      print('driver 1');
      trackOrderController.setDriverLocation(widget.order.id);
      trackOrderController.enableFirebase(orderId:widget.order.id);
    } else {
      trackOrderController.getAddress(userId: userModelGlobal.id, currentOrder: widget.order);
    }
  }



  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    trackOrderController.subscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder(
        init: trackOrderController,
        builder: (_)=>trackOrderController.isLoading ? Center(child: CircularProgressIndicator()): Container(
            child: (trackOrderController.orderFounder == false)
                ? Container()
                : GoogleMap(
              polylines: trackOrderController.polyline.map((e) => e).toSet(),
              markers: Set.from(trackOrderController.markers),
              mapType: MapType.normal,
              myLocationButtonEnabled: false,
              initialCameraPosition: CameraPosition(
                target: (widget.isDriver == true) ? trackOrderController.driver : trackOrderController.client,
                zoom: 14.4746,
              ),
              onMapCreated: (GoogleMapController controller) {
                if (trackOrderController.controller.isCompleted)
                  trackOrderController.controller.complete(controller);
              },
            )),
      ),
    );
  }
}