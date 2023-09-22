import 'package:rozenfiled_task/features/authentication/presentation/widgets/login_error_dialog.dart';
import 'package:rozenfiled_task/features/authentication/presentation/bloc/login_events.dart';
import 'package:rozenfiled_task/features/authentication/presentation/bloc/login_status.dart';
import 'package:rozenfiled_task/features/authentication/presentation/bloc/login_bloc.dart';
import 'package:rozenfiled_task/features/home/presentation/home.dart';
import 'package:rozenfiled_task/core/widgets/custom_tect_filed.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:rozenfiled_task/core/resources/color_manager.dart';
import 'package:rozenfiled_task/core/resources/image_manager.dart';
import 'package:rozenfiled_task/core/widgets/custom_toast.dart';
import 'package:rozenfiled_task/core/functions/validator.dart';
import 'package:rozenfiled_task/core/widgets/custom_text.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {

  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  var inAsyncCall = ValueNotifier<bool>(false);

  var userName = ValueNotifier<String?>("");

  var password = ValueNotifier<String?>("");

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BlocListener<LoginBloc , LoginStatus>(
          listener: (context , state){
            if(state is LoadingLoginStatus){
              inAsyncCall.value = true ;
            }else if (state is LoginFailedStatus){
              inAsyncCall.value = false;
              showDialog<String>(
                context: context,
                builder: (BuildContext context) => LoginErrorDialog(
                  title: state.failure.code == -1 ? "Default Server" : "Error",
                  body: state.failure.message.notNull(),
                  ok: (){
                    Navigator.pop(context);
                  },
                )
              );
            }else if (state is LoginSuccessStatus){
              inAsyncCall.value = false;
              showToastError(msg: state.message, state: ToastedStates.SUCCESS);
              Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
              const Home()), (Route<dynamic> route) => false);
            }else if(state is LoginSuccessAskForCredentialStatus){
              showDialog<String>(
                context: context,
                builder: (BuildContext context) => LoginErrorDialog(
                  title: "Enable Fingerprint",
                  body: "Do you want to enable logging in to iCode Critical Results using your fingerprint?",
                  onYes: (){
                    BlocProvider.of<LoginBloc>(context).add(SetLoginCredentialEvent(userName: userName.value.notNull(), password: password.value.notNull()));
                  },
                  onNo: (){
                    showToastError(msg: state.message, state: ToastedStates.SUCCESS);
                    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                    const Home()), (Route<dynamic> route) => false);
                  },
                )
              );
            }
          },
          child: ValueListenableBuilder(
            valueListenable: inAsyncCall,
            builder: (context , value , child){
              return ModalProgressHUD(
                inAsyncCall: inAsyncCall.value,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 40),
                      Center(
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width / 2,
                          child: Image.asset(
                              ImageManager.logo
                          ),
                        ),
                      ),
                      const SizedBox(height: 50),
                      Form(
                        key: formKey,
                        child: Column(
                          children: [
                            CustomTextFormFiled(
                              title: "UserName",
                              iconData: Icons.person,
                              validator: (String? value) => value.isUserNameValid(),
                              onSaved: (String? value) => userName.value = value.notNull(),
                            ),
                            CustomTextFormFiled(
                              title: "Password",
                              iconData: Icons.lock,
                              validator: (String? value) => value.isPassword(),
                              onSaved: (String? value) => password.value = value.notNull(),
                              password: true,
                            ),
                            const SizedBox(height: 50),
                            TextButton(
                              onPressed: (){
                                if(formKey.currentState?.validate() == true){
                                  formKey.currentState?.save();
                                  BlocProvider.of<LoginBloc>(context).add(LoginUserEvent(userName: userName.value.notNull(), password: password.value.notNull()));
                                }
                              },
                              style: TextButton.styleFrom(
                                  backgroundColor: ColorManager.primary
                              ),
                              child: CustomText(
                                title: "Login",
                                color: ColorManager.white,
                              ),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(height: 50),
                      Center(
                        child: InkWell(
                          onTap: () {
                            BlocProvider.of<LoginBloc>(context).add(LoginWithFingerPrint());
                          },
                          child: const Icon(
                            Icons.fingerprint,
                            color: ColorManager.primary,
                            size: 60,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      )
    );
  }
}
