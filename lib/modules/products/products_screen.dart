import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:ecommerce_app/modules/products/products_builder.dart';
import 'package:ecommerce_app/shared/components/components.dart';
import 'package:ecommerce_app/shared/cubit/cubit.dart';
import 'package:ecommerce_app/shared/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
        listener: (context, state) {
          if(state is ShopSuccessChangeFavoritesState){
                if(!state.changeFavoritesModel!.status!){
                 showToast('${state.changeFavoritesModel?.message}', Colors.red);
                }
          }
        },
        builder: (context, state) {
          var cubit=ShopCubit.get(context);
          return ConditionalBuilder(
              condition:cubit.homeModel!=null&&cubit.categoriesModel!=null,
              builder: (context) => productsBuilder(cubit.homeModel,cubit.categoriesModel,context),
              fallback: (context) => const Center(child: CircularProgressIndicator(),));
        });
  }
}
