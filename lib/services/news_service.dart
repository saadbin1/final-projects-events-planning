import 'dart:convert';
import 'package:http/http.dart' as http;

class NewsService {
  final String apiKey = 'b8738b7e6e0d4a949fbbf54a1763fa6d';
  final String baseUrl = 'https://newsapi.org/v2/';

  Future<List<dynamic>> fetchNews() async {
    final response = await http.get(
      Uri.parse(
        '${baseUrl}everything?q=events+venue+Pakistan&language=en&sortBy=relevancy&apiKey=$apiKey',
      ),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = json.decode(response.body);
      return jsonResponse['articles'];
    } else {
      throw Exception('Failed to load news');
    }
  }
}
