import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:music_app/ViewModels/user_view_model.dart';

class LikeButton extends StatelessWidget {
  final String songId;
  final UserViewModel userViewModel;
  final String token; // التوكين الخاص بالمستخدم

  LikeButton(
      {required this.songId, required this.userViewModel, required this.token});

  @override
  Widget build(BuildContext context) {
    // final isLiked = userViewModel.likedSongsList.any((s) => s.id == songId);
    return Obx(() {
      return InkWell(
        child: Icon(
          userViewModel.likedSongsList.any((s) => s.id == songId)
              ? Icons.favorite
              : Icons.favorite_border,
          color: userViewModel.likedSongsList.any((s) => s.id == songId)
              ? Colors.white
              : Colors.grey,
          size: 35,
        ),
        onTap: () async {
          // عكس حالة الإعجاب
          final newLikeState =
              !userViewModel.likedSongsList.any((s) => s.id == songId);
          await userViewModel.toggleSongLike(songId, token, newLikeState);
        },
      );
    });
  }
}
