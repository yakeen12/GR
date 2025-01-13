import 'package:http/http.dart' as http;
import 'package:music_app/Models/comment_model.dart';
import 'package:music_app/Models/user_model.dart';
import 'dart:convert';

import 'package:music_app/utils/local_storage_service.dart';

class CommentService {
  final String baseUrl =
      'https://music-app-server-1-h4hl.onrender.com/api/comments'; // الرابط الخاص بالخادم

  Future<void> addComment(
    String content,
    String postId,
  ) async {
    print("${postId}, ${content} ${LocalStorageService().getToken()}");
    final url =
        Uri.parse('$baseUrl/add/$postId'); // تحديد رابط API الخاص بإضافة البوست
    final response = await http.post(url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization':
              LocalStorageService().getToken()!, // ارسال الـ Token للتوثيق
        },
        body: json.encode({
          'content': content,
        }));

    if (response.statusCode == 201) {
      // return Comment.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to add comment ${response.body}');
    }
  }

  Future<List<dynamic>> getCommentsForPost(
    String postId,
  ) async {
    final url = Uri.parse('$baseUrl/post/$postId');
    final response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Authorization':
          LocalStorageService().getToken()!, // ارسال الـ Token للتوثيق
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

  Future<Comment> likeComment(commentId) async {
    print(commentId);
    final url = Uri.parse('$baseUrl/like/$commentId');
    final response = await http.post(url, headers: {
      'Authorization':
          LocalStorageService().getToken()!, // ارسال الـ Token للتوثيق
    });

    if (response.statusCode == 200) {
      return Comment(
          id: json.decode(response.body)['_id'],
          postId: json.decode(response.body)['post'],
          user: User(
              id: json.decode(response.body)['user']['_id'],
              username: json.decode(response.body)['user']['username'],
              profilePicture: json.decode(response.body)['user']
                  ['profilePicture']),
          content: json.decode(response.body)['content'],
          likesCount: json.decode(response.body)['likesCount'],
          hasLiked: json.decode(response.body)["hasLiked"]);
    } else {
      throw Exception('Failed to fetch comment ${response.body}');
    }
  }
}
