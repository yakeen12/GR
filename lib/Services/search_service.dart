import 'package:http/http.dart' as http;
import 'dart:convert';

class SearchService {
  final String apiUrl =
      'https://music-app-server-1-h4hl.onrender.com/api/search';

  Future<Map<String, dynamic>> search(String query) async {
    final response = await http.get(Uri.parse('$apiUrl/search?query=$query'));
    print(response.body);

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load search results');
    }
  }

  Future<Map<String, dynamic>> searchSongs(String query) async {
    final response =
        await http.get(Uri.parse('$apiUrl/searchsongs?query=$query'));
    print(response.body);

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load search results');
    }
  }
}
