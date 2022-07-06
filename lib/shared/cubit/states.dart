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
