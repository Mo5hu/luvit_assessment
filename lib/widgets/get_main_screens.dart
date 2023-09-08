import 'package:flutter/material.dart';
import 'package:luvit_assessment/bloc/NavigationBloc/state.dart';
import 'package:luvit_assessment/screens/screen_1.dart';
import 'package:luvit_assessment/screens/screen_4.dart';
import 'package:luvit_assessment/screens/home_screen.dart';
import 'package:luvit_assessment/services/api_service.dart';

import '../screens/screen_2.dart';
import '../screens/screen_3.dart';
import 'loading_screen.dart';

Widget getMainScreens(NavigationState state, ApiService apiService) {
  if (state is HomeScreenState) {
    return HomeScreen(
        dataStream: state.dataStream,
        translationService: state.translationService);
  } else if (state is Screen1State) {
    return const Screen1();
  } else if (state is Screen2State) {
    return const Screen2();
  } else if (state is Screen3State) {
    return const Screen3();
  } else if (state is Screen4State) {
    return const Screen4();
  } else if (state is LoadingState) {
    return const LoadingScreen();
  } else {
    return const Center(child: Text('Unknown State'));
  }
}
