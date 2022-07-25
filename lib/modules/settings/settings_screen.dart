import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:ecommerce_app/shared/components/components.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/cubit/cubit.dart';
import '../../shared/cubit/states.dart';

class SettingsScreen extends StatelessWidget {
  SettingsScreen({Key? key}) : super(key: key);
  final formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
        listener: (context, state) {},
        builder: (context, state) {
          ShopCubit cubit = ShopCubit.get(context);
          nameController.text = '${cubit.userModel?.data?.name}';
          emailController.text = '${cubit.userModel?.data?.email}';
          phoneController.text = '${cubit.userModel?.data?.phone}';
          return ConditionalBuilder(
              condition: cubit.userModel != null &&
                  state is! ShopLoadingGetFavoritesState &&
                  state is! ShopLoadingUserDataState,
              builder: (context) => SizedBox(
                width: double.infinity,
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      if (state is ShopLoadingUpdateDataState)
                        const LinearProgressIndicator(),
                      TextFieldContainer(
                        child: defaultFormField(
                            controller: nameController,
                            type: TextInputType.name,
                            validate: (String? value) {
                              if (value == null || value.isEmpty) {
                                return 'name must not be empty';
                              }
                              return null;
                            },
                            label: 'Name',
                            prefix: Icons.person),
                      ),
                      TextFieldContainer(
                        child: defaultFormField(
                            controller: emailController,
                            type: TextInputType.emailAddress,
                            validate: (String? value) {
                              if (value == null || value.isEmpty) {
                                return 'email must not be empty';
                              }
                              return null;
                            },
                            label: 'Email Address',
                            prefix: Icons.email),
                      ),
                      TextFieldContainer(
                        child: defaultFormField(
                            controller: phoneController,
                            type: TextInputType.number,
                            validate: (String? value) {
                              if (value == null || value.isEmpty) {
                                return 'phone must not be empty';
                              }
                              return null;
                            },
                            label: 'Phone Number',
                            prefix: Icons.phone),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      RoundedButton(
                          function: () {
                            if (formKey.currentState!.validate()) {
                              cubit.updateUserData(
                                  name: nameController.text,
                                  email: emailController.text,
                                  phone: phoneController.text);
                            }
                          },
                          text: 'update'),
                      const SizedBox(
                        height: 20.0,
                      ),
                      RoundedButton(
                          function: () {
                            signOut(context);
                          },
                          text: 'logout')
                    ],
                  ),
                ),
              ),
              fallback: (ctx) => const Center(
                    child: CircularProgressIndicator(),
                  ));
        });
  }
}
