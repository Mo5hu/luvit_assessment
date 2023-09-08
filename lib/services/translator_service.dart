import 'package:simplytranslate/simplytranslate.dart';

class TranslationService {
  final SimplyTranslator _translator = SimplyTranslator(EngineType.google);

  Future<void> setWorkingInstance() async {
    final availableInstances = _translator.getInstances;

    for (final instance in availableInstances) {
      final isWorking = await _translator.isSimplyInstanceWorking(instance);
      if (isWorking) {
        break;
      }
      _translator.nextSimplyInstance();
    }
  }

  Future<String> translateToKorean(String text) async {
    try {
      setWorkingInstance();
      final translation = await _translator.trSimply(text, 'en', 'ko');
      return translation;
    } catch (e) {
      print("Translation error: $e");
      return "번역 오류";
    }
  }
}
