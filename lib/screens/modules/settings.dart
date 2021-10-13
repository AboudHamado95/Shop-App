import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:shop_app/cache/cache_helper.dart';
import 'package:shop_app/components/components.dart';
import 'package:shop_app/cubit/shop_cubit/shop_cubit.dart';
import 'package:shop_app/cubit/shop_cubit/shop_state.dart';

// ignore: must_be_immutable
class SettingsScreen extends StatelessWidget {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var model = ShopCubit.get(context).userModel;
        nameController.text = model!.data.name;
        emailController.text = model.data.email;
        phoneController.text = model.data.phone;
        return Conditional.single(
          context: context,
          conditionBuilder: (context) =>
              ShopCubit.get(context).userModel != null
              ,
          widgetBuilder: (context) => Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                defaultFormFeild(
                    controller: nameController,
                    type: TextInputType.name,
                    returnValidate: 'name must not be empty!',
                    label: 'Name',
                    prefix: Icons.person),
                SizedBox(height: 20.0),
                defaultFormFeild(
                    controller: emailController,
                    type: TextInputType.emailAddress,
                    returnValidate: 'email must not be empty!',
                    label: 'Email',
                    prefix: Icons.email),
                SizedBox(height: 20.0),
                defaultFormFeild(
                    controller: phoneController,
                    type: TextInputType.phone,
                    returnValidate: 'phone must not be empty!',
                    label: 'Phone',
                    prefix: Icons.phone),
                SizedBox(height: 20.0),
                defaultButton(function: () {
                  CacheHelper.signOut(context);
                }, text: 'LOGOUT')
              ],
            ),
          ),
          fallbackBuilder: (context) => Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
