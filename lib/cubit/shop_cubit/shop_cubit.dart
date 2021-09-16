import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/cache/cache_helper.dart';
import 'package:shop_app/cubit/shop_cubit/shop_state.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/networks/dio_helper.dart';
import 'package:shop_app/networks/end_points.dart';
import 'package:shop_app/screens/modules/categories.dart';
import 'package:shop_app/screens/modules/favorites.dart';
import 'package:shop_app/screens/modules/products.dart';
import 'package:shop_app/screens/modules/search.dart';
import 'package:shop_app/screens/modules/settings.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitialState());

  static ShopCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;

  List<Widget> bottomScreen = [
    CategoriesScreen(),
    FavoritesScreen(),
    ProductsScreen(),
    SearchScreen(),
    SettingsScreen(),
  ];
  List<BottomNavigationBarItem> bottomItem = [
    BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
    BottomNavigationBarItem(icon: Icon(Icons.apps), label: 'Categories'),
    BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Favorites'),
    BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
  ];
  void changeBottom(int index) {
    currentIndex = index;
    emit(ShopChangeBottomNavState());
  }

  String? token = CacheHelper.getData(key: 'token');

  late HomeModel homeModel;
  void getHomeData() {
    emit(ShoploadingHomeDataState());
    DioHelper.getData(url: HOME, token: token).then((value) {
      homeModel = HomeModel.fromJson(value.data);
      print(homeModel.data!.banners[0].image);
      print(homeModel.status);
      emit(ShopSuccessHomeDataState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorHomeDataState(error));
    });
  }
}
