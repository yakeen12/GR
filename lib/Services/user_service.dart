import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:music_app/Models/song_model.dart';
import 'package:music_app/Models/user_model.dart';

class UserService {
  final String baseUrl =
      'https://music-app-server-1-h4hl.onrender.com/api/users'; // الرابط الخاص بالخادم

  Future<Map<String, dynamic>> updateUser({
    required String token,
    required String name,
    required String email,
  }) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl/updateprofile'),
        headers: {
          'Authorization': token, // التوكن للمصادقة
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'name': name,
          'email': email,
        }),
      );
      print("$name $email");
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        return {
          'error': jsonDecode(response.body)['message'] ??
              'Failed to update profile',
        };
      }
    } catch (e) {
      return {'error': 'Error updating profile: $e'};
    }
  }

  // طلب بيانات المستخدم
  Future<User?> getUserProfile(String token) async {
    final response = await http.get(
      Uri.parse('$baseUrl/getprofile'),
      headers: {
        'Authorization': token, // إرسال التوكن في الهيدر
      },
    );
    print("response.body");

    print(response.body);
    if (response.statusCode == 200) {
      // إذا كانت الاستجابة ناجحة، قم بتحليل البيانات
      return User.fromJson(jsonDecode(response.body));
    } else {
      // إذا كانت الاستجابة فشلت، إرجاع null
      return null;
    }
  }

  Future<List<Song>> getUserLikes(String token) async {
    final response = await http.get(
      Uri.parse('$baseUrl/likes'),
      headers: {
        'Authorization': token, // إرسال التوكن في الهيدر
      },
    );
    // print("response.body");
    // print(response.body);
    final data = json.decode(response.body);

    if (response.statusCode == 200) {
      if (data['likedSongs'] is List) {
        print(data['likedSongs']);
        List<Song> songsList = [];
        for (var songJson in data['likedSongs']) {
          Song song = Song.fromJson(songJson);
          songsList.add(song); // إضافة الأغنية المحوّلة إلى القائمة
          // print("get likes song len:${songsList.length}");
        }
        return songsList;
      } else {
        throw Exception('Unexpected response format');
      }
    } else {
      throw Exception('Failed to load songs: ${response.statusCode}');
    }
  }

  Future<List<Song>> toggleLike(String songId, String token, bool like) async {
    print("toggleLike");

    final response = await http.post(
      Uri.parse('$baseUrl/like'),
      headers: {
        'Authorization': token,
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'songId': songId,
        'like': like,
      }),
    );
    print(response.body);
    final data = json.decode(response.body);

    if (response.statusCode == 200) {
      if (data['likedSongs'] is List) {
        // print(" Listtttt it is                              $data['songs']");

        // print("Type of data['songs']: ${data['songs'].runtimeType}");
        print(data['likedSongs']);
        List<Song> songsList = [];
        for (var songJson in data['likedSongs']) {
          Song song = Song.fromJson(songJson);
          songsList.add(song); // إضافة الأغنية المحوّلة إلى القائمة
        }
        return songsList;
      } else {
        throw Exception('Unexpected response format');
      }
    } else {
      throw Exception('Failed to load songs: ${response.statusCode}');
    }
  }
}
