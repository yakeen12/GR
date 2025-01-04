import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:music_app/Models/comment_model.dart';
import 'package:music_app/ViewModels/comment_view_model.dart';

class CommentWidget extends StatefulWidget {
  Comment comment;
  CommentWidget({super.key, required this.comment});

  @override
  State<CommentWidget> createState() => _CommentWidgetState();
}

class _CommentWidgetState extends State<CommentWidget> {
  CommentViewModel commentViewModel = CommentViewModel();
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: const Color.fromARGB(39, 255, 255, 255),
          borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  backgroundImage:
                      NetworkImage(widget.comment.user.profilePicture!),
                  radius: 15,
                ),
                SizedBox(width: 10),
                Text(widget.comment.user.username,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 16)),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 10,
                ),
                Text(widget.comment.content,
                    style: TextStyle(color: Colors.white)),
              ],
            ),
            SizedBox(height: 15),
            Row(
              children: [
                InkWell(
                  child: Icon(
                    widget.comment.hasLiked
                        ? Icons.favorite
                        : Icons.favorite_border_sharp,
                    color: widget.comment.hasLiked
                        ? const Color.fromARGB(255, 105, 22, 16)
                        : Colors.white,
                  ),
                  onTap: () async {
                    // إضافة لايك للكومنت
                    Comment newComment =
                        await commentViewModel.likeComment(widget.comment.id);
                    setState(() {
                      widget.comment = newComment;
                    });
                  },
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  '${widget.comment.likesCount} Likes',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                Spacer()
              ],
            ),
          ],
        ),
      ),
    );
  }
}
