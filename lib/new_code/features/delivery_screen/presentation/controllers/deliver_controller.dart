// import 'package:burgernook/new_code/features/orders/domain/use_case/get_assigned_orders.dart';
// import 'package:get/get.dart';
// import 'package:internet_connection_checker/internet_connection_checker.dart';
//
// import '../../../../util/errors/failures.dart';
// import '../../../../util/network/network_info.dart';
// import '../../../../util/widgets/snackbar_widget.dart';
// import '../../../orders/data/data_source/order_data_source.dart';
// import '../../../orders/data/repo/order_repo_imp.dart';
//
// class DeliveryController extends GetxController{
//   var userOrdersList = [].obs;
//   var isLoading = true.obs;
//
//   getAssignedOrders() {
//     GetAssignedOrderUseCase(
//         repoImp: OrderRepoImp(
//             orderDataSource: OrderDataSource(),
//             networkInfo: NetworkInfoImp(
//                 connectionChecker: InternetConnectionChecker())))
//         .call()
//         .then((value) {
//       value.fold((l) {
//         if (l is OffLineFailure) {
//           failSnackBar('لا يوجد اتصال بالانترنت', 'برجاء الاتصال اولا');
//         } else if (l is WrongDataFailure) {
//           failSnackBar('البيانات خاظئة', 'من فضلك ادخل بيانات صحيحة');
//         } else if (l is ServerFailure) {
//           failSnackBar(
//               'هناك مشكلة في السيرفر ', 'برجاء التواصل مع خدمة العملاء');
//         }
//       }, (orders) {
//         userOrdersList.value = orders;
//         isLoading.value = false;
//       });
//     });
//   }
//
// }