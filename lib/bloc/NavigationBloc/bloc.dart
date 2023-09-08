import 'package:bloc/bloc.dart';
import 'package:luvit_assessment/bloc/NavigationBloc/event.dart';
import 'package:luvit_assessment/bloc/NavigationBloc/state.dart';
import 'package:luvit_assessment/services/api_service.dart';

import '../../services/firebase_rtdb_service.dart';

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  final ApiService apiService;
  FirebaseRealtimeDatabaseService databaseService =
      FirebaseRealtimeDatabaseService();

  NavigationBloc(this.apiService) : super(LoadingState()) {
    on<NavigationEvent>((event, emit) async {
      if (event is NavigateToHomeEvent) {
        print('debugging: To Home');
        emit(LoadingState());

        await apiService.resetData();

        emit(HomeScreenState(
            dataStream: databaseService.listenToDataUpdates("data")));
      } else if (event is NavigateToScreen1) {
        print('debugging: To Screen1');
        emit(Screen1State());
      } else if (event is NavigateToScreen2) {
        print('debugging: To Screen2');
        emit(Screen2State());
      } else if (event is NavigateToScreen3) {
        print('debugging: To Screen3');
        emit(Screen3State());
      } else if (event is NavigateToScreen4) {
        print('debugging: To Screen4');
        emit(Screen4State());
      } else if (event is LoadDataEvent) {
        print('debugging: To Loading');
        emit(LoadingState());
      }
    });
    add(NavigateToHomeEvent());
  }
}
