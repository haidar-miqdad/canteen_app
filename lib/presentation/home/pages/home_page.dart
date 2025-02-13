// ignore_for_file: deprecated_member_use_from_same_package
import 'package:cached_network_image/cached_network_image.dart';
import 'package:canteen_app/core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/model/response/product_response_model.dart';
import '../../auth/pages/login_page.dart';
import '../blocs/logout/logout_bloc.dart';
import '../blocs/product/product_bloc.dart';

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
    context.read<ProductBloc>().add(ProductCategoryFetched(category: category));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 20.0,
      ),
      child: ListView(
        children: [
          Row(
            children: [
              AppTitle(text: 'Catalog'),
              Spacer(),
              BlocConsumer<LogoutBloc, LogoutState>(
                listener: (context, state) {
                  if (state is LogoutSuccess) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginPage(),
                      ),
                    );
                  }

                  if (state is LogoutFailure) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(state.message),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                },
                builder: (context, state) {
                  if (state is LogoutLoading) {
                    return const CircularProgressIndicator();
                  }
                  return IconButton(
                    onPressed: () {
                      context.read<LogoutBloc>().add(LogoutButtonPressed());
                    },
                    icon: Icon(Icons.logout),
                  );
                },
              )
            ],
          ),
          SpaceHeight(18.0),
          CustomTextField(
            controller: searchController,
            hintText: 'Search..',
            prefixIcon: Assets.icons.search.svg(),
          ),
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
          BlocBuilder<ProductBloc, ProductState>(
            builder: (context, state) {
              if (state is ProductLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (state is ProductFailure) {
                return Text(state.message);
              }

              if (state is ProductSuccess) {
                return GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 25.0,
                    crossAxisSpacing: 25.0,
                    childAspectRatio: 0.7,
                  ),
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: state.products.length,
                  itemBuilder: (context, index) => ProductCard(
                    product: state.products[index],
                    onPressed: () {},
                  ),
                );
              }
              return SizedBox();
            },
          )
        ],
      ),
    );
  }
}
