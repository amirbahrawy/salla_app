import 'package:ecommerce_app/models/login_model.dart';

import '../../models/change_favorites_model.dart';

abstract class ShopStates{}

class ShopInitialState extends ShopStates{}
class ShopChangeBottomNavState extends ShopStates{}
class ShopLoadingHomeDataState extends ShopStates{}
class ShopSuccessHomeDataState extends ShopStates{}
class ShopErrorHomeDataState extends ShopStates{}
class ShopLoadingCategoriesDataState extends ShopStates{}
class ShopSuccessCategoriesDataState extends ShopStates{}
class ShopErrorCategoriesDataState extends ShopStates{}
class ShopLoadingGetFavoritesState extends ShopStates{}
class ShopSuccessGetFavoritesState extends ShopStates{}
class ShopErrorGetFavoritesState extends ShopStates{}
class ShopSuccessChangeFavoritesState extends ShopStates{
  final ChangeFavoritesModel? changeFavoritesModel;

  ShopSuccessChangeFavoritesState(this.changeFavoritesModel);
}
class ShopErrorChangeFavoritesState extends ShopStates{}
class ShopChangeFavoritesState extends ShopStates{}
class ShopSuccessUserDataState extends ShopStates{
  final LoginModel? loginModel;

  ShopSuccessUserDataState(this.loginModel);
}
class ShopErrorUserDataState extends ShopStates{}
class ShopLoadingUserDataState extends ShopStates{}
class ShopSuccessUpdateDataState extends ShopStates{
  final LoginModel? loginModel;

  ShopSuccessUpdateDataState(this.loginModel);
}
class ShopErroUpdateDataState extends ShopStates{}
class ShopLoadingUpdateDataState extends ShopStates{}