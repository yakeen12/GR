import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:music_app/Services/song_services.dart';
import 'package:music_app/Models/song_model.dart';

class SongViewModel extends GetxController {
  var isLoading = false.obs;
  var songs = Rx<List<Song>?>(null);

  var errorMessage = ''.obs;

  // Method to fetch user profile from the server
  Future<void> getAllSongs() async {
    isLoading(true);
    try {
      var response = await SongService().fetchallSongs();
      print("meaw $response");
      if (response.isNotEmpty) {
        List<Song> songsList = [];
        for (var songJson in response) {
          Song song = Song.fromJson(songJson);
          songsList.add(song);
        }
        songs.value = songsList;

        debugPrint("Number of songs: ${songs.value?.length ?? 0}");
        debugPrint("Nugs: ${songs.value![0].title}");
      } else {
        errorMessage.value = 'Failed to load songs.';
      }
      // print(response);
    } catch (e) {
      errorMessage.value = 'meaw: $e';
    } finally {
      isLoading(false);
    }
  }

  Future<void> getLatestSongs() async {
    isLoading(true);
    try {
      var response = await SongService().fetchLatestSongs();
      if (response.isNotEmpty) {
        List<Song> songsList = [];
        for (var songJson in response) {
          Song song = Song.fromJson(songJson);
          songsList.add(song);
        }
        songs.value = songsList;

        debugPrint("Number of songs: ${songs.value?.length ?? 0}");
        debugPrint("Nugs: ${songs.value![0].title}");
      } else {
        errorMessage.value = 'Failed to load songs.';
      }
      // print(response);
    } catch (e) {
      errorMessage.value = 'meaw: $e';
    } finally {
      isLoading(false);
    }
  }

  bool get hasSongs => songs.value != null && songs.value!.isNotEmpty;

  String get displayMessage =>
      errorMessage.isNotEmpty ? errorMessage.value : "No songs available.";
}
