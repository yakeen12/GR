import 'package:get/get.dart';
import 'package:music_app/Models/secretGift_model.dart';
import 'package:music_app/Services/secret_gift_service.dart';

class SecretGiftViewModel extends GetxController {
  var isLoading = false.obs;
  var gifts = Rx<List<SecretGift>?>(null);

  var errorMessage = ''.obs;

  Future<void> sendGift(
    String receiverId,
    dynamic songList,
    String content,
  ) async {
    isLoading(true);
    try {
      var response = await SecretGiftService().sendGift(
        receiverId,
        songList,
        content,
      );

      if (response == true) {
        errorMessage.value = "Gift sent successfully";
      } else {
        errorMessage.value = 'Failed to send gift.';
      }
    } catch (e) {
      errorMessage.value = 'Error: $e';
    } finally {
      isLoading(false);
    }
  }

  // see all the gifts recieved
  Future<void> getGifts() async {
    isLoading(true);
    try {
      var response = await SecretGiftService().getGifts();
      print("meaw $response");

      if (response.isNotEmpty) {
        List<SecretGift> giftList = [];

        for (var giftJson in response) {
          try {
            SecretGift gift = SecretGift.fromJson(giftJson);
            giftList.add(gift);
          } catch (e) {
            print("Error parsing gift: $e");
          }
        }

        gifts.value = giftList;
      } else {
        errorMessage.value = 'Failed to load gifts.';
      }
      // print(response);
    } catch (e) {
      print(e);
      errorMessage.value = 'meaw: $e';
    } finally {
      isLoading(false);
    }
  }

  bool get hasGifts => gifts.value != null && gifts.value!.isNotEmpty;
}
