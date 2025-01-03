import 'package:flutter/material.dart';
import 'package:music_app/Models/post_model.dart';
import 'package:music_app/Views/navigation-bar-pages/communities/post_inside.dart';
import 'package:music_app/Views/players/music/musicPlayer.dart';
import 'package:music_app/Views/players/podcast/podcastPlayer.dart';
import 'package:music_app/providers/music_provider.dart';
import 'package:music_app/providers/podcast_provider.dart';
import 'package:provider/provider.dart';

class PostEpisodeWidget extends StatefulWidget {
  final Post post;

  const PostEpisodeWidget({Key? key, required this.post}) : super(key: key);

  @override
  State<PostEpisodeWidget> createState() => _PostEpisodeWidgetState();
}

class _PostEpisodeWidgetState extends State<PostEpisodeWidget> {
  @override
  Widget build(BuildContext context) {
    final musicProvider = Provider.of<MusicProvider>(context, listen: false);
    final podcastProvider =
        Provider.of<PodcastProvider>(context, listen: false);
    Post post = widget.post;

    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => PostPage(
                      post: post,
                    )));
      },
      child: Card(
        color: Colors.grey[900],
        margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Community name
              Text(
                post.community ?? "",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8.0),

              // User info
              Row(
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundImage: NetworkImage(post.user.profilePicture!),
                  ),
                  const SizedBox(width: 8.0),
                  Text(
                    post.user.username,
                    style: const TextStyle(color: Colors.white, fontSize: 16.0),
                  ),
                ],
              ),
              const SizedBox(height: 12.0),

              // Post content
              Text(
                post.content ?? "",
                style: const TextStyle(color: Colors.white, fontSize: 14.0),
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 16.0),

              post.song != null
                  ?
                  // Song info
                  InkWell(
                      onTap: () {
                        podcastProvider.stop();

                        musicProvider.setPlaylistAndSong(
                          [post.song!],
                          0, // الـ Index للأغنية
                        );
                        // استدعاء MusicPlayer كـ BottomSheet
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          builder: (context) {
                            return MusicPlayer(); // صفحة الـ MusicPlayer
                          },
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
                                  borderRadius: BorderRadius.circular(6.0),
                                  child: Image.network(
                                    post.song!.img,
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    post.song!.title,
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
                                    post.song!.artist.name,
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
                  // episode
                  : InkWell(
                      onTap: () {
                        musicProvider.stop();
                        podcastProvider.setEpisode(
                          post.episode!,
                        );
                        // استدعاء PodcastPlayer كـ BottomSheet
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          builder: (context) {
                            return PodcastPlayer(); // صفحة الـ MusicPlayer
                          },
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
                                  borderRadius: BorderRadius.circular(6.0),
                                  child: Image.network(
                                    post.episode!.podcast.img ?? "",
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    post.episode!.title,
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
                                    post.episode!.podcast.title,
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

              const SizedBox(height: 12.0),
              Align(
                alignment: Alignment.bottomRight,
                child: Row(
                  children: [
                    InkWell(
                      onTap: () {},
                      child: Icon(
                        Icons.favorite_border,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    InkWell(
                      onTap: () {},
                      child: Icon(
                        Icons.mode_comment_outlined,
                        color: Colors.white,
                        size: 28,
                      ),
                    ),
                    Spacer(),
                    Text(
                      '${post.createdAt.toLocal()}'.split(' ')[0] +
                          ' at ' +
                          '${post.createdAt.toLocal().hour}:${post.createdAt.toLocal().minute.toString().padLeft(2, '0')}',
                      style: const TextStyle(
                        color: Colors.white54,
                        fontSize: 12.0,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
