import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:music_app/Models/song_model.dart';
import 'package:music_app/services/user_service.dart';
import 'package:music_app/Models/user_model.dart';

class UserViewModel extends GetxController {
  var isLoading = false.obs;
  var user = Rx<User?>(null);

  var errorMessage = ''.obs;

  var likedSongs = <Song?>[].obs;

  List<Song> get likedSongsList =>
      likedSongs.where((song) => song != null).cast<Song>().toList();

  // Method to fetch user profile from the server
  Future<void> fetchUserProfile(String token) async {
    isLoading(true);
    try {
      var response = await UserService().getUserProfile(token);
      if (response != null) {
        user.value = response;
      }
    } catch (e) {
      errorMessage.value = 'Error: $e';
      printError(info: "$e");
    } finally {
      isLoading(false);
    }
  }

  Future<void> updateUserProfile({
    required String token,
    required String name,
    required String email,
  }) async {
    isLoading(true);
    try {
      var response = await UserService().updateUser(
        token: token,
        name: name,
        email: email,
      );

      if (response.containsKey('error')) {
        errorMessage.value = response['error'];
      } else {
        errorMessage.value = '';
        // تحديث البيانات في التطبيق إذا كنت تخزنها
      }
    } catch (e) {
      errorMessage.value = 'Error: $e';
    } finally {
      isLoading(false);
    }
  }

  // Method to fetch liked songs
  Future<void> fetchLikedSongs(String token) async {
    isLoading(true); // بدء التحميل
    print("likedSongsssssssssssssssssssssssssssssssssssss $likedSongs");
    try {
      var response = await UserService().getUserLikes(token);
      if (response.isNotEmpty) {
        likedSongs.value = response;
        print(
            "likedSongsssssssssssssssssssssssssssssssssssss $likedSongs ${likedSongs}");
      } else {
        errorMessage.value = 'no songs';
      }
    } catch (e) {
      errorMessage.value = 'Error fetching liked songs: $e';
    } finally {
      isLoading(false);
    }
  }

  Future<void> toggleSongLike(String songId, String token, bool like) async {
    try {
      var response = await UserService().toggleLike(songId, token, like);
      if (response.isNotEmpty) {
        debugPrint("Number of songs: ${likedSongs.length}");
        // debugPrint("Nugs: ${likedSongs[0]!.title}");

        likedSongs.value = response;
        print("likedSongsssssssssssssssssssssssssssssssssssss $likedSongs");
      } else {
        errorMessage.value = 'no songs';
      }
    } catch (e) {
      print('Error toggling like: $e');
    }
  }
}
