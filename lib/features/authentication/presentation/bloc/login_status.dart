

import 'package:rozenfiled_task/core/error/failure.dart';

abstract class LoginStatus {}

class LoadingLoginStatus extends LoginStatus {}

class InitLoginStatus extends LoginStatus {}

class LoginSuccessStatus extends LoginStatus {
  String message ;
  LoginSuccessStatus({required this.message});
}
class LoginSuccessAskForCredentialStatus extends LoginStatus {
  String message ;
  LoginSuccessAskForCredentialStatus({required this.message});
}

class CredentialSetSuccessStatus extends LoginStatus {
  String message ;
  CredentialSetSuccessStatus({required this.message});
}

class LoginFailedStatus extends LoginStatus {
  Failure failure ;
  LoginFailedStatus({required this.failure});
}