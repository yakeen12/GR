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
              likes: postJson['likes'],
              comments: postJson['comments'],
              song: Song.fromJson(postJson['song']));
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
    isLoading(true);
    try {
      final fetchedPosts = await _postService.getAllPosts(token);
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
              likes: postJson['likes'],
              comments: postJson['comments'],
              song: Song.fromJson(postJson['song']));
          postsList.add(post);
        }
        posts.value = postsList;

        debugPrint("Number of posts: ${posts.value?.length ?? 0}");
        debugPrint("Nugs: ${posts.value![0].community}");
      } else {
        errorMessage.value = 'No posts available.';
      }
    } catch (error) {
      errorMessage.value = 'Error fetching all posts: $error';
    } finally {
      isLoading(false);
    }
  }

  // تغيير حالة اللايك
  Future<void> toggleLike(String postId, String token) async {
    isLoading(true);
    try {
      final response = await _postService.toggleLike(postId, token);
      final updatedPost = Post.fromJson(response);
      if (posts.value != null) {
        posts.value = posts.value!.map((post) {
          if (post.id == updatedPost.id) {
            return updatedPost;
          }
          return post;
        }).toList();
      }
    } catch (error) {
      errorMessage.value = 'Error toggling like: $error';
    } finally {
      isLoading(false);
    }
  }

  // إضافة بوست جديد
  Future<void> createPost(String community, String content, String? songId,
      String? episodeId, String token) async {
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
