import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/widgets.dart';
import 'package:luvit_assessment/services/translator_service.dart';

import '../data/fruit.dart';

Future<List<Fruit>> extractingFromJson(
  AsyncSnapshot<DatabaseEvent> snapshot,
  TranslationService translationService,
) async {
  List<Fruit> fruitList = [];

  Map<dynamic, dynamic> data = Map<dynamic, dynamic>.from(
    (snapshot.data!).snapshot.value as Map<dynamic, dynamic>,
  );

  // Create a list to store the translation futures
  List<Future<void>> translationFutures = [];

  data.forEach((key, value) {
    final currentFruit = Map<String, dynamic>.from(value);
    List<String> images = [];
    List<String> tags = [];
    if (currentFruit['images'] != null) {
      final List<String?> rawImages =
          List<String?>.from(currentFruit['images']);
      images =
          rawImages.where((element) => element != null).cast<String>().toList();
    }

    if (currentFruit['tags'] != null) {
      final List<String?> rawTags = List<String?>.from(currentFruit['tags']);
      tags =
          rawTags.where((element) => element != null).cast<String>().toList();
    }

    // Add translation futures to the list
    translationFutures.add(
      Future.wait([
        translationService.translateToKorean(currentFruit['name'] ?? ''),
        translationService.translateToKorean(currentFruit['location'] ?? ''),
        translationService.translateToKorean(currentFruit['description'] ?? ''),
      ]).then((List<String> translations) {
        fruitList.add(Fruit(
          name: translations[0],
          location: translations[1],
          age: currentFruit['age'] ?? 0,
          description: translations[2],
          likeCount: currentFruit['likeCount'] ?? 0,
          tags: tags,
          images: images,
        ));
      }),
    );
  });

  // Wait for all translation futures to complete
  await Future.wait(translationFutures);

  return fruitList;
}
//   Map<dynamic, dynamic> data = Map<dynamic, dynamic>.from(
//       (snapshot.data!).snapshot.value as Map<dynamic, dynamic>);

//   data.forEach((key, value) {
//     final currentFruit = Map<String, dynamic>.from(value);
//     List<String> images = [];
//     List<String> tags = [];
//     if (currentFruit['images'] != null) {
//       final List<String?> rawImages =
//           List<String?>.from(currentFruit['images']);
//       images =
//           rawImages.where((element) => element != null).cast<String>().toList();
//     }

//     if (currentFruit['tags'] != null) {
//       final List<String?> rawtags = List<String?>.from(currentFruit['tags']);
//       tags =
//           rawtags.where((element) => element != null).cast<String>().toList();
//     }
//     fruitList.add(Fruit(
//       age: currentFruit['age'],
//       description: currentFruit['description'],
//       images: images,
//       likeCount: currentFruit['likeCount'],
//       location: currentFruit['location'],
//       name: currentFruit['name'],
//       tags: tags,
//     ));
//   });
//   return fruitList;
// }
