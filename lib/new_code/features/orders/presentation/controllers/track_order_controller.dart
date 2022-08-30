import 'dart:async';

import 'package:burgernook/new_code/features/address/data/models/address_model.dart';
import 'package:burgernook/new_code/features/orders/data/models/order_model.dart';
import 'package:burgernook/new_code/util/resources/ColorsUtils.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../../../../util/errors/failures.dart';
import '../../../../util/helper/location_helper.dart';
import '../../../../util/network/network_info.dart';
import '../../../../util/widgets/snackbar_widget.dart';
import '../../../address/data/data_source/address_data_source.dart';
import '../../../address/data/repo/address_repo_imp.dart';
import '../../../address/domain/use_case/get_address_use_case.dart';
import 'package:location/location.dart';

class TrackOrderController extends GetxController {
  AddressModel userAddress = AddressModel();
  Completer<GoogleMapController> controller = Completer();
  bool orderFounder = false;
  late Location location;

  final List<Polyline> polyline = [

  ];


  setDriverLocation(String orderID) async {
    Location location = new Location();

    // bool _serviceEnabled;
    // PermissionStatus _permissionGranted;
    //
    // _serviceEnabled = await location.serviceEnabled();
    // if (!_serviceEnabled) {
    //   _serviceEnabled = await location.requestService();
    //   if (!_serviceEnabled) {
    //     return;
    //   }
    // }
    //
    // _permissionGranted = await location.hasPermission();
    // if (_permissionGranted == PermissionStatus.denied) {
    //   _permissionGranted = await location.requestPermission();
    //   if (_permissionGranted != PermissionStatus.granted) {
    //     return;
    //   }
    // }


    LocationHelper.determinePosition().then((value) {

      print('vvvvvvvvvvvvvvvvvv $value');
      FirebaseDatabase.instance
          .ref()
          .child("orders")
          .child(orderID)
          .child("driver")
          .set({"lat": value.latitude, "lng": value.longitude}).then((value) {

      });
    });

    location.onLocationChanged.listen((event) {
      print('don work  location');
      FirebaseDatabase.instance
          .ref()
          .child("orders")
          .child(orderID)
          .child("driver")
          .set({"lat": event.latitude, "lng": event.longitude}).then((v) => {
        // Data saved successfully!
      }).onError((error, stackTrace){
        print('errrrrrrrrrrrrrrrrrrrr ${error.toString()}');
        return {};
      });

      // setState(() {});
    });
  }


  List<Marker> markers = [];
  addMarker(LatLng latLng, {required bool isDriver}) {
    markers.add(Marker(
        markerId: MarkerId((isDriver == true) ? "2" : "1"),
        position: latLng,
        infoWindow: InfoWindow(title: (isDriver == true) ? "Driver" : "Client"),
        icon: (isDriver == true)
            ? BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure)
            : BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed)));
    //  setState(() {});
  }

  getAddress({required String userId , required OrderModel currentOrder,bool isMap = true}) async{
    if(userId != '0'){
      await GetAddressUseCase(
          addressDataSource: AddressRepoImp(
              addressDataSource: AddressDataSource(),
              networkInfo: NetworkInfoImp(
                  connectionChecker: InternetConnectionChecker())))
          .call(userId: userId)
          .then((value) {
        // dismissLoadingDialog(context);
        value.fold((l) {
          print('l amr $l');
          if (l is OffLineFailure) {
            failSnackBar('لا يوجد اتصال بالانترنت', 'برجاء الاتصال اولا');
          } else if (l is WrongDataFailure) {
            failSnackBar('البيانات خاظئة', 'من فضلك ادخل بيانات صحيحة');
          } else if (l is ServerFailure) {
            failSnackBar(
                'هناك مشكلة في السيرفر ', 'برجاء التواصل مع خدمة العملاء');
          }
        }, (address) async {
          address.forEach((element) {
            // if (element.id == widget.order.addressId) {
            if (element.id == currentOrder.addressId) {

              userAddress = element;
              if(!isMap)
              FirebaseDatabase.instance
                  .ref()
                  .child("orders")
                  .child(currentOrder.id)
                  .child("client")
                  .set({"lat": userAddress.latitude, "lng": userAddress.longitude}).then((v) => {
                // Data saved successfully!
              }).onError((error, stackTrace){
                print('errrrrrrrrrrrrrrrrrrrr ${error.toString()}');
                return {};
              });
              if(isMap)
              enableFirebase(orderId: currentOrder.id);
              // addMarker(LatLng(double.parse(userAddress.latitude),
              //     double.parse(userAddress.longitude)));
              //setState(() {});
              return;
            }
          });
          return address;
        });
      });
    }
  }

  late StreamSubscription subscription;
  late LatLng client, driver;
  bool isLoading = true;

  enableFirebase({required String orderId, }) {
    subscription = FirebaseDatabase.instance
        .ref()
        .child("orders")
        .onValue
        .listen((event) {
      Map data = event.snapshot.value as Map;
      data.forEach((key, value) {
        print("MyKey:$key");
        String id = key;
        print("WidKey:${orderId}");
        if (id == orderId) {
          print("FOUNDED");
          orderFounder = true;


          client = LatLng(double.parse(value['client']['lat'].toString()),
              double.parse(value['client']['lng'].toString()));
           driver = LatLng(double.parse(value['driver']['lat'].toString()),
               double.parse(value['driver']['lng'].toString()));

          print(' client data $client');
          print(' driver data $driver');


          polyline.add( Polyline(
            polylineId: const PolylineId('0'),
            visible: true,
            width: 4,
            patterns: [PatternItem.dot, PatternItem.gap(10)],
            jointType: JointType.round,
            points: [
              client,
              driver,
            ],
            color: AppColors.accentColor,
          ) );



          markers.clear();
          addMarker(client, isDriver: false);
          addMarker(driver, isDriver: true);
          controller.future.then((value) {
            try {
              value.animateCamera(CameraUpdate.newLatLngBounds(
                  LatLngBounds(southwest: client, northeast: driver), 120));
            } catch (e) {
              value.animateCamera(CameraUpdate.newLatLngBounds(
                  LatLngBounds(southwest: driver, northeast: client), 120));
            }
          });
          isLoading = false;
          update();
        } else {
          print("Not found :$id");
        }
      });
    });
  }


}