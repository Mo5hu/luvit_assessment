import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'https://frontassignment.hyperhire.in/change';

  Future<dynamic> resetData() async {
    final response = await http.post(Uri.parse(baseUrl));
    print(
        'debugging: Reset Firebase POST request statusCode: ${response.statusCode}');
    if (response.statusCode == 201) {
      return response.body;
    } else {
      throw Exception('Failed to load data');
    }
  }
}
