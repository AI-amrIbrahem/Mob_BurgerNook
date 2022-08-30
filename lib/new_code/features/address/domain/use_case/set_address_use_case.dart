import 'package:burgernook/new_code/features/address/data/data_source/address_data_source.dart';
import 'package:burgernook/new_code/features/address/data/models/address_model.dart';
import 'package:burgernook/new_code/features/address/domain/repo/address_repo.dart';
import 'package:burgernook/new_code/util/errors/failures.dart';
import 'package:dartz/dartz.dart';


class SetAddressUseCase {
  final AddressRepo addressDataSource;

  SetAddressUseCase({required this.addressDataSource});

  Future<Either<Failure, bool>> call({required AddressModel addressModel}) async {
    return await addressDataSource.setAddress(addressModel: addressModel);
  }
}
