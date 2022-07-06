class CategoriesModel{
  late bool status;
  late CategoriesData categoriesData;
  CategoriesModel.fromJson(Map<String, dynamic> json){
    status=json['status'];
    categoriesData=CategoriesData.fromJson(json['data']);
}
}
class CategoriesData{
  int? currentPage;
  List<DataModel> data=[];
  CategoriesData.fromJson(Map<String, dynamic> json){
    currentPage=json['current_page'];
    json['data'].forEach((element) {
       data.add(DataModel.fromJson(element));
    });
  }
}
class DataModel{
  late int id;
  late String name;
  late String image;
  DataModel.fromJson(Map<String, dynamic> json){
    id=json['id'];
    name=json['name'];
    image=json['image'];
  }
}