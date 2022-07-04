import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecommerce_app/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import '../../models/home_model.dart';

Widget productsBuilder(HomeModel? model) => SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          CarouselSlider(
              items: model?.data.banners
                  .map((e) => Image(
                        image: NetworkImage(e.image),
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ))
                  .toList(),
              options: CarouselOptions(
                  height: 200.0,
                  initialPage: 0,
                  enableInfiniteScroll: true,
                  viewportFraction: 1.0,
                  reverse: false,
                  autoPlay: true,
                  autoPlayInterval: const Duration(seconds: 3),
                  autoPlayAnimationDuration: const Duration(seconds: 1),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  scrollDirection: Axis.horizontal)),
          const SizedBox(
            height: 15,
          ),
          Container(
            color: Colors.grey[300],
            child: GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              childAspectRatio: 1 / 1.4,
              crossAxisSpacing: 2.0,
              mainAxisSpacing: 2.0,
              physics: const NeverScrollableScrollPhysics(),
              children: List.generate(model!.data.products.length,
                  (index) => buildProductItem(model.data.products[index])),
            ),
          )
        ],
      ),
    );

Widget buildProductItem(ProductModel productModel) => Stack(
      children: [
        Container(
          padding: const EdgeInsets.only(left: 10.0),
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image(
                height: 170.0,
                image: NetworkImage(productModel.image),
                width: double.infinity,
              ),
              Text(
                productModel.name,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              Row(
                children: [
                  Text(
                    '${productModel.price.round()}',
                    style: const TextStyle(color: defaultColor),
                  ),
                  const SizedBox(
                    width: 10.0,
                  ),
                  if (productModel.discount != 0)
                    Text(
                      '${productModel.oldPrice.round()}',
                      style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 12.0,
                          decoration: TextDecoration.lineThrough),
                    ),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.favorite_border),
                    onPressed: () {},
                  )
                ],
              )
            ],
          ),
        ),
        if (productModel.discount != 0)
          Container(
            color: Colors.red,
            padding: const EdgeInsets.symmetric(
              horizontal: 5.0,
            ),
            child: const Text(
              'DISCOUNT',
              style: TextStyle(
                fontSize: 10.0,
                color: Colors.white,
              ),
            ),
          )
      ],
    );
