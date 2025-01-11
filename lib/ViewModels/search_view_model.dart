import 'package:get/get.dart';
import 'package:music_app/Models/artist_model.dart';
import 'package:music_app/Models/episode_model.dart';
import 'package:music_app/Models/playList_model.dart';
import 'package:music_app/Models/podcast_model.dart';
import 'package:music_app/Models/post_model.dart';
import 'package:music_app/Models/song_model.dart';
import 'package:music_app/Models/user_model.dart';
import 'package:music_app/Services/search_service.dart';

class SearchViewModel extends GetxController {
  var posts = <Post>[].obs;
  var songs = <Song>[].obs;
  var songsGift = <Song>[].obs;
  var episodes = <Episode>[].obs;
  var users = <User>[].obs;
  var artists = <Artist>[].obs;
  var podcasts = <Podcast>[].obs;

  // 4 playLists search
  var playLists = <Playlist>[].obs;
  var likedSongs = <Song>[].obs;
  var playlistSongs = <Song>[].obs;

//  عشان اعرف ازا في نتائج او لأ, وازا انمحت يختفي صندوق النتائج الذي بالهوم خلاااااصصصصصصصص يتم الانتحار
  bool get hasResults {
    return posts.isNotEmpty ||
        songs.isNotEmpty ||
        episodes.isNotEmpty ||
        users.isNotEmpty ||
        artists.isNotEmpty ||
        podcasts.isNotEmpty;
  }

  bool get hasSongs {
    return songsGift.isNotEmpty;
  }

  bool get playListsSearch {
    return likedSongs.isNotEmpty ||
        playLists.isNotEmpty ||
        playlistSongs.isNotEmpty;
  }

  final SearchService _searchService = SearchService();
  var isLoading = false.obs;
  var errorMessage = ''.obs;

  void search(String query) async {
    isLoading.value = true;
    try {
      var result = await _searchService.search(query);

      posts.assignAll((result['posts'] as List)
          .map((postJson) => Post.fromJson(postJson))
          .toList());

      songs.assignAll((result['songs'] as List)
          .map((songJson) => Song.fromJson(songJson))
          .toList());

      episodes.assignAll((result['episodes'] as List)
          .map((episodeJson) => Episode.fromJson(episodeJson))
          .toList());

      users.assignAll((result['users'] as List)
          .map((userJson) => User.fromJson(userJson))
          .toList());

      artists.assignAll((result['artists'] as List)
          .map((artistJson) => Artist.fromJson(artistJson))
          .toList());

      podcasts.assignAll((result['podcasts'] as List)
          .map((podcastJson) => Podcast.fromJson(podcastJson))
          .toList());
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  void searchInUsers(String query) async {
    isLoading.value = true;
    try {
      var res = await _searchService.searchUsers(query);

      users.assignAll((res['users'] as List)
          .map((userJson) => User.fromJson(userJson))
          .toList());
    } catch (error) {
      errorMessage.value = error.toString();
    } finally {
      isLoading.value = false;
    }
  }

  void searchInPlayLists(String query) async {
    isLoading.value = true;
    try {
      var result = await _searchService.searchInPlayLists(query);

      playlistSongs.assignAll((result['playlistSongs'] as List)
          .map((songJson) => Song.fromJson(songJson))
          .toList());

      likedSongs.assignAll((result['likedSongs'] as List)
          .map((songJson) => Song.fromJson(songJson))
          .toList());

      playLists.assignAll((result['playLists'] as List)
          .map((playListJson) => Playlist.fromJson(playListJson))
          .toList());
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  void searchSongs(String query) async {
    isLoading.value = true;
    try {
      var result = await _searchService.searchSongs(query);

      songsGift.assignAll((result['songs'] as List)
          .map((songJson) => Song.fromJson(songJson))
          .toList());
      print(songsGift);
    } catch (e) {
      errorMessage.value = e.toString();
      print(e);
    } finally {
      isLoading.value = false;
    }
  }

  //    خلص عاد زهقت من الشرح واضحة
  void clearResults() {
    posts.clear();
    songs.clear();
    episodes.clear();
    songsGift.clear();
    users.clear();
    artists.clear();
    podcasts.clear();
  }
}
