import 'dart:convert';
import 'package:http/http.dart' as http;

class SongService {
  final String baseUrl =
      'https://music-app-server-1-h4hl.onrender.com/api/songs'; // الرابط الخاص بالخادم

  Future<List<dynamic>> fetchallSongs() async {
    final response = await http.get(Uri.parse('$baseUrl/'));
    if (response.statusCode == 200) {
      print("fetchallSongs ${response.body}");
      final data = json.decode(response.body);

      if (data['songs'] is List) {
        // print(" Listtttt it is                              $data['songs']");

        print("Type of data['songs']: ${data['songs'].runtimeType}");

        return data['songs'];
      } else {
        throw Exception('Unexpected response format');
      }
    } else {
      throw Exception('Failed to load songs: ${response.statusCode}');
    }
  }

  Future<List<dynamic>> fetchLatestSongs() async {
    final response = await http.get(Uri.parse('$baseUrl/latest'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      if (data['songs'] is List) {
        // print(" Listtttt it is                              $data['songs']");

        // print("Type of data['songs']: ${data['songs'].runtimeType}");

        return data['songs'];
      } else {
        throw Exception('Unexpected response format');
      }
    } else {
      throw Exception('Failed to load songs: ${response.statusCode}');
    }
  }
}
