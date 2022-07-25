import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:ecommerce_app/modules/login/cubit/login_cubit.dart';
import 'package:ecommerce_app/modules/login/cubit/login_states.dart';
import 'package:ecommerce_app/modules/register/register_screen.dart';
import 'package:ecommerce_app/shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import '../../layouts/shop_layout.dart';
import '../../shared/components/constants.dart';
import '../../shared/network/local/cache_helper.dart';

class LoginScreen extends StatelessWidget {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) {
          if (state is LoginSuccessState) {
            if (state.loginModel?.status == true) {
              debugPrint(state.loginModel?.message);
              debugPrint(state.loginModel?.data?.token);
              showToast('${state.loginModel?.message}', Colors.green);
              CacheHelper.putData(
                      key: 'token', value: state.loginModel?.data?.token)
                  .then((value) {
                token=state.loginModel?.data?.token;
                navigateAndFinish(context, const ShopLayout());
              });
            } else {
              debugPrint(state.loginModel?.message);
              showToast('${state.loginModel?.message}', Colors.red);
            }
          }
        },
        builder: (context, state) {
          var cubit = LoginCubit.get(context);
          Size size=MediaQuery.of(context).size;
          return Scaffold(
            body: Background(
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'LOGIN',
                        style: Theme.of(context)
                            .textTheme
                            .headline6
                            ?.copyWith(color: Colors.black),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SvgPicture.asset('assets/icons/login.svg',height: size.height*0.35,),
                      TextFieldContainer(child: defaultFormField(
                          controller: emailController,
                          type: TextInputType.emailAddress,
                          validate: (String? value) {
                            if (value!.isEmpty) {
                              return 'Please enter email address';
                            }
                            return null;
                          },
                          label: 'enter your email address',
                          prefix: Icons.email_outlined),),
                      TextFieldContainer(child: defaultFormField(
                          controller: passwordController,
                          type: TextInputType.visiblePassword,
                          validate: (String? value) {
                            if (value!.isEmpty) {
                              return 'Please enter your password';
                            }
                            return null;
                          },
                          label: 'enter your password',
                          suffixPressed: () {
                            cubit.changePasswordVisibility();
                          },
                          suffix: cubit.suffix,
                          isPassword: cubit.isPassword,
                          prefix: Icons.lock_outline),),
                      const SizedBox(height:10),
                      ConditionalBuilder(
                          condition: state is! LoginLoadingState,
                          builder: (context) => RoundedButton(
                            function: () {
                              if (formKey.currentState!.validate()) {
                                cubit.userLogin(
                                  email: emailController.text,
                                  password: passwordController.text,
                                );
                              }
                            },
                            text: 'login',
                          ),
                          fallback: (context) => const Center(
                              child: CircularProgressIndicator())),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('don\'t have an account?'),
                          defaultTextButton(
                              function: () {
                                navigateTo(context, RegisterScreen());
                              },
                              text: 'sign up')
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
