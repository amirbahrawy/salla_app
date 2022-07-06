import 'package:ecommerce_app/models/categories_model.dart';
import 'package:ecommerce_app/modules/categories/categories_screen.dart';
import 'package:ecommerce_app/modules/favorites/favorites_screen.dart';
import 'package:ecommerce_app/modules/products/products_screen.dart';
import 'package:ecommerce_app/modules/settings/settings_screen.dart';
import 'package:ecommerce_app/shared/components/constants.dart';
import 'package:ecommerce_app/shared/cubit/states.dart';
import 'package:ecommerce_app/shared/network/remote/dio_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/change_favorites_model.dart';
import '../../models/home_model.dart';
import '../../shared/components/constants.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitialState());

  static ShopCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;
  Map<int, bool> favoritesData = {};
  HomeModel? homeModel;
  CategoriesModel? categoriesModel;
  ChangeFavoritesModel? changeFavoritesModel;
  List<Widget> bottomScreens = const [
    ProductsScreen(),
    CategoriesScreen(),
    FavoritesScreen(),
    SettingsScreen()
  ];

  void changeBottom(int index) {
    currentIndex = index;
    emit(ShopChangeBottomNavState());
  }

  void getHomeData() {
    emit(ShopLoadingHomeDataState());
    DioHelper.getData(url: home, token: token).then((value) {
      homeModel = HomeModel.fromJson(value.data);
      for (var element in homeModel!.data.products) {
        favoritesData.addAll({element.id: element.inFavorites});
      }
      debugPrint(favoritesData.toString());
      debugPrint(homeModel?.data.banners[0].image);
      emit(ShopSuccessHomeDataState());
    }).catchError((error) {
      debugPrint(error.toString());
    });
  }

  void getCategoriesData() {
    emit(ShopLoadingCategoriesDataState());
    DioHelper.getData(url: categories, token: token).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);
      debugPrint(categoriesModel?.categoriesData.data[0].name);
      emit(ShopSuccessCategoriesDataState());
    }).catchError((error) {
      debugPrint(error.toString());
    });
  }

  void changeFavorites(int id) {
    favoritesData[id]=!favoritesData[id]!;
    emit(ShopChangeFavoritesState());
    DioHelper.postData(url: favorites, data: {'product_id': id}, token: token)
        .then((value) {
          changeFavoritesModel=ChangeFavoritesModel.fromJson(value.data);
          debugPrint(changeFavoritesModel?.message);
          if(!changeFavoritesModel!.status!){
            favoritesData[id]=!favoritesData[id]!;
          }
      emit(ShopSuccessChangeFavoritesState(changeFavoritesModel));
    }).catchError((error) {
      emit(ShopErrorChangeFavoritesState());
    });
  }
}
