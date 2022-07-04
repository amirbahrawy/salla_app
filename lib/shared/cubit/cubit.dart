import 'package:ecommerce_app/modules/categories/categories_screen.dart';
import 'package:ecommerce_app/modules/favorites/favorites_screen.dart';
import 'package:ecommerce_app/modules/products/products_screen.dart';
import 'package:ecommerce_app/modules/settings/settings_screen.dart';
import 'package:ecommerce_app/shared/components/constants.dart';
import 'package:ecommerce_app/shared/cubit/states.dart';
import 'package:ecommerce_app/shared/network/remote/dio_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/home_model.dart';

class ShopCubit extends Cubit<ShopStates>{
  ShopCubit() : super(ShopInitialState());
  static ShopCubit get(context)=>BlocProvider.of(context);
  int currentIndex=0;
  List<Widget> bottomScreens=
  const [
    ProductsScreen(),
    CategoriesScreen(),
    FavoritesScreen(),
    SettingsScreen()
  ];
  HomeModel? homeModel;
  void changeBottom(int index){
    currentIndex=index;
    emit(ShopChangeBottomNavState());
  }
  void getHomeData(){
    emit(ShopLoadingHomeDataState());
    DioHelper.getData(url: home,token: token).then((value){
      homeModel=HomeModel.fromJson(value.data);
      debugPrint(homeModel?.data.banners[0].image);
      emit(ShopSuccessHomeDataState());
    }).catchError((error){
      debugPrint(error.toString());
    });
  }

}