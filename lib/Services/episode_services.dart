import 'dart:convert';
import 'package:http/http.dart' as http;

class EpisodeService {
  final String baseUrl =
      'https://music-app-server-1-h4hl.onrender.com/api/episodes'; // الرابط الخاص بالخادم

  Future<List<dynamic>> fetchallEpisodes() async {
    final response = await http.get(Uri.parse('$baseUrl/'));
    if (response.statusCode == 200) {
      print("fetchallEpisodes ${response.body}");
      final data = json.decode(response.body);

      if (data is List) {
        print("Type of data: ${data.runtimeType}");

        return data;
      } else {
        throw Exception('Unexpected response format');
      }
    } else {
      throw Exception('Failed to load episodes: ${response.statusCode}');
    }
  }

  Future<List<dynamic>> fetchLatestEpisodes() async {
    final response = await http.get(Uri.parse('$baseUrl/latest'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      if (data is List) {
        print(" Listtttt it is                              $data");

        print("Type of data: ${data.runtimeType}");

        return data;
      } else {
        throw Exception('Unexpected response format');
      }
    } else {
      throw Exception('Failed to load : ${response.statusCode}');
    }
  }
}
