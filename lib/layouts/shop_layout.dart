import 'package:ecommerce_app/shared/cubit/cubit.dart';
import 'package:ecommerce_app/shared/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../modules/search/search_screen.dart';
import '../shared/components/components.dart';

class ShopLayout extends StatefulWidget {
  const ShopLayout({Key? key}) : super(key: key);
  @override
  State<ShopLayout> createState() => _ShopLayoutState();

}

class _ShopLayoutState extends State<ShopLayout> {
  @override
  void initState() {
    super.initState();
    var c = ShopCubit.get(context);
    c.getUserData();
    c.getFavoritesData();
  }
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
        builder: (context, state) {
          var cubit = ShopCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: const Text('Salla'),
              actions: [
                IconButton(
                    onPressed: () {
                      navigateTo(
                        context,
                        const SearchScreen(),
                      );
                    },
                    icon: const Icon(Icons.search))
              ],
            ),
            body: cubit.bottomScreens[cubit.currentIndex],
            bottomNavigationBar: BottomNavigationBar(
                onTap: (int index) {
                  cubit.changeBottom(index);
                },
                currentIndex: cubit.currentIndex,
                items: const [
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.home,
                    ),
                    label: 'Home',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.apps,
                    ),
                    label: 'Categories',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.favorite,
                    ),
                    label: 'Favorites',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.settings,
                    ),
                    label: 'Settings',
                  ),
                ]),
          );
        },
        listener: (context, state) {});
  }


}
