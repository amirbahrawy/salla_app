import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/favorites_model.dart';
import '../../shared/components/components.dart';
import '../../shared/cubit/cubit.dart';
import '../../shared/cubit/states.dart';
import '../../shared/styles/colors.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(listener: (context, state) {
      if (state is ShopSuccessChangeFavoritesState) {
        if (!state.changeFavoritesModel!.status!) {
          showToast('${state.changeFavoritesModel?.message}', Colors.red);
        }
      }
    }, builder: (context, state) {
      var cubit = ShopCubit.get(context);
      return ConditionalBuilder(
          condition: state is! ShopLoadingGetFavoritesState,
          builder: (context) => ListView.separated(
              scrollDirection: Axis.vertical,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) =>
                  favItem(cubit.favoritesModel!.data.data![index], context),
              separatorBuilder: (context, index) => Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10.0),
                    color: Colors.grey[300],
                    height: 1.0,
                  ),
              itemCount: cubit.favoritesModel!.data.data!.length),
          fallback: (ctx) => const Center(child: CircularProgressIndicator()));
    });
  }

  Widget favItem(FavoriteData data, context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: SizedBox(
        height: 120.0,
        child: Row(
          children: [
            SizedBox(
              height: 120.0,
              width: 120.0,
              child: Stack(
                children: [
                  Image(
                    height: 120.0,
                    fit: BoxFit.cover,
                    image: NetworkImage('${data.product?.image}'),
                    width: 120.0,
                  ),
                  if (data.product?.discount != 0)
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
              ),
            ),
            const SizedBox(
              width: 20.0,
            ),
            Expanded(
              child: Column(
                children: [
                  Text(
                    '${data.product?.name}',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      Text(
                        '${data.product?.price}',
                        style: const TextStyle(color: defaultColor),
                      ),
                      const SizedBox(
                        width: 10.0,
                      ),
                      if (data.product?.discount != 0)
                        Text(
                          '${data.product?.oldPrice}',
                          style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 12.0,
                              decoration: TextDecoration.lineThrough),
                        ),
                      const Spacer(),
                      IconButton(
                        icon: ShopCubit.get(context)
                                .favoritesData[data.product?.id]!
                            ? const Icon(
                                Icons.favorite,
                                color: defaultColor,
                              )
                            : const Icon(Icons.favorite_border),
                        onPressed: () {
                          ShopCubit.get(context)
                              .changeFavorites(data.product!.id!);
                        },
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
