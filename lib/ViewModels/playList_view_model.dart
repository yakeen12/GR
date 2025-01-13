import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:music_app/Models/playList_model.dart';
import 'package:music_app/Services/playList_service.dart';

class PlaylistViewModel extends GetxController {
  final PlaylistService _playlistService = PlaylistService();

  var isLoading = false.obs;

  var playlists = <Playlist>[].obs;

  var errorMessage = ''.obs;

// جلب البلاي ليستات العامة
  Future<void> fetchPublicPlaylists(String userId) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      var response = await _playlistService.getPublicPlaylists(userId);

      if (response.isNotEmpty) {
        List<Playlist> playListsList = [];
        for (var playlistJson in response) {
          Playlist playlist = Playlist.fromJson(playlistJson);
          playListsList.add(playlist);
        }
        playlists.value = playListsList;

        isLoading.value = false;
      } else {
        playlists.value = [];

        isLoading.value = false;
        print("empty");
      }
    } catch (error) {
      isLoading.value = false;
      print(error);
      errorMessage.value = 'Error fetching user playlists: $error';
    }

    //   playlists = await _playlistService.getPublicPlaylists(userId);
    //   notifyListeners();
    // } catch (error) {
    //   print('Error fetching public playlists: $error');
    // }
  }

  // جلب البلاي ليستات المستخدم
  Future<void> fetchUserPlaylists(String token) async {
    debugPrint("fetchUserPlaylists");

    playlists = <Playlist>[].obs;

    try {
      isLoading.value = true;
      errorMessage.value = '';

      var response = await _playlistService.getUserPlaylists(token: token);
      print("hereeeeeeeeeeeeeeeeeeeeeeeeeeee::::::::::;; ${response}");
      if (response.isNotEmpty) {
        List<Playlist> playListsList = [];
        for (var playlistJson in response) {
          Playlist playlist = Playlist.fromJson(playlistJson);
          playListsList.add(playlist);
        }
        playlists.value = playListsList;
        isLoading.value = false;
      } else {
        print("empty");
      }
    } catch (error) {
      isLoading.value = false;
      print(error);
      errorMessage.value = 'Error fetching user playlists: $error';
    }
  }

  // إنشاء بلاي ليست جديدة
  Future<void> createPlaylist({
    required String token,
    required String playListName,
    bool? isPublic,
    bool? allowEditing,
  }) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final newPlaylist = await _playlistService.createPlaylist(
          playListName: playListName,
          token: token,
          allowEditing: allowEditing,
          isPublic: isPublic);
      print(newPlaylist);

      playlists.add(newPlaylist);
      isLoading.value = false;
    } catch (error) {
      isLoading.value = false;
      errorMessage.value = 'Error creating playlist: $error';
    }
  }

  // حذف بلاي ليست
  Future<void> deletePlaylist(String playlistId, String token) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      await _playlistService.deletePlaylist(playlistId, token);
      playlists.removeWhere(
          (playlist) => playlist.id == playlistId); // حذف البلاي ليست
      isLoading.value = false;
    } catch (error) {
      isLoading.value = false;
      errorMessage.value = 'Error deleting playlist: $error';
    }
  }

  // إضافة أغنية إلى البلاي ليست
  Future<void> addSongToPlaylist(
      String playlistId, String songId, String token) async {
    print("addSongToPlaylist MV $songId");

    try {
      isLoading.value = true;
      errorMessage.value = '';

      final updatedPlaylist =
          await _playlistService.addSongToPlaylist(playlistId, songId, token);
      print(updatedPlaylist.id);
      playlists.assignAll(playlists.map((playlist) {
        return playlist.id == updatedPlaylist.id ? updatedPlaylist : playlist;
      }).toList());
      isLoading.value = false; // إنهاء التحميل
    } catch (error) {
      isLoading.value = false;
      print(error);
      errorMessage.value = 'Error adding song to playlist: $error';
    }
  }

  // حذف أغنية من البلاي ليست
  Future<void> removeSongFromPlaylist(
      String playlistId, String songId, String token) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final updatedPlaylist = await _playlistService.removeSongFromPlaylist(
          token, playlistId, songId);
      playlists.assignAll(playlists.map((playlist) {
        return playlist.id == updatedPlaylist.id ? updatedPlaylist : playlist;
      }).toList());

      isLoading.value = false;
    } catch (error) {
      isLoading.value = false;
      errorMessage.value = 'Error removing song from playlist: $error';
    }
  }
}
