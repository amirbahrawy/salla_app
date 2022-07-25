import 'package:ecommerce_app/models/boarding_model.dart';
import 'package:flutter/material.dart';

Widget buildBoardingItem (BoardingModel item) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children:  [
      Expanded(child: Image(image: AssetImage(item.image),)),
      Text(item.title,style: const TextStyle(fontSize: 24.0),),
      const SizedBox(height: 15,),
      Text(item.body,style: const TextStyle(fontSize: 14.0,color: Colors.grey),),

    ],
  );
