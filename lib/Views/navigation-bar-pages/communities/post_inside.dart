import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_app/CustomWidgets/comment_widget.dart';
import 'package:music_app/CustomWidgets/custom-scaffold.dart';
import 'package:music_app/Models/post_model.dart';
import 'package:music_app/ViewModels/comment_view_model.dart';
import 'package:music_app/ViewModels/post_view_model.dart';
import 'package:music_app/providers/music_provider.dart';
import 'package:music_app/providers/podcast_provider.dart';
import 'package:provider/provider.dart';

class PostPage extends StatefulWidget {
  Post post; // استلام البوست عبر الكونستراكتور

  PostPage({required this.post});

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  @override
  Widget build(BuildContext context) {
    CommentViewModel commentViewModel = CommentViewModel();
    commentViewModel.getCommentsForPost(widget.post.id);
    final musicProvider = Provider.of<MusicProvider>(context, listen: false);
    final podcastProvider =
        Provider.of<PodcastProvider>(context, listen: false);
    TextEditingController _commentController = TextEditingController();
    PostViewModel postViewModel = PostViewModel();

    return CustomScaffold(
      title: "",
      body: CustomScrollView(
        slivers: [
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // 1. تفاصيل البوست
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundImage:
                                NetworkImage(widget.post.user.profilePicture!),
                            radius: 20,
                          ),
                          SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.post.user.username,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                widget.post.community,
                                style: TextStyle(color: Colors.grey),
                              ),
                              Text(
                                '${widget.post.createdAt.toLocal()}'
                                        .split(' ')[0] +
                                    ' at ' +
                                    '${widget.post.createdAt.toLocal().hour}:${widget.post.createdAt.toLocal().minute.toString().padLeft(2, '0')}',
                                style: TextStyle(color: Colors.grey),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 16),

                      // 2. النص الكامل للبوست
                      Text(
                        widget.post.content,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 16),

                      // الساوند أو الميديا
                      if (widget.post.song != null)
                        InkWell(
                          onTap: () {
                            podcastProvider.stop();
                            musicProvider
                                .setPlaylistAndSong([widget.post.song!], 0);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.grey[850],
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                // Song cover with play button
                                Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(6.0),
                                      child: Image.network(
                                        widget.post.song!.img,
                                        height: 60,
                                        width: 60,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    const Icon(
                                      Icons.play_circle_fill,
                                      color: Colors.white,
                                      size: 30.0,
                                    ),
                                  ],
                                ),
                                const SizedBox(width: 12.0),

                                // Song title and artist
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        widget.post.song!.title,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      const SizedBox(height: 4.0),
                                      Text(
                                        widget.post.song!.artist.name,
                                        style: const TextStyle(
                                          color: Colors.white54,
                                          fontSize: 12.0,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      else if (widget.post.episode != null)
                        InkWell(
                          onTap: () {
                            musicProvider.stop();
                            podcastProvider.setEpisode(widget.post.episode!);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.grey[850],
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                // Podcast cover with play button
                                Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(6.0),
                                      child: Image.network(
                                        widget.post.episode!.podcast.img,
                                        height: 60,
                                        width: 60,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    const Icon(
                                      Icons.play_circle_fill,
                                      color: Colors.white,
                                      size: 30.0,
                                    ),
                                  ],
                                ),
                                const SizedBox(width: 12.0),

                                // Podcast title and name
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        widget.post.episode!.title,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      const SizedBox(height: 4.0),
                                      Text(
                                        widget.post.episode!.podcast.title,
                                        style: const TextStyle(
                                          color: Colors.white54,
                                          fontSize: 12.0,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                      SizedBox(height: 20),

                      // 3. عدد الإعجابات والتعليقات
                      Row(
                        children: [
                          Text(
                            '${widget.post.likesCount} Likes',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(width: 16),
                          Text(
                            '${widget.post.comments.length} Comments',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Spacer(),
                          InkWell(
                            onTap: postViewModel.isLoading.value
                                ? null
                                : () async {
                                    //// like post

                                    Post post = await postViewModel
                                        .toggleLike(widget.post.id);
                                    setState(() {
                                      widget.post = post;
                                    });
                                  },
                            child: Icon(
                              widget.post.hasLiked
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: widget.post.hasLiked
                                  ? const Color.fromARGB(255, 119, 19, 12)
                                  : Colors.white,
                              size: 30,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16),

                      // 4. حقل التعليق + زر الإرسال
                      Obx(() {
                        return Column(
                          children: [
                            if (commentViewModel.isLoading.value)
                              LinearProgressIndicator(
                                backgroundColor: Colors.grey[800],
                                color: Colors.white,
                                minHeight: 4,
                              ),
                            Row(
                              children: [
                                Expanded(
                                  child: TextField(
                                    controller: _commentController,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                    decoration: InputDecoration(
                                      hintText: 'Write a comment...',
                                      hintStyle: TextStyle(color: Colors.grey),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.white),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 8),
                                IconButton(
                                  icon: Icon(Icons.send, color: Colors.white),
                                  onPressed: commentViewModel.isLoading.value
                                      ? null
                                      : () async {
                                          if (_commentController
                                              .text.isNotEmpty) {
                                            await commentViewModel.addComment(
                                              postId: widget.post.id,
                                              content: _commentController.text,
                                            );

                                            Post post = await postViewModel
                                                .getPostById(widget.post.id);
                                            setState(() {
                                              widget.post = post;
                                            });
                                          }
                                        },
                                ),
                              ],
                            ),
                          ],
                        );
                      }),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // // 5. التعليقات
          // تغليف Obx بـ SliverToBoxAdapter
          SliverToBoxAdapter(
            child: Obx(() {
              if (commentViewModel.isLoading.value) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                );
              }
              // else if (commentViewModel.errorMessage.isNotEmpty) {
              //   return Center(
              //     child: SizedBox(
              //       width: 400,
              //       child: Text(
              //         commentViewModel.errorMessage.value,
              //         style: TextStyle(
              //             color: Colors.white,
              //             fontSize: 20,
              //             fontWeight: FontWeight.bold),
              //       ),
              //     ),
              //   );
              // }
              return ListView.builder(
                shrinkWrap: true,
                physics:
                    NeverScrollableScrollPhysics(), // السماح بالتمرير داخل CustomScrollView
                itemCount: (commentViewModel.hasComments)
                    ? commentViewModel.comments.value!.length
                    : 0,
                itemBuilder: (context, index) {
                  var comment = commentViewModel.comments.value![index];
                  return CommentWidget(
                    comment: comment,
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}
