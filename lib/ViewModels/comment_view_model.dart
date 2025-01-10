import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:music_app/Models/comment_model.dart';
import 'package:music_app/Services/comment_services.dart';
import 'package:music_app/Models/user_model.dart';

class CommentViewModel extends GetxController {
  var isLoading = false.obs; // حالة التحميل
  var comments = Rx<List<Comment>?>(null); // قائمة البوستات
  var errorMessage = ''.obs; // رسالة الخطأ

  final CommentService _commentService = CommentService();

  // جلب البوستات الخاصة بالكوميونيتي
  Future<void> getCommentsForPost(
    String postId,
  ) async {
    errorMessage.value = '';

    comments = Rx<List<Comment>?>(null);
    isLoading(true);
    try {
      final fetchedComments = await _commentService.getCommentsForPost(postId);
      print("comments: $fetchedComments");

      if (fetchedComments.isNotEmpty) {
        List<Comment> commentsList = [];
        for (var commentJson in fetchedComments) {
          Comment comment = Comment(
              id: commentJson['_id'],
              postId: commentJson['post'],
              user: User(
                  id: commentJson['user']['_id'],
                  username: commentJson['user']['username'],
                  profilePicture: commentJson['user']['profilePicture']),
              content: commentJson['content'],
              likesCount: commentJson['likesCount'],
              hasLiked: commentJson["hasLiked"]);

          // Comment comment = Comment.fromJson(commentJson);

          commentsList.add(comment);
        }
        comments.value = commentsList;

        debugPrint("Number of comment: ${comments.value?.length ?? 0}");
        debugPrint("Nugs: ${comments.value![0].content}");
      } else {
        errorMessage.value = 'No comments found for this post.';
      }
    } catch (error) {
      errorMessage.value = 'Error fetching comments: $error';
    } finally {
      isLoading(false);
    }
  }

// تغيير حالة اللايك
  Future<Comment> likeComment(String commentId) async {
    errorMessage.value = '';

    isLoading(true);
    try {
      // محاولة الحصول على التعليق المحدث من الخدمة
      final response = await _commentService.likeComment(commentId);

      // ignore: unnecessary_null_comparison
      if (response != null) {
        final updatedComment = response;

        // تحديث قائمة التعليقات إذا كانت موجودة
        if (comments.value != null) {
          comments.value = comments.value!.map((comment) {
            if (comment.id == updatedComment.id) {
              return updatedComment; // استبدال التعليق المحدث
            }
            return comment;
          }).toList();
        }

        return updatedComment; // إرجاع التعليق المحدث
      } else {
        // إذا لم يتم استرجاع تعليق جديد، إرجاع التعليق القديم
        final oldComment = comments.value?.firstWhere(
          (comment) => comment.id == commentId,
          orElse: () => throw Exception('Comment not found in local list'),
        );
        return oldComment!;
      }
    } catch (error) {
      errorMessage.value = 'Couldn\'t like comment: $error';

      // إرجاع التعليق القديم في حال وجود خطأ
      final oldComment = comments.value?.firstWhere(
        (comment) => comment.id == commentId,
        orElse: () => throw Exception('Comment not found in local list'),
      );
      return oldComment!;
    } finally {
      isLoading(false);
    }
  }

  // إضافة بوست جديد
  Future<void> addComment({
    required String postId,
    required String content,
  }) async {
    errorMessage.value = '';

    isLoading(true);
    try {
      // final newCommentResponse =
      await _commentService.addComment(content, postId);

      errorMessage.value = "Success";
    } catch (error) {
      print(error);
      errorMessage.value = 'Error adding comment: $error';
    } finally {
      // errorMessage.value = "";
      isLoading(false);
    }
  }

  bool get hasComments => comments.value != null && comments.value!.isNotEmpty;

  // عرض رسالة للمستخدم إذا لم تكن هناك بوستات
  String get displayMessage =>
      errorMessage.isNotEmpty ? errorMessage.value : "No comments.";
}
