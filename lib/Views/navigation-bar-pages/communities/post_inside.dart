import 'package:flutter/material.dart';
import 'package:music_app/CustomWidgets/custom-scaffold.dart';
import 'package:music_app/Models/post_model.dart';
import 'package:music_app/Views/players/music/musicPlayer.dart';
import 'package:music_app/Views/players/podcast/podcastPlayer.dart';
import 'package:music_app/providers/music_provider.dart';
import 'package:music_app/providers/podcast_provider.dart';
import 'package:provider/provider.dart';

class PostPage extends StatefulWidget {
  final Post post; // استلام البوست عبر الكونستراكتور

  PostPage({required this.post});

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  @override
  Widget build(BuildContext context) {
    final musicProvider = Provider.of<MusicProvider>(context, listen: false);
    final podcastProvider =
        Provider.of<PodcastProvider>(context, listen: false);
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
                      // 1. تفاصيل البوست (اسم اليوزر، الكوميونيتي، والتاريخ)
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
                              Text(widget.post.user.username,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white)),
                              Text(widget.post.community,
                                  style: TextStyle(color: Colors.grey)),
                              Text(widget.post.createdAt.toString(),
                                  style: TextStyle(color: Colors.grey)),
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
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 16),

                      //الساوند او الميديا
                      widget.post.song != null
                          ? InkWell(
                              onTap: () {
                                podcastProvider.stop();

                                musicProvider.setPlaylistAndSong(
                                  [widget.post.song!],
                                  0, // الـ Index للأغنية
                                );
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
                                          borderRadius:
                                              BorderRadius.circular(6.0),
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
                          : InkWell(
                              onTap: () {
                                musicProvider.stop();
                                podcastProvider.setEpisode(
                                  widget.post.episode!,
                                );
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
                                          borderRadius:
                                              BorderRadius.circular(6.0),
                                          child: Image.network(
                                            widget.post.episode!.podcast.img ??
                                                "",
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
                      SizedBox(
                        height: 20,
                      ),
                      // 3. عدد الإعجابات والتعليقات
                      Row(
                        children: [
                          Text('${widget.post.likes.length} Likes',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white)),
                          SizedBox(width: 16),
                          Text('${widget.post.comments.length} Comments',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white)),
                        ],
                      ),
                      SizedBox(height: 16),

                      // 4. حقل التعليق + زر الإرسال
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              cursorColor: Colors.white,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                              controller: TextEditingController(text: ""),
                              decoration: InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: const BorderSide(
                                      color: Colors.white, width: 2),
                                ),
                                hintStyle: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                                hintText: 'Write a comment...',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: const BorderSide(
                                      color: Colors.white, width: 1),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: const BorderSide(
                                      color: Colors.white, width: 1),
                                ),
                              ),
                            ),
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.send,
                              color: Colors.white,
                            ),
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // 5. التعليقات
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
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
                              backgroundImage: NetworkImage(
                                  "https://i0.wp.com/lovemultiverse.com/wp-content/uploads/2020/03/man-in-blue-and-brown-plaid-dress-shirt-touching-his-hair-897817-2.jpg?fit=1024%2C682&ssl=1"),
                              radius: 15,
                            ),
                            SizedBox(width: 10),
                            Text("User Name",
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
                            Text(
                                "I agree with your post! Very interesting perspectives shared.",
                                style: TextStyle(color: Colors.white)),
                          ],
                        ),
                        SizedBox(height: 15),
                        Row(
                          children: [
                            InkWell(
                              child: Icon(
                                Icons.favorite_border_sharp,
                                color: Colors.white,
                              ),
                              onTap: () {
                                // إضافة لايك للكومنت
                              },
                            ),

                            Text(
                              '200 Likes',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            // ${comment.likes.length}
                            Spacer()
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
              childCount: 20, // widget.post.comments.length,
            ),
          ),
        ],
      ),
    );
  }
}
