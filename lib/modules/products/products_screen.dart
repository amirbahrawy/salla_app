import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:ecommerce_app/modules/products/products_builder.dart';
import 'package:ecommerce_app/shared/cubit/cubit.dart';
import 'package:ecommerce_app/shared/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit=ShopCubit.get(context);
          return ConditionalBuilder(
              condition:cubit.homeModel!=null,
              builder: (context) => productsBuilder(cubit.homeModel),
              fallback: (context) => const Center(child: CircularProgressIndicator(),));
        });
  }
}
