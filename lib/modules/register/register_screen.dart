import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../layouts/shop_layout.dart';
import '../../shared/components/components.dart';
import '../../shared/components/constants.dart';
import '../../shared/network/local/cache_helper.dart';
import 'cubit/register_cubit.dart';
import 'cubit/register_states.dart';

class RegisterScreen extends StatelessWidget {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterStates>(
        listener: (context, state) {
          if (state is RegisterSuccessState) {
            if (state.loginModel?.status == true) {
              debugPrint(state.loginModel?.message);
              debugPrint(state.loginModel?.data?.token);
              showToast('${state.loginModel?.message}', Colors.green);
              CacheHelper.putData(
                      key: 'token', value: state.loginModel?.data?.token)
                  .then((value) {
                token = state.loginModel?.data?.token;
                navigateAndFinish(context, const ShopLayout());
              });
            } else {
              debugPrint(state.loginModel?.message);
              showToast('${state.loginModel?.message}', Colors.red);
            }
          }
        },
        builder: (context, state) {
          Size size=MediaQuery.of(context).size;
          var cubit = RegisterCubit.get(context);
          return Scaffold(
            body: Background(
              child: Center(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Form(
                      key: formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Sign Up',
                            style: Theme.of(context)
                                .textTheme
                                .headline4
                                ?.copyWith(color: Colors.black),
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          SvgPicture.asset('assets/icons/signup.svg',height:size.height*0.32 ,),
                          TextFieldContainer(
                            child: defaultFormField(
                                controller: nameController,
                                type: TextInputType.text,
                                validate: (String? value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter your name';
                                  }
                                  return null;
                                },
                                label: 'enter your user name',
                                prefix: Icons.person),
                          ),
                          TextFieldContainer(
                            child: defaultFormField(
                                controller: emailController,
                                type: TextInputType.emailAddress,
                                validate: (String? value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter email address';
                                  }
                                  return null;
                                },
                                label: 'enter your email address',
                                prefix: Icons.email_outlined),
                          ),
                          TextFieldContainer(
                            child: defaultFormField(
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
                                prefix: Icons.lock_outline),
                          ),
                          TextFieldContainer(
                            child: defaultFormField(
                                controller: phoneController,
                                type: TextInputType.number,
                                validate: (String? value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter your phone';
                                  }
                                  return null;
                                },
                                label: 'enter your phone number',
                                prefix: Icons.phone),
                          ),
                          ConditionalBuilder(
                              condition: state is! RegisterLoadingState,
                              builder: (context) => RoundedButton(
                                    function: () {
                                      if (formKey.currentState!.validate()) {
                                        cubit.userRegister(
                                            email: emailController.text,
                                            password: passwordController.text,
                                            name: nameController.text,
                                            phone: phoneController.text);
                                      }
                                    },
                                    text: 'register',
                                  ),
                              fallback: (context) => const Center(
                                  child: CircularProgressIndicator())),
                        ],
                      ),
                    ),
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
