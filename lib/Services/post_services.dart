import 'package:http/http.dart' as http;
import 'dart:convert';

class PostService {
  final String baseUrl =
      'https://music-app-server-1-h4hl.onrender.com/api/posts'; // الرابط الخاص بالخادم

  // إضافة بوست جديد
  Future<Map<String, dynamic>> createPost(String community, String content,
      String? songId, String? episodeId, token) async {
    final url = Uri.parse('$baseUrl/add'); // تحديد رابط API الخاص بإضافة البوست
    final response = await http.post(url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': token, // ارسال الـ Token للتوثيق
        },
        body: json.encode({
          'community': community,
          'content': content,
          'songId': songId,
          'episodeId': episodeId,
        }));

    if (response.statusCode == 201) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to create post ${response.body}');
    }
  }

  // جلب جميع البوستات الخاصة بالكوميونيتي
  Future<List<dynamic>> getPostsByCommunity(String communityName, token) async {
    final url = Uri.parse('$baseUrl/$communityName');
    final response = await http.get(url, headers: {
      'Authorization': token, // ارسال الـ Token للتوثيق
    });

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
      print(response.body);
      throw Exception('Failed to fetch posts ${response.body}');
    }
  }

  // جلب جميع البوستات
  Future<List<dynamic>> getAllPosts(token) async {
    final url = Uri.parse('$baseUrl/');
    final response = await http.get(url, headers: {
      'Authorization': token, // ارسال الـ Token للتوثيق
    });

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
      print(response.body);

      throw Exception('Failed to fetch posts ${response.body}');
    }
  }

  // // جلب جميع البوستات الخاصة باليوزر
  // Future<List<Map<String, dynamic>>> getPostsByUserId( token) async {
  //   final url = Uri.parse('$baseUrl/user/');
  //   final response = await http.get(url, headers: {
  //     'Authorization': token,  // ارسال الـ Token للتوثيق
  //   });

  //   if (response.statusCode == 200) {
  //     return List<Map<String, dynamic>>.from(json.decode(response.body));
  //   } else {
  //     throw Exception('Failed to fetch posts');
  //   }
  // }

  // تغيير حالة اللايك
  Future<Map<String, dynamic>> toggleLike(String postId, token) async {
    final url = Uri.parse('$baseUrl/$postId/like');
    final response = await http.post(url, headers: {
      'Authorization': token, // ارسال الـ Token للتوثيق
    });

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to toggle like');
    }
  }
}
