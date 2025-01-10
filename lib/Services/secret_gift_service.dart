import 'dart:convert';
import 'package:http/http.dart' as http;

class SecretGiftService {
  final String baseUrl =
      'https://music-app-server-1-h4hl.onrender.com/api/secretGifts';

  Future<bool> sendGift(String receiverId, songList, String content) async {
    final response = await http.post(Uri.parse('$baseUrl/send'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({
          "receiverId": receiverId,
          "songList": songList,
          "content": content
        }));
    print("response.statusCode ${response.statusCode}");
    if (response.statusCode == 201) {
      // إذا كانت الاستجابة ناجحة، قم بتحليل البيانات
      print(true);
      return true;
    } else {
      // إذا كانت الاستجابة فشلت، إرجاع null
      return false;
    }
  }

  Future<List<dynamic>> getGifts() async {
    final response = await http.get(Uri.parse('$baseUrl/send'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      if (data['receivedGifts'] is List) {
        return data['receivedGifts'];
      } else {
        throw Exception('Unexpected response format');
      }
    } else {
      throw Exception('Failed to load gifts: ${response.statusCode}');
    }
  }
}
