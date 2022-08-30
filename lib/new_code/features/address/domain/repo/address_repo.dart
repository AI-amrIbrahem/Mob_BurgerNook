import 'package:burgernook/new_code/features/Auth/data/models/user_model.dart';
import 'package:burgernook/new_code/features/basket/data/models/time_work_model.dart';
import 'package:dartz/dartz.dart';

import '../../../../util/errors/failures.dart';
import '../../data/models/address_model.dart';


abstract class AddressRepo{
  Future<Either<Failure,bool>> setAddress({required AddressModel addressModel});
  Future<Either<Failure,List<AddressModel>>> getAddress({required String userId});

}
