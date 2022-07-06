import 'package:ecommerce_app/models/categories_model.dart';
import 'package:flutter/material.dart';

Widget categoriesBuilder(CategoriesModel? model) {
  return ListView.separated(
      physics: const BouncingScrollPhysics(),
      scrollDirection: Axis.vertical,
      itemBuilder: (context, index) =>
          buildCategoryItem(model!.categoriesData.data[index]),
      separatorBuilder: (context, index) =>
          Container(
            margin:const EdgeInsets.symmetric(horizontal: 15.0),
            color: Colors.grey[300],
            height: 1.0,
          ),
      itemCount: model!.categoriesData.data.length);
}

Widget buildCategoryItem(DataModel data) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Row(
      children: [
        Image(
          image: NetworkImage(data.image),
          width: 100,
          height: 100.0,
        ),
        const SizedBox(
          width: 15.0,
        ),
        Text(
          data.name,
          style: const TextStyle(fontSize: 20.0),
        ),
        const Spacer(),
        const Icon(Icons.arrow_forward_ios)
      ],
    ),
  );
}
