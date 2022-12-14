import 'enumeration.dart';

class HttpMethod extends Enum {
  HttpMethod(value) : super(value);

  static final HttpMethod GET = HttpMethod('GET');
  static final HttpMethod POST = HttpMethod('POST');
  static final HttpMethod PUT = HttpMethod('PUT');
  static final HttpMethod DELETE = HttpMethod('DELETE');

}

class NetworkStatusCodes extends Enum {
  NetworkStatusCodes(value) : super(value);

  static final UnAuthorizedUser = NetworkStatusCodes(401);
  static final BadRequest = NetworkStatusCodes(400);
  static final ServerInternalError = NetworkStatusCodes(500);
  static final OK_200 = NetworkStatusCodes(200);
}

enum NotificationType {
  appointmentCancelled,
  appointmentReserved,
  appointmentReminder,
  appointmentChanged,
  appointmentReminderBefore
}

class ContractTypes extends Enum {
  ContractTypes(value) : super(value);

  static final individuals = ContractTypes(230);
  static final companies = ContractTypes(231);
}

class ContractModes extends Enum {
  ContractModes(value) : super(value);

  static final contractMode = ContractModes(240);
}

class ContractStatus extends Enum {
  ContractStatus(value) : super(value);
  static final open = ContractStatus(210);
  static final close = ContractStatus(211);
  static final inDebt = ContractStatus(311);
  static final cancelled = ContractStatus(212);
}

class VoucherOperationType extends Enum {
  VoucherOperationType(value) : super(value);

  static final addContract = VoucherOperationType(2300);
  static final extendContract = VoucherOperationType(2301);
  static final contractPayment = VoucherOperationType(2302);
  static final closeContract = VoucherOperationType(2303);
  static final viewContract = VoucherOperationType(2304);
  static final switchVehicle = VoucherOperationType(2305);
  static final addBooking = VoucherOperationType(2306);
  static final editBooking = VoucherOperationType(2307);
  static final executeBooking = VoucherOperationType(2308);
  static final cancelBooking = VoucherOperationType(2309);
  static final bookingPayment = VoucherOperationType(2310);
  static final refund = VoucherOperationType(2311);
  static final cancelContract = VoucherOperationType(2312);
}

class Sources extends Enum {
  Sources(id) : super(id);

  static final backOfficeSource = Sources(120);
  static final androidSource = Sources(121);
  static final iosSource = Sources(122);
}

class ECheckType extends Enum {
  ECheckType(type) : super(type);

  static final openContract = ECheckType(1);
  static final closeContract = ECheckType(2);
}

class VoucherTypeIds extends Enum {
  VoucherTypeIds(id) : super(id);
  static final addPayment = VoucherTypeIds(270);
  static final disbursement = VoucherTypeIds(271);
}

class OperationTypes extends Enum {
  OperationTypes(id) : super(id);

  static final openContract = OperationTypes(1800);
  static final closeContract = OperationTypes(1803);
}

class BranchesTypes extends Enum {
  BranchesTypes(typeId) : super(typeId);

  static final rentalBranch = BranchesTypes(8900);
}

class FailureCodes extends Enum {
  FailureCodes(value) : super(value);

  static final CODE_INVALID_PAYLOAD_PARAMETERS = FailureCodes(10100);
  static final CODE_WRONG_OTP_OR_EXPIRED = FailureCodes(10101);
  static final CODE_INVALID_PHONE_NUMBER = FailureCodes(10102);
  static final CODE_USER_NOT_FOUND = FailureCodes(10103);
  static final CODE_OTP_NOT_SENT = FailureCodes(10104);
  static final CODE_SIGN_IN_FAILED = FailureCodes(10105);
  static final CODE_ERROR_RETRIEVING_FACEBOOK_INFO = FailureCodes(10106);
  static final CODE_AUTH_SESSION_EXPIRED_OR_NOT_VALID = FailureCodes(10107);
}

class AuthTypesEnum {
  static final logIn = 'logIn';
  static final signUp = 'signUp';
}
