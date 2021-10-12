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
        return Conditional.single(context: context, 
        conditionBuilder: (context) => state is! ShoploadingGetFavoritesState , 
          widgetBuilder: (context) => ListView.separated(
            itemBuilder: (context, index) =>
                buildFavItem(_cubit.favoritesModel!.data.data[index],context),
            separatorBuilder: (context, index) => myDivider(),
            itemCount: _cubit.favoritesModel!.data.data.length),
             fallbackBuilder: (context) => Center(child: CircularProgressIndicator(),),);
      },
    );
  }

  Widget buildFavItem(FavoritesData model,context) => Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          height: 120.0,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                alignment: AlignmentDirectional.bottomStart,
                children: [
                  Image(
                    image: CachedNetworkImageProvider(
                        model.product.image),
                    width: 120.0,
                    height: 120.0,
                    fit: BoxFit.cover,
                  ),
                  if (model.product.discount != 0)
                    Container(
                      color: Colors.red,
                      padding: EdgeInsets.symmetric(horizontal: 5.0),
                      child: Text(
                        'DISCOUNT',
                        style: TextStyle(
                          fontSize: 8.0,
                          color: Colors.white,
                        ),
                      ),
                    )
                ],
              ),
              SizedBox(
                width: 20.0,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      model.product.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 14.0, height: 1.3),
                    ),
                    Spacer(),
                    Row(
                      children: [
                        Text(
                          '${model.product.price.round()}',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 12.0, height: 1.3, color: defaultColor),
                        ),
                        SizedBox(
                          width: 5.0,
                        ),
                        if (model.product.discount != 0)
                          Text(
                            '${model.product.oldPrice.round()}',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 10.0,
                                height: 1.3,
                                color: Colors.grey,
                                decoration: TextDecoration.lineThrough),
                          ),
                        Spacer(),
                        IconButton(
                          padding: EdgeInsets.zero,
                          onPressed: () {
                            ShopCubit.get(context).changeFavorites(
                                model.product.id);
                          },
                          icon: CircleAvatar(
                            backgroundColor:
                             ShopCubit.get(context)
                                    .favorites[model.product.id]!
                                ? defaultColor
                                :
                                 Colors.grey,
                            radius: 15.0,
                            child: Icon(
                              Icons.favorite_border_outlined,
                              size: 14.0,
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
}
