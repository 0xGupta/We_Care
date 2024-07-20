import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:we_care/backend/search_results.dart';

class BackendService {
  Future<List<Result>> fetchResults(String query) async {
    final response = await http
        .get(Uri.parse('https://example.com/api/search?query=$query'));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((json) => Result.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load results');
    }
  }
}
