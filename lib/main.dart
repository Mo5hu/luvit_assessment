import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:luvit_assessment/bloc/NavigationBloc/bloc.dart';
import 'package:luvit_assessment/constants/app_colors.dart';
import 'firebase_options.dart';
import 'package:luvit_assessment/hydrated_app.dart';
import 'package:luvit_assessment/services/api_service.dart';
import 'package:luvit_assessment/styles/text_styles.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Future<FirebaseApp> initFirebase() async {
    return await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<FirebaseApp>(
        future: initFirebase(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return const Center(child: Text("Error Initializing Application"));
          }
          if (snapshot.connectionState == ConnectionState.done) {
            final apiService = ApiService();
            final navigationBloc = NavigationBloc(apiService);
            return DehydratedApp(navigationBloc);
          }
          return Container();
        });
  }
}

class DehydratedApp extends StatelessWidget {
  final NavigationBloc navigationBloc;

  const DehydratedApp(this.navigationBloc, {super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'The Movie Db',
      theme: ThemeData(
          primarySwatch: AppColors.primaryColor,
          cardColor: AppColors.accentColor,
          textTheme: const TextTheme(
              displayLarge: AppTextStyles.heading1,
              displayMedium: AppTextStyles.heading2,
              bodyLarge: AppTextStyles.bodyBold,
              bodyMedium: AppTextStyles.bodyRegular,
              bodySmall: AppTextStyles.bodySmall,
              titleMedium: AppTextStyles.movieRow)),
      initialRoute: '/',
      routes: {
        '/': (context) => BlocProvider.value(
              value: navigationBloc,
              child: const HydratedApp(),
            ),
      },
    );
  }
}
