// States

import 'package:firebase_database/firebase_database.dart';

abstract class NavigationState {}

class HomeScreenState extends NavigationState {
  Stream<DatabaseEvent> dataStream;
  HomeScreenState({required this.dataStream});
}

class Screen1State extends NavigationState {}

class Screen2State extends NavigationState {}

class Screen3State extends NavigationState {}

class Screen4State extends NavigationState {}

class LoadingState extends NavigationState {}

class ErrorState extends NavigationState {
  final String errorMessage;
  ErrorState(this.errorMessage);
}
