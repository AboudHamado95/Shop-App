import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/cache/cache_helper.dart';
import 'package:shop_app/cubit/bloc_observe.dart';
import 'package:shop_app/networks/dio_helper.dart';
import 'package:shop_app/screens/on_boarding_screen.dart';
import 'package:shop_app/styles/themes.dart';

main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();
  bool? isDark = CacheHelper.getData(key: 'isDark');
  runApp(MyApp(isDark: isDark));
}

class MyApp extends StatelessWidget {
  final bool? isDark;
  const MyApp({
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      darkTheme: darkTheme,
      home: OnBoardingScreen(),
    );
  }
}
