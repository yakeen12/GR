import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:music_app/Models/artist_model.dart';
import 'package:music_app/Models/episode_model.dart';
import 'package:music_app/Models/post_model.dart';
import 'package:music_app/Models/song_model.dart';
import 'package:music_app/Services/post_services.dart';
import 'package:music_app/models/user_model.dart';

class PostViewModel extends GetxController {
  var isLoading = false.obs; // حالة التحميل
  var posts = Rx<List<Post>?>(null); // قائمة البوستات
  var errorMessage = ''.obs; // رسالة الخطأ

  final PostService _postService = PostService();

  // جلب البوستات الخاصة بالكوميونيتي
  Future<void> getPostsByCommunity(String communityName, String token) async {
    errorMessage.value = '';

    posts = Rx<List<Post>?>(null);
    isLoading(true);
    try {
      final fetchedPosts =
          await _postService.getPostsByCommunity(communityName, token);
      print("POOOOOOOOOSTSSSS: $fetchedPosts");
      if (fetchedPosts.isNotEmpty) {
        List<Post> postsList = [];
        for (var postJson in fetchedPosts) {
          Post post = Post(
            id: postJson['_id'],
            content: postJson['content'],
            user: User(
                id: postJson['user']['_id'],
                username: postJson['user']['username'],
                profilePicture: postJson['user']['profilePicture']),
            hasLiked: postJson['hasLiked'],
            community: postJson['community'],
            createdAt: DateTime.parse(
                postJson['createdAt']), // تحويل النص إلى DateTime
            likesCount: postJson['likesCount'],
            comments: postJson['comments'],
            song: postJson['song'] != null &&
                    postJson['song'] is Map<String, dynamic>
                ? Song.fromJson(postJson['song'])
                : null,
            episode: postJson['episode'] != null &&
                    postJson['episode'] is Map<String, dynamic>
                ? Episode.fromJson(postJson['episode'])
                : null,
          );
          postsList.add(post);
        }
        posts.value = postsList;

        debugPrint("Number of posts: ${posts.value?.length ?? 0}");
        debugPrint("Nugs: ${posts.value![0].community}");
      } else {
        errorMessage.value = 'No posts found for this community.';
      }
    } catch (error) {
      errorMessage.value = 'Error fetching posts: $error';
    } finally {
      isLoading(false);
    }
  }

  // جلب جميع البوستات
  Future<void> getAllPosts(String token) async {
    print(token);
    errorMessage.value = '';
    posts = Rx<List<Post>?>(null);

    isLoading(true);
    try {
      final fetchedPosts = await _postService.getAllPosts(token);
      if (fetchedPosts.isNotEmpty) {
        List<Post> postsList = [];
        for (var postJson in fetchedPosts) {
          // "song: ${postJson['song'] != null} && ${postJson['song'] is Map}");
          // print("${Song.fromJson(postJson['song'])}");
          // print(
          //     "episode: ${postJson['episode'] != null} && ${postJson['episode'] is Map}");
          // print("${Episode.fromJson(postJson['episode'])}");

          Post post = Post(
            id: postJson['_id'],
            content: postJson['content'],
            user: User(
                id: postJson['user']['_id'],
                username: postJson['user']['username'],
                profilePicture: postJson['user']['profilePicture']),
            hasLiked: postJson['hasLiked'],
            community: postJson['community'],
            createdAt: DateTime.parse(
                postJson['createdAt']), // تحويل النص إلى DateTime
            likesCount: postJson['likesCount'],
            comments: postJson['comments'],
            song: postJson['song'] != null &&
                    postJson['song'] is Map<String, dynamic>
                ? Song.fromJson(postJson['song'])
                : null,
            episode: postJson['episode'] != null &&
                    postJson['episode'] is Map<String, dynamic>
                ? Episode.fromJson(postJson['episode'])
                : null,
          );
          print(post.community);
          postsList.add(post);
        }
        posts.value = postsList;

        debugPrint("Number of posts: ${posts.value?.length ?? 0}");
        debugPrint("Nugs: ${posts.value![0].community}");
      } else {
        errorMessage.value = 'No posts available.';
      }
    } catch (error) {
      printError(info: error.toString());
      print(error);
      errorMessage.value = 'Error fetching all posts: $error';
    } finally {
      isLoading(false);
    }
  }

  // تغيير حالة اللايك
  Future<Post> toggleLike(String postId) async {
    errorMessage.value = ''; // مسح رسالة الخطأ السابقة

    isLoading(true); // تشغيل مؤشر التحميل
    try {
      final updatedPost =
          await _postService.toggleLike(postId); // طلب من الخدمة

      if (updatedPost != null) {
        // تحديث البوست في القائمة إذا تم إرجاع بوست جديد
        if (posts.value != null) {
          posts.value = posts.value!.map((post) {
            if (post.id == updatedPost.id) {
              return updatedPost;
            }
            return post;
          }).toList();
        }
        return updatedPost; // إعادة البوست المحدث
      } else {
        // إذا لم يتم إرجاع بوست محدث، إعادة البوست القديم من القائمة
        final oldPost = posts.value?.firstWhere((post) => post.id == postId,
            orElse: () => throw Exception("Post not found"));
        return oldPost!;
      }
    } catch (error) {
      // إذا حدث خطأ أثناء الطلب
      errorMessage.value = 'Error toggling like: $error';

      // إعادة البوست القديم من القائمة في حال الخطأ
      final oldPost = posts.value?.firstWhere((post) => post.id == postId,
          orElse: () => throw Exception("Post not found"));
      return oldPost!;
    } finally {
      isLoading(false); // إيقاف مؤشر التحميل
    }
  }

  // by post ID
  Future<Post> getPostById(String postId) async {
    errorMessage.value = ''; // مسح رسالة الخطأ السابقة

    isLoading(true); // تشغيل مؤشر التحميل
    try {
      final updatedPost =
          await _postService.getPostById(postId); // طلب من الخدمة

      if (updatedPost != null) {
        // تحديث البوست في القائمة إذا تم إرجاع بوست جديد
        if (posts.value != null) {
          posts.value = posts.value!.map((post) {
            if (post.id == updatedPost.id) {
              return updatedPost;
            }
            return post;
          }).toList();
        }
        return updatedPost; // إعادة البوست المحدث
      } else {
        // إذا لم يتم إرجاع بوست محدث، إعادة البوست القديم من القائمة
        final oldPost = posts.value?.firstWhere((post) => post.id == postId,
            orElse: () => throw Exception("Post not found"));
        return oldPost!;
      }
    } catch (error) {
      // إذا حدث خطأ أثناء الطلب
      errorMessage.value = 'Error commenting bruh: $error';

      // إعادة البوست القديم من القائمة في حال الخطأ
      final oldPost = posts.value?.firstWhere((post) => post.id == postId,
          orElse: () => throw Exception("Post not found"));
      return oldPost!;
    } finally {
      isLoading(false); // إيقاف مؤشر التحميل
    }
  }

  // إضافة بوست جديد
  Future<void> createPost(
      {required String community,
      required String content,
      String? songId,
      String? episodeId,
      required String token}) async {
    errorMessage.value = '';

    isLoading(true);
    try {
      final newPostResponse = await _postService.createPost(
          community, content, songId, episodeId, token);
      // final newPost = Post.fromJson(newPostResponse);
      if (posts.value == null) {
        // posts.value = [newPost];
      } else {
        // posts.value = [...posts.value!, newPost];
      }
    } catch (error) {
      errorMessage.value = 'Error creating post: $error';
    } finally {
      isLoading(false);
    }
  }

  bool get hasPosts => posts.value != null && posts.value!.isNotEmpty;

  // عرض رسالة للمستخدم إذا لم تكن هناك بوستات
  String get displayMessage =>
      errorMessage.isNotEmpty ? errorMessage.value : "No posts available.";
}
