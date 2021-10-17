import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:shop_app/components/components.dart';
import 'package:shop_app/cubit/shop_cubit/shop_cubit.dart';
import 'package:shop_app/cubit/shop_cubit/shop_state.dart';
import 'package:shop_app/models/favorites_model.dart';
import 'package:shop_app/styles/colors.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var _cubit = ShopCubit.get(context);
        return Conditional.single(
          context: context,
          conditionBuilder: (context) => state is! ShoploadingGetFavoritesState,
          widgetBuilder: (context) => ListView.separated(
              itemBuilder: (context, index) => buildListProduct(
                  _cubit.favoritesModel!.data.data[index].product, context),
              separatorBuilder: (context, index) => myDivider(),
              itemCount: _cubit.favoritesModel!.data.data.length),
          fallbackBuilder: (context) => Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }

  }
