import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/components/components.dart';
import 'package:shop_app/cubit/search_cubit/search_cubit.dart';
import 'package:shop_app/cubit/search_cubit/search_state.dart';

// ignore: must_be_immutable
class SearchScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchCubit(),
      child: BlocConsumer<SearchCubit, SearchStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var _cubit = SearchCubit.get(context);
          return Scaffold(
            appBar: AppBar(),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(children: [
                defaultFormFeild(
                  controller: searchController,
                  type: TextInputType.text,
                  returnValidate: 'enter text to search!',
                  label: 'Search',
                  prefix: Icons.search,
                  onSubmit: (text) {
                    SearchCubit.get(context).search(text);
                  },
                ),
                SizedBox(
                  height: 10.0,
                ),
                if (state is SearchLoadingState) LinearProgressIndicator(),
                if (state is SearchSuccessState)
                  Expanded(
                    child: ListView.separated(
                      physics: BouncingScrollPhysics(),
                        itemBuilder: (context, index) => buildListProduct(
                            _cubit.model!.data.data[index], context),
                        separatorBuilder: (context, index) => myDivider(),
                        itemCount: _cubit.model!.data.data.length),
                  ),
              ]),
            ),
          );
        },
      ),
    );
  }
}
