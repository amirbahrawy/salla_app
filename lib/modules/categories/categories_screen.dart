import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/cubit/cubit.dart';
import '../../shared/cubit/states.dart';
import 'categories_builder.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit=ShopCubit.get(context);
          return ConditionalBuilder(
              condition:cubit.categoriesModel!=null,
              builder: (context) => categoriesBuilder(cubit.categoriesModel),
              fallback: (context) => const Center(child: CircularProgressIndicator(),));
        });
  }
}
