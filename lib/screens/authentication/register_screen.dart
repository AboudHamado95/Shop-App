import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:shop_app/Constants/constants.dart';
import 'package:shop_app/cache/cache_helper.dart';
import 'package:shop_app/components/components.dart';
import 'package:shop_app/cubit/register_cubit/shop_register_cubit.dart';
import 'package:shop_app/cubit/register_cubit/shop_register_state.dart';
import 'package:shop_app/screens/authentication/login_screen.dart';
import 'package:shop_app/screens/layouts/shop_layout.dart';

// ignore: must_be_immutable
class RegisterScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopRegisterCubit(),
      child: BlocConsumer<ShopRegisterCubit, ShopRegisterStates>(
        listener: (context, state) {
          if (state is ShopRegisterSuccessState) {
            if (state.loginModel.status) {
              print(state.loginModel.message);
              print(state.loginModel.data.token);
              CacheHelper.saveData(
                      key: 'token', value: state.loginModel.data.token)
                  .then((value) {
                token = state.loginModel.data.token;
                navigateAndFinish(context, ShopLayout());
              });
            } else {
              print(state.loginModel.message);
              showToast(
                  message: state.loginModel.message, state: ToastStates.ERROR);
            }
          }
        },
        builder: (context, state) {
          return Scaffold(
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
                          'REGISTER',
                          style: Theme.of(context)
                              .textTheme
                              .headline4!
                              .copyWith(color: Colors.black),
                        ),
                        Text(
                          'Register now to browse our hot offers',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(color: Colors.grey),
                        ),
                        SizedBox(height: 30.0),
                        defaultFormFeild(
                            controller: nameController,
                            type: TextInputType.name,
                            returnValidate: 'please enter your name!',
                            label: 'Name',
                            prefix: Icons.person),
                        SizedBox(height: 15.0),
                        defaultFormFeild(
                            controller: emailController,
                            type: TextInputType.emailAddress,
                            returnValidate: 'please enter your email address!',
                            label: 'Email Address',
                            prefix: Icons.email),
                        SizedBox(height: 15.0),
                        defaultFormFeild(
                            controller: passwordController,
                            type: TextInputType.visiblePassword,
                            suffix: ShopRegisterCubit.get(context).suffix,
                            isPassword:
                                ShopRegisterCubit.get(context).isPassword,
                            suffixPressed: () {
                              ShopRegisterCubit.get(context)
                                  .changePasswordVisibility();
                            },
                            returnValidate: 'password is too short!',
                            label: 'Password',
                            prefix: Icons.lock_outline),
                        SizedBox(height: 15.0),
                        defaultFormFeild(
                            controller: phoneController,
                            type: TextInputType.phone,
                            returnValidate: 'please enter your phone!',
                            label: 'Phone',
                            prefix: Icons.phone),
                        SizedBox(height: 30.0),
                        Conditional.single(
                            context: context,
                            conditionBuilder: (context) {
                              return state is! ShopRegisterLoadingState;
                            },
                            widgetBuilder: (context) => defaultButton(
                                  function: () {
                                    if (formKey.currentState!.validate()) {
                                      ShopRegisterCubit.get(context)
                                          .userRegister(
                                              name: nameController.text,
                                              email: emailController.text,
                                              password: passwordController.text,
                                              phone: phoneController.text);
                                    }
                                  },
                                  text: 'register',
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
                                'You have an account?',
                              ),
                              defaultTextButton(
                                  function: () {
                                    navigateTo(context, LoginScreen());
                                  },
                                  text: 'LOGIN'),
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
