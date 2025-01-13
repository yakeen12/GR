import 'dart:convert';

import 'package:music_app/Models/artist_model.dart';
import 'package:http/http.dart' as http;

class ArtistService {
  final String baseUrl =
      'https://music-app-server-1-h4hl.onrender.com/api/artists';

  // طلب بيانات المستخدم
  Future<Artist?> getArtistProfile(String artistId) async {
    final response = await http.get(
      Uri.parse('$baseUrl/$artistId'),
    );
    print("response.body");
    print(response.body);
    if (response.statusCode == 200) {
      // إذا كانت الاستجابة ناجحة، قم بتحليل البيانات
      return Artist.fromJson(jsonDecode(response.body));
    } else {
      // إذا كانت الاستجابة فشلت، إرجاع null
      return null;
    }
  }
}
