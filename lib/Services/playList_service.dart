import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:music_app/Models/playList_model.dart';

class PlaylistService {
  final String baseUrl =
      'https://music-app-server-1-h4hl.onrender.com/api/playlists';

  // // جلب البلاي ليستات العامة
  // Future<List<Playlist>> getPublicPlaylists() async {
  //   final response = await http.get(Uri.parse('$apiUrl/playlists/public'));

  //   if (response.statusCode == 200) {
  //     List<dynamic> data = json.decode(response.body);
  //     return data.map((item) => Playlist.fromJson(item)).toList();
  //   } else {
  //     throw Exception('Failed to load public playlists');
  //   }
  // }

  // // جلب بلاي ليستات المستخدم
  // Future<List<Playlist>> getUserPlaylists(String userId) async {
  //   final response =
  //       await http.get(Uri.parse('$apiUrl/playlists/user/$userId'));

  //   if (response.statusCode == 200) {
  //     List<dynamic> data = json.decode(response.body);
  //     return data.map((item) => Playlist.fromJson(item)).toList();
  //   } else {
  //     throw Exception('Failed to load user playlists');
  //   }
  // }

  // جلب بلاي ليستات اليوزر
  Future<List<dynamic>> getUserPlaylists({
    required String token,
  }) async {
    debugPrint("getUserPlaylists");

    final response = await http.get(Uri.parse(baseUrl), headers: {
      'Authorization': token,
      'Content-Type': 'application/json',
    });

    if (response.statusCode == 200) {
      // final List<dynamic> playlistsJson = json.decode(response.body);
      print("Response playlistsJson: ${response.body}");

      return json.decode(response.body);
      // playlistsJson.map((json) => Playlist.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load user playlists');
    }
  }

  // إنشاء بلاي ليست جديدة
  Future<Playlist> createPlaylist({
    required token,
    required String playListName,
    bool? isPublic,
    bool? allowEditing,
  }) async {
    final response = await http.post(
      Uri.parse('$baseUrl/create'),
      headers: {'Authorization': token, 'Content-Type': 'application/json'},
      body: json.encode({
        "name": playListName,
        "isPublic": isPublic ?? true,
        "allowEditing": allowEditing ?? false
      }),
    );

    if (response.statusCode == 201) {
      return Playlist.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to create playlist');
    }
  }

  // حذف بلاي ليست
  Future<void> deletePlaylist(String playlistId, token) async {
    final response = await http.delete(Uri.parse('$baseUrl/delete'), headers: {
      'Authorization': token,
      'Content-Type': 'application/json',
    }, body: {
      "playlistId": playlistId
    });

    if (response.statusCode != 200) {
      throw Exception('Failed to delete playlist');
    }
  }

  // إضافة أغنية إلى البلاي ليست
  Future<Playlist> addSongToPlaylist(
      String playlistId, String songId, token) async {
    print("addSongToPlaylist $songId");
    final headers = {
      'Authorization': "$token",
      'Content-Type': 'application/json',
    };
    final body = jsonEncode({
      'songId': songId,
    });

    final response = await http.put(
      Uri.parse('$baseUrl/$playlistId/add-song'),

      headers: headers,
      body: body, // تأكد من إرسال البيانات بشكل صحيح
    );

    if (response.statusCode == 200) {
      print(Playlist.fromJson(json.decode(response.body)).name);
      return Playlist.fromJson(json.decode(response.body));
    } else {
      throw Exception(
        'Failed to add song to playlist',
      );
    }
  }

  // حذف أغنية من البلاي ليست
  Future<Playlist> removeSongFromPlaylist(
      token, String playlistId, String songId) async {
    final headers = {
      'Authorization': "$token",
      'Content-Type': 'application/json',
    };
    final body = jsonEncode({
      'songId': songId,
    });

    final response = await http.put(
      Uri.parse('$baseUrl/$playlistId/remove-song'),

      headers: headers,
      body: body, // تأكد من إرسال البيانات بشكل صحيح
    );

    if (response.statusCode == 200) {
      return Playlist.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to remove song from playlist');
    }
  }
}
