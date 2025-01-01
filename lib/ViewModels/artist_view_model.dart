import 'package:get/get.dart';
import 'package:music_app/Models/artist_model.dart';
import 'package:music_app/Services/artist_service.dart';

class ArtistsViewModel extends GetxController {
  var isLoading = false.obs;
  var artist = Rx<Artist?>(null);

  var errorMessage = ''.obs;

  Future<void> fetchArtistProfile(String artistID) async {
    isLoading(true);
    try {
      var response = await ArtistService().getArtistProfile(artistID);
      if (response != null) {
        artist.value = Artist(
            id: response.id,
            name: response.name,
            image: response.image,
            songs: response.songs);
            
      } else {
        errorMessage.value = 'Failed to load profile.';
      }
    } catch (e) {
      errorMessage.value = 'Error: $e';
    } finally {
      isLoading(false);
    }
  }
}
