import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:luvit_assessment/bloc/NavigationBloc/bloc.dart';
import 'package:luvit_assessment/bloc/NavigationBloc/event.dart';
import 'package:luvit_assessment/bloc/NavigationBloc/state.dart';
import 'package:luvit_assessment/widgets/get_main_screens.dart';

class HydratedApp extends StatelessWidget {
  const HydratedApp({super.key});

  @override
  Widget build(BuildContext context) {
    final navigationBloc = BlocProvider.of<NavigationBloc>(context);
    return BlocBuilder<NavigationBloc, NavigationState>(
        builder: (context, state) {
      return Scaffold(
        backgroundColor: Color.fromARGB(255, 14, 13, 13),
        body: SafeArea(child: getMainScreens(state, navigationBloc.apiService)),
        bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.amp_stories_outlined),
              label: 'Explore',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.bookmark_border_rounded),
              label: 'Saved',
            )
          ],
          currentIndex: _getSelectedIndex(state),
          onTap: (index) {
            if (navigationBloc.state is LoadingState) {
            } else {
              if (index == 0) {
                navigationBloc.add(NavigateToHomeEvent());
              } else if (index == 1) {
                navigationBloc.add(NavigateToScreen1());
              } else if (index == 2) {
                navigationBloc.add(NavigateToScreen2());
              } else if (index == 3) {
                navigationBloc.add(NavigateToScreen3());
              } else if (index == 4) {
                navigationBloc.add(NavigateToScreen4());
              }
            }
          },
          backgroundColor: Colors.black,
        ),
      );
    });
  }

  int _getSelectedIndex(NavigationState state) {
    if (state is HomeScreenState) {
      return 0;
    } else if (state is Screen1State) {
      return 1;
    } else if (state is Screen2State) {
      return 2;
    } else if (state is Screen3State) {
      return 3;
    } else if (state is Screen4State) {
      return 4;
    } else {
      return 0;
    }
  }
}
