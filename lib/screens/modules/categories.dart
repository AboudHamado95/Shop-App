import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/components/components.dart';
import 'package:shop_app/cubit/shop_cubit/shop_cubit.dart';
import 'package:shop_app/cubit/shop_cubit/shop_state.dart';
import 'package:shop_app/models/categories_model.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var _cubit = ShopCubit.get(context);

        return ListView.separated(
            itemBuilder: (context, index) =>
                buildCatItem(_cubit.categoriesModel!.data!.data[index]),
            separatorBuilder: (context, index) => myDivider(),
            itemCount: _cubit.categoriesModel!.data!.data.length);
      },
    );
  }

  Widget buildCatItem(DataModel model) => Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Image(
              image: CachedNetworkImageProvider(model.image),
              height: 80.0,
              width: 80.0,
              fit: BoxFit.cover,
            ),
            Text(
              model.name,
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            Spacer(),
            Icon(Icons.arrow_back_ios_new)
          ],
        ),
      );
}
