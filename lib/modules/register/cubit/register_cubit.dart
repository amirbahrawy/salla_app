import 'package:ecommerce_app/shared/components/constants.dart';
import 'package:ecommerce_app/shared/network/remote/dio_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../models/login_model.dart';
import 'register_states.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(RegisterInitialState());

  static RegisterCubit get(context) => BlocProvider.of(context);
  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;
  LoginModel? loginModel;

  void userRegister(
      {required String email,
      required String password,
      required String phone,
      required String name}) {
    emit(RegisterLoadingState());
    DioHelper.postData(url: register, data: {
      'name': name,
      'email': email,
      'password': password,
      'phone': phone
    }).then((value) {
      loginModel = LoginModel.fromJson(value.data);
      debugPrint(loginModel?.message);
      emit(RegisterSuccessState(loginModel));
    }).catchError((error) {
      debugPrint(error.toString());
      emit(RegisterErrorState(error.toString()));
    });
  }

  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(RegisterChangeVisibilityState());
  }
}
