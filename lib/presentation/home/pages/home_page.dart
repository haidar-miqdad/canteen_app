// ignore_for_file: deprecated_member_use_from_same_package
import 'package:cached_network_image/cached_network_image.dart';
import 'package:canteen_app/core/core.dart';
import 'package:flutter/material.dart';

part '../widgets/product_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final searchController = TextEditingController();

  final indexValue = ValueNotifier(0);

  void onCategoryTap(int index) {
    searchController.clear();
    indexValue.value = index;

    String category = 'all';
    switch (index) {
      case 0:
        category = 'all';
        break;
      case 1:
        category = 'drink';
        break;
      case 2:
        category = 'food';
        break;
      case 3:
        category = 'snack';
        break;
    }
  }


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0, ),
      child: ListView(
        children: [
          AppTitle(text: 'Catalog'),
          SpaceHeight(18.0),
          CustomTextField(controller: searchController, hintText: 'Search..', prefixIcon: Assets.icons.search.svg(),),
          SpaceHeight(24.0),
          ValueListenableBuilder(
            valueListenable: indexValue,
            builder: (context, index, _) => Row(
              children: [
                MenuButton(
                  iconPath: Assets.icons.allCategories.svg(width: 32.0, height: 32.0),
                  label: 'All',
                  isActive: index == 0,
                  onPressed: () => onCategoryTap(0),
                ),
                const SpaceWidth(10.0),
                MenuButton(
                  iconPath: Assets.icons.drink.svg(),
                  label: 'Drink',
                  isActive: index == 1,
                  onPressed: () => onCategoryTap(1),
                ),
                const SpaceWidth(10.0),
                MenuButton(
                  iconPath: Assets.icons.food.svg(),
                  label: 'Food',
                  isActive: index == 2,
                  onPressed: () => onCategoryTap(2),
                ),
                const SpaceWidth(10.0),
                MenuButton(
                  iconPath: Assets.icons.snack.svg(),
                  label: 'Snack',
                  isActive: index == 3,
                  onPressed: () => onCategoryTap(3),
                ),

              ],
            ),
          ),
          SpaceHeight(24.0),
          GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 25.0,
              crossAxisSpacing: 25.0,
              childAspectRatio: 0.7,
            ),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 10,
            itemBuilder: (context, index) => ProductCard(),
          )
        ],
      ),
    );
  }
}

