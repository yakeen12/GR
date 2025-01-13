import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:music_app/Models/podcast_model.dart';

class PodcastService {
  final String baseUrl =
      'https://music-app-server-1-h4hl.onrender.com/api/podcasts'; // الرابط الخاص بالخادم

  // طلب بيانات المستخدم
  Future<Podcast?> getPodcastDetails(String podcastId) async {
    final response = await http.get(
      Uri.parse('$baseUrl/$podcastId'),
    );
    print("response.body");
    print(response.body);
    if (response.statusCode == 200) {
      // إذا كانت الاستجابة ناجحة، قم بتحليل البيانات
      return Podcast.fromJson(jsonDecode(response.body));
    } else {
      // إذا كانت الاستجابة فشلت، إرجاع null
      return null;
    }
  }
}
