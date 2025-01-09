import 'package:http/http.dart' as http;
import 'package:music_app/Models/episode_model.dart';
import 'package:music_app/Models/post_model.dart';
import 'package:music_app/Models/song_model.dart';
import 'package:music_app/Models/user_model.dart';
import 'dart:convert';

import 'package:music_app/utils/local_storage_service.dart';

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

  // جلب جميع البوستات الخاصة باليوزر
  Future<List<dynamic>> getPostsByUserId(String userId) async {
    final url = Uri.parse('$baseUrl/$userId/posts');
    final response = await http.get(url, headers: {
      'Authorization':
          LocalStorageService().getToken()!, // ارسال الـ Token للتوثيق
    });

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data is List) {
        print(data);
        return data;
      } else {
        throw Exception('Unexpected response format');
      }
    } else {
      print(response.body);

      throw Exception('Failed to fetch user posts ${response.body}');
    }
  }

  // تغيير حالة اللايك
  Future<Post?> toggleLike(String postId) async {
    final url = Uri.parse('$baseUrl/$postId/like');
    final response = await http.post(url, headers: {
      'Authorization':
          LocalStorageService().getToken()!, // ارسال الـ Token للتوثيق
    });

    if (response.statusCode == 200) {
      print(response.body);
      Post post = Post(
        id: json.decode(response.body)['_id'],
        content: json.decode(response.body)['content'],
        user: User(
            id: json.decode(response.body)['user']['_id'],
            username: json.decode(response.body)['user']['username'],
            profilePicture: json.decode(response.body)['user']
                ['profilePicture']),
        hasLiked: json.decode(response.body)['hasLiked'],
        community: json.decode(response.body)['community'],
        createdAt: DateTime.parse(
            json.decode(response.body)['createdAt']), // تحويل النص إلى DateTime
        likesCount: json.decode(response.body)['likesCount'],
        comments: json.decode(response.body)['comments'],
        song: json.decode(response.body)['song'] != null &&
                json.decode(response.body)['song'] is Map<String, dynamic>
            ? Song.fromJson(json.decode(response.body)['song'])
            : null,
        episode: json.decode(response.body)['episode'] != null &&
                json.decode(response.body)['episode'] is Map<String, dynamic>
            ? Episode.fromJson(json.decode(response.body)['episode'])
            : null,
      );
      print("post.hasLiked");
      print(post.hasLiked);
      return post;
    } else {
      throw Exception('Failed to toggle like');
    }
  }

// تغيير حالة اللايك
  Future<Post?> getPostById(String postId) async {
    print("postId :${postId}");
    final url = Uri.parse('$baseUrl/post/$postId');
    final response = await http.get(url, headers: {
      'Authorization':
          LocalStorageService().getToken()!, // ارسال الـ Token للتوثيق
    });

    if (response.statusCode == 200) {
      print(response.body);
      Post post = Post(
        id: json.decode(response.body)['_id'],
        content: json.decode(response.body)['content'],
        hasLiked: json.decode(response.body)['hasLiked'],
        community: json.decode(response.body)['community'],
        likesCount: json.decode(response.body)['likesCount'],
        comments: json.decode(response.body)['comments'],
        song: json.decode(response.body)['song'] != null &&
                json.decode(response.body)['song'] is Map<String, dynamic>
            ? Song.fromJson(json.decode(response.body)['song'])
            : null,
        episode: json.decode(response.body)['episode'] != null &&
                json.decode(response.body)['episode'] is Map<String, dynamic>
            ? Episode.fromJson(json.decode(response.body)['episode'])
            : null,
        user: User(
            id: json.decode(response.body)['user']['_id'],
            username: json.decode(response.body)['user']['username'],
            profilePicture: json.decode(response.body)['user']
                ['profilePicture']),
        createdAt: DateTime.parse(
            json.decode(response.body)['createdAt']), // تحويل النص إلى DateTime
      );
      print("post.hasLiked");
      print(post.hasLiked);
      return post;
    } else {
      throw Exception('Failed to toggle like');
    }
  }
}
