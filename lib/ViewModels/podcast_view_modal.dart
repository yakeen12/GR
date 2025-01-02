import 'package:get/get.dart';
import 'package:music_app/Models/artist_model.dart';
import 'package:music_app/Models/episode_model.dart';
import 'package:music_app/Models/podcast_model.dart';
import 'package:music_app/Services/artist_service.dart';
import 'package:music_app/Services/podcast_services.dart';

class PodcastViewModel extends GetxController {
  var isLoading = false.obs;
  var podcast = Rx<Podcast?>(null);

  var errorMessage = ''.obs;

  Future<void> fetchPodcastDetails(String podcastID) async {
    isLoading(true);
    try {
      var response = await PodcastService().getPodcastDetails(podcastID);
      if (response != null) {
        podcast.value = response;
        // podcast.value = Podcast(
        //     id: response.id,
        //     img: response.img,
        //     title: response.title,
        //     description: response.description,
        //     episodes: response.episodes != null
        //   ? List<Episode>.from(response.episodes!.map((x) => Episode.fromJson(x)))
        //   : [],
        //     host: response.host);
        print("podcast.value!.episodes![0]");

        print(podcast.value!.episodes![0]);
      } else {
        errorMessage.value = 'Failed to load Podcast.';
      }
    } catch (e) {
      errorMessage.value = 'Error: $e';
    } finally {
      isLoading(false);
    }
  }
}
