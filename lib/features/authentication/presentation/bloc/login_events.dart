
abstract class LoginEvent {}

class LoginUserEvent extends LoginEvent {
  String userName , password ;
  LoginUserEvent({required this.userName , required this.password});
}

class SetLoginCredentialEvent extends LoginEvent {
  String userName , password ;
  SetLoginCredentialEvent({required this.userName , required this.password});
}

class LoginWithFingerPrint extends LoginEvent {}
