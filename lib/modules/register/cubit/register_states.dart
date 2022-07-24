import 'package:ecommerce_app/models/login_model.dart';

abstract class RegisterStates{}

class RegisterInitialState extends RegisterStates{}
class RegisterLoadingState extends RegisterStates{}
class RegisterSuccessState extends RegisterStates{
  final LoginModel? loginModel;

  RegisterSuccessState(this.loginModel);
}
class RegisterErrorState extends RegisterStates{
  final String error;

  RegisterErrorState(this.error);
}
class RegisterChangeVisibilityState extends RegisterStates{}
