class ChangeFavoritesModel {
  String? message;
  bool? status;
  ChangeFavoritesModel.fromJson(Map<String,dynamic> json){
    status=json['status'];
    message=json['message'];
  }
}
