import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/shared/components/components.dart';
import '../modules/search/search_screen.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class ShopLayout extends StatelessWidget {
  const ShopLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = ShopCubit.get(context);

        return Scaffold(
          appBar: AppBar(
            title: const Text(
              'Salla',
            ),
            actions: [
              IconButton(
                icon: const Icon(
                  Icons.search,
                ),
                onPressed: () {
                  navigateTo(context, SearchScreen(),);
                },
              ),
            ],
          ),
          body: cubit.bottomScreens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            onTap: (index) {
              cubit.changeBottom(index);
            },
            currentIndex: cubit.currentIndex,
            items: [
              const BottomNavigationBarItem(
                icon: const Icon(
                  Icons.home,
                ),
                label: 'Home',
              ),
              const BottomNavigationBarItem(
                icon: Icon(
                  Icons.apps,
                ),
                label: 'Categories',
              ),
              const BottomNavigationBarItem(
                icon: Icon(
                  Icons.favorite,
                ),
                label: 'Favorites',
              ),
              const BottomNavigationBarItem(
                icon: const Icon(
                  Icons.settings,
                ),
                label: 'Settings',
              ),
            ],
          ),
        );
      },
    );
  }
}
