import 'package:burgernook/new_code/features/address/data/data_source/address_data_source.dart';
import 'package:burgernook/new_code/features/address/data/models/address_model.dart';
import 'package:burgernook/new_code/util/errors/failures.dart';
import 'package:dartz/dartz.dart';

import '../repo/address_repo.dart';


class GetAddressUseCase {
  final AddressRepo addressDataSource;

  GetAddressUseCase({required this.addressDataSource});

  Future<Either<Failure, List<AddressModel>>> call({required String userId}) async {
    return await addressDataSource.getAddress(userId: userId);
  }
}
