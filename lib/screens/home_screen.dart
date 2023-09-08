import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import 'package:luvit_assessment/services/translator_service.dart';
import 'package:luvit_assessment/widgets/card.dart';
import 'package:luvit_assessment/widgets/loading_screen.dart';
import '../data/fruit.dart';
import '../helper_functions/extractingFromJson.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen(
      {Key? key, required this.dataStream, required this.translationService})
      : super(key: key);
  final Stream<DatabaseEvent> dataStream;
  final TranslationService translationService;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DatabaseEvent>(
        stream: dataStream,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            const Center(
                child: Text(
                    "Error Fetching Data, \nCheck your internet connection."));
          }

          if (snapshot.connectionState == ConnectionState.active) {
            if (snapshot.hasData &&
                snapshot.data != null &&
                (snapshot.data!).snapshot.value != null) {
              return FutureBuilder<List<Fruit>>(
                  future: extractingFromJson(snapshot, translationService),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return CardWidget(fruitList: snapshot.data!);
                    }

                    if (snapshot.hasError) {
                      return const Center(child: Text('Error processing data'));
                    }
                    return const LoadingScreen();
                  });
            }
          }
          print('debugging: fetching data from firebase');
          return const LoadingScreen();
        });
  }
}
