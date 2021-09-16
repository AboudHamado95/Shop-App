import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/cache/cache_helper.dart';
import 'package:shop_app/components/components.dart';
import 'package:shop_app/cubit/shop_cubit/shop_cubit.dart';
import 'package:shop_app/cubit/shop_cubit/shop_state.dart';
import 'package:shop_app/screens/authentication/login_screen.dart';
import 'package:shop_app/screens/modules/search.dart';

class ShopLayout extends StatelessWidget {
  const ShopLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var _cubit = ShopCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text('Salla'),
            actions: [
              IconButton(onPressed: () {
                navigateTo(context, SearchScreen());
              }, icon: Icon(Icons.search_outlined))
            ],
          ),
          body: _cubit.bottomScreen[_cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: _cubit.currentIndex,
            onTap: (index) => _cubit.changeBottom(index),
            items: _cubit.bottomItem,
          ),
        );
      },
    );
  }
}
