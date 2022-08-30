import 'package:burgernook/new_code/features/address/data/models/address_model.dart';
import 'package:dartz/dartz.dart';
import '../../../../util/errors/exceptions.dart';
import '../../../../util/errors/failures.dart';
import '../../../../util/network/network_info.dart';
import '../../domain/repo/address_repo.dart';
import '../data_source/address_data_source.dart';

class AddressRepoImp extends AddressRepo {
  AddressDataSource addressDataSource;
  NetworkInfo networkInfo;

  AddressRepoImp({required this.addressDataSource, required this.networkInfo});



  @override
  Future<Either<Failure, List<AddressModel>>> getAddress({required String userId}) async{
    if (await networkInfo.isConnected) {
      try {
        List<AddressModel> address =
            await addressDataSource.getAddress(userId);
        return right(address);
      } on ServerException {
        return left(ServerFailure());
      }
    } else {
      return Left(OffLineFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> setAddress({required AddressModel addressModel}) async{
    if (await networkInfo.isConnected) {
      try {
        bool isAddAddress =
            await addressDataSource.setAddress(addressModel);
        return right(isAddAddress);
      } on ServerException {
        return left(ServerFailure());
      }
    } else {
      return Left(OffLineFailure());
    }
  }
}