import 'package:e_commerce/ui/home/home_screen/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../tabs/home_tab/home_tab.dart';
import '../../tabs/product_list_tab/product_list_tab.dart';
import '../../tabs/profile_tab/profile_tab.dart';

class HomeScreenViewModel extends Cubit<HomeScreenState> {
  HomeScreenViewModel() : super(HomeInitState());
  int selectedIndex = 0;
  List<Widget> tabs = [
    HomeTab(),
    ProductListTab(),
    ProfileTab()
  ];

  static HomeScreenViewModel getBloc(context) => BlocProvider.of(context);

  void changeSelectedIndex(int newSelectedIndex) {
    emit(HomeInitState());
    selectedIndex = newSelectedIndex;
    emit(ChangeNavBarState());
  }

}
