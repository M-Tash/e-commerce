import 'package:e_commerce/ui/home/home_screen/cubit/home_screen_view_model.dart';
import 'package:e_commerce/ui/home/home_screen/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'widget/custom_bottom_navigation_bar.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = 'home';

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeScreenViewModel viewModel = HomeScreenViewModel(
  );

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeScreenViewModel>(
      create: (context) => viewModel,
      child: BlocBuilder<HomeScreenViewModel, HomeScreenState>(
        builder: (context, state) {
          return Scaffold(
            bottomNavigationBar: buildCustomBottomNavigationBar(
              context: context,
              selectedIndex: viewModel.selectedIndex,
              onTapFunction: (index) {
                viewModel.changeSelectedIndex(index);
              },
            ),
            body: viewModel.tabs[viewModel.selectedIndex],
          );
        },
      ),
    );
  }
}
