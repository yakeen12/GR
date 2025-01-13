import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:music_app/Services/episode_services.dart';
import 'package:music_app/Models/episode_model.dart';

class EpisodeViewModel extends GetxController {
  var isLoading = false.obs;
  var episodes = Rx<List<Episode>?>(null);

  var errorMessage = ''.obs;

  // Method to fetch user profile from the server
  Future<void> getAllEpisodes() async {
    isLoading(true);
    try {
      var response = await EpisodeService().fetchallEpisodes();
      print("meaw $response");
      if (response.isNotEmpty) {
        List<Episode> episodesList = [];
        for (var episodeJson in response) {
          Episode episode = Episode.fromJson(episodeJson);
          episodesList.add(episode);
        }
        episodes.value = episodesList;

        debugPrint("Number of episodes: ${episodes.value?.length ?? 0}");
        debugPrint("Nugs: ${episodes.value![0].title}");
      } else {
        errorMessage.value = 'Failed to load episodes.';
      }
      // print(response);
    } catch (e) {
      errorMessage.value = 'meaw: $e';
    } finally {
      isLoading(false);
    }
  }

  Future<void> getLatestepisodes() async {
    isLoading(true);
    try {
      var response = await EpisodeService().fetchLatestEpisodes();
      if (response.isNotEmpty) {
        List<Episode> episodesList = [];
        for (var episodeJson in response) {
          Episode episode = Episode.fromJson(episodeJson);
          episodesList.add(episode);
        }
        episodes.value = episodesList;

        debugPrint("Number of episodes: ${episodes.value?.length ?? 0}");
        debugPrint("Nugs: ${episodes.value![0].title}");
      } else {
        errorMessage.value = 'Failed to load episodes.';
      }
      // print(response);
    } catch (e) {
      errorMessage.value = 'meaw: $e';
    } finally {
      isLoading(false);
    }
  }

  bool get hasEpisodes => episodes.value != null && episodes.value!.isNotEmpty;

  String get displayMessage =>
      errorMessage.isNotEmpty ? errorMessage.value : "No episodes available.";
}
