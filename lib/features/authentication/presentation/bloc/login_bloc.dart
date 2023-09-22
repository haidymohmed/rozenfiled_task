import 'package:rozenfiled_task/features/authentication/domain/use_cases/login_usecase.dart';
import 'package:rozenfiled_task/features/authentication/domain/use_cases/login_with_finger_print.dart';
import 'package:rozenfiled_task/features/authentication/domain/use_cases/set_credential.dart';
import 'package:rozenfiled_task/features/authentication/presentation/bloc/login_events.dart';
import 'package:rozenfiled_task/features/authentication/presentation/bloc/login_status.dart';
import 'package:bloc/bloc.dart';

class LoginBloc extends Bloc<LoginEvent , LoginStatus>{

  LoginUseCase loginUseCase ;
  SetLoginCredentialUseCase setLoginCredentialUseCase ;
  LoginWithFingerPrintUseCase loginWithFingerPrintUseCase ;
  LoginBloc({required this.loginUseCase , required this.loginWithFingerPrintUseCase , required this.setLoginCredentialUseCase }) : super(InitLoginStatus()){
    on<LoginUserEvent>((event, emit) async {
      emit(LoadingLoginStatus());
      var response = await loginUseCase(userName: event.userName , password: event.password);
      response.fold((failure){
        emit(LoginFailedStatus(failure: failure));
      }, (isCredentialSaved) {
        if(isCredentialSaved == 0){
          emit(LoginSuccessAskForCredentialStatus(message: "Logged In Successfully"));
        }else{
          emit(LoginSuccessStatus(message: "Logged In Successfully"));
        }
      });
    });
    on<LoginWithFingerPrint>((event, emit) async {
      emit(LoadingLoginStatus());
      var response = await loginWithFingerPrintUseCase();
      response.fold((failure){
        emit(LoginFailedStatus(failure: failure));
      }, (isCredentialSaved) {
        emit(LoginSuccessStatus(message: "Logged In Successfully"));
      });
    });
    on<SetLoginCredentialEvent>((event, emit) async {
      emit(LoadingLoginStatus());
      var response = await setLoginCredentialUseCase(userName: event.userName , password: event.password);
      response.fold((failure){
        emit(LoginFailedStatus(failure: failure));
      }, (message) {
        emit(LoginSuccessStatus(message: "Logged In Successfully"));
      });
    });
  }

}