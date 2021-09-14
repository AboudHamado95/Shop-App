import 'package:flutter/material.dart';
import 'package:shop_app/cache/cache_helper.dart';
import 'package:shop_app/components/components.dart';
import 'package:shop_app/screens/login_screen.dart';

class ShopLayout extends StatelessWidget {
  const ShopLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Column(
          children: [
            Text('Salla'),
            MaterialButton(
              onPressed: () {
                CacheHelper.removeData(key: 'token').then((value) {
                  navigateAndFinish(context, LoginScreen());
                });
              },
              child: Text('Sign out'),
            )
          ],
        ));
  }
}
