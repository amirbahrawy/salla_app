import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecommerce_app/shared/cubit/cubit.dart';
import 'package:ecommerce_app/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import '../../models/categories_model.dart';
import '../../models/home_model.dart';

Widget productsBuilder(
        HomeModel? homeModel, CategoriesModel? categoriesModel, context) =>
    SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CarouselSlider(
              items: homeModel?.data.banners
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
                  viewportFraction: 0.9,
                  reverse: false,
                  autoPlay: true,
                  autoPlayInterval: const Duration(seconds: 3),
                  autoPlayAnimationDuration: const Duration(seconds: 1),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  scrollDirection: Axis.horizontal)),
          const SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Categories',
                  style: TextStyle(fontSize: 22.0),
                ),
                const SizedBox(
                  height: 15,
                ),
                SizedBox(
                  height: 100.0,
                  child: ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) => buildCategoryItem(
                          categoriesModel!.categoriesData.data[index]),
                      separatorBuilder: (context, index) => const SizedBox(
                            width: 8.0,
                          ),
                      itemCount: categoriesModel!.categoriesData.data.length),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text('New Products', style: TextStyle(fontSize: 22.0)),
              ],
            ),
          ),
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
              children: List.generate(
                  homeModel!.data.products.length,
                  (index) => buildProductItem(
                      homeModel.data.products[index], context)),
            ),
          )
        ],
      ),
    );

Widget buildProductItem(ProductModel productModel, context) => Stack(
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
                    icon: ShopCubit.get(context).favoritesData[productModel.id]!
                        ? const Icon(Icons.favorite_border)
                        : const Icon(
                            Icons.favorite,
                            color: defaultColor,
                          ),
                    onPressed: () {
                      ShopCubit.get(context).changeFavorites(productModel.id);
                    },
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

Widget buildCategoryItem(DataModel model) => Stack(
      alignment: AlignmentDirectional.bottomStart,
      children: [
        Image(
          image: NetworkImage(model.image),
          height: 100.0,
          width: 100.0,
        ),
        Container(
          width: 100.0,
          color: Colors.black.withOpacity(0.8),
          child: Text(
            model.name,
            style: const TextStyle(color: Colors.white),
            textAlign: TextAlign.center,
            maxLines: 1,
          ),
        )
      ],
    );
