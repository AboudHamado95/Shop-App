import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/cache/cache_helper.dart';
import 'package:shop_app/components/components.dart';
import 'package:shop_app/cubit/login_cubit/shop_login_cubit.dart';

import 'package:shop_app/cubit/login_cubit/shop_login_state.dart';
import 'package:shop_app/screens/authentication/register_screen.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:shop_app/screens/layouts/shop_layout.dart';

// ignore: must_be_immutable
class LoginScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    return BlocProvider(
      create: (context) => ShopLoginCubit(),
      child: BlocConsumer<ShopLoginCubit, ShopLoginStates>(
        listener: (context, state) {
          if (state is ShopLoginSuccessState) {
            if (state.loginModel.status) {
              print(state.loginModel.message);
              print(state.loginModel.data.token);
              CacheHelper.saveData(
                      key: 'token', value: state.loginModel.data.token)
                  .then((value) {
                navigateAndFinish(context, ShopLayout());
              });
            } else {
              print(state.loginModel.message);
              showToast(
                  message: state.loginModel.message,
                  state: ToastStates.ERROR);
            }
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'LOGIN',
                          style: Theme.of(context)
                              .textTheme
                              .headline4!
                              .copyWith(color: Colors.black),
                        ),
                        Text(
                          'Login now to browse our hot offers',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(color: Colors.grey),
                        ),
                        SizedBox(height: 30.0),
                        defaultFormFeild(
                            controller: emailController,
                            type: TextInputType.emailAddress,
                            returnValidate: 'please enter your email address!',
                            label: 'Email Address',
                            prefix: Icons.email_outlined),
                        SizedBox(height: 15.0),
                        defaultFormFeild(
                            controller: passwordController,
                            type: TextInputType.visiblePassword,
                            suffix: ShopLoginCubit.get(context).suffix,
                            isPassword: ShopLoginCubit.get(context).isPassword,
                            suffixPressed: () {
                              ShopLoginCubit.get(context)
                                  .changePasswordVisibility();
                            },
                            returnValidate: 'password is too short!',
                            label: 'Password',
                            prefix: Icons.lock_outline),
                        SizedBox(height: 30.0),
                        Conditional.single(
                            context: context,
                            conditionBuilder: (context) {
                              return state is! ShopLoginLoadingState;
                            },
                            widgetBuilder: (context) => defaultButton(
                                  function: () {
                                    if (formKey.currentState!.validate()) {
                                      ShopLoginCubit.get(context).userLogin(
                                          email: emailController.text,
                                          password: passwordController.text);
                                    }
                                  },
                                  text: 'login',
                                  isUpperCase: true,
                                ),
                            fallbackBuilder: (context) => Center(
                                  child: CircularProgressIndicator(),
                                )),
                        SizedBox(
                          height: 15.0,
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Don\'t have an account?',
                              ),
                              defaultTextButton(
                                  function: () {
                                    navigateTo(context, RegisterScreen());
                                  },
                                  text: 'REGISTER'),
                            ]),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
