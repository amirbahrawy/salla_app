class FavoritesModel {
  late bool status;
  late Data data;

  FavoritesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = Data.fromJson(json['data']);
  }


}
class Data {
  List<FavoriteData>? data=[];
  int? total;


  Data.fromJson(Map<String, dynamic> json) {
      json['data'].forEach((element) {
        data!.add(FavoriteData.fromJson(element));
      });
      total = json['total'];
  }
  }

class FavoriteData {
  int? id;
  Product? product;


  FavoriteData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    product =Product.fromJson(json['product']);
  }
}
class Product {
  int? id;
  int? price;
  int? oldPrice;
  int? discount;
  String? image;
  String? name;
  String? description;

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
  }


}
