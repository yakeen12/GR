import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_app/CustomWidgets/custom-scaffold.dart';
import 'package:music_app/ViewModels/podcast_view_modal.dart';
import 'package:music_app/Views/players/podcast/podcastPlayer.dart';
import 'package:music_app/providers/music_provider.dart';
import 'package:music_app/providers/podcast_provider.dart';
import 'package:provider/provider.dart';

class PodcastPage extends StatefulWidget {
  final String podcastID;

  PodcastPage({super.key, required this.podcastID});

  @override
  State<PodcastPage> createState() => _PodcastPageState();
}

class _PodcastPageState extends State<PodcastPage> {
  final PodcastViewModel podcastViewModel = PodcastViewModel();

  @override
  Widget build(BuildContext context) {
    final MusicProvider musicProvider =
        Provider.of<MusicProvider>(context, listen: false);
    final PodcastProvider podcastProvider =
        Provider.of<PodcastProvider>(context, listen: false);

    podcastViewModel.fetchPodcastDetails(widget.podcastID);
    return CustomScaffold(
      title: "",
      showNowPlaying: true,
      body: Obx(() {
        if (podcastViewModel.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        } else if (podcastViewModel.errorMessage.isNotEmpty) {
          return Text(
            '${podcastViewModel.errorMessage}',
            style: TextStyle(color: Colors.white),
          );
        } else {
          var podcast = podcastViewModel.podcast.value!;
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: MediaQuery.sizeOf(context).width,
                  child: Row(
                    children: [
                      Image.network(
                        podcast.img,
                        height: 120,
                        // width: 70,
                      ),
                      SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 170,
                            child: Text(
                              podcast.title,
                              maxLines: 3,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(height: 5),
                          SizedBox(
                            width: 170,
                            child: Text(
                              podcast.host!,
                              maxLines: 3,
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 14),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 50),
                Text(
                  'Episodes:',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: podcast.episodes!.length,
                    itemBuilder: (context, index) {
                      var episode = podcast.episodes![index];
                      return InkWell(
                        onTap: () {
                          musicProvider.stop();
                          podcastProvider.setEpisode(
                            episode,
                          );
                        },
                        child: Container(
                            padding: EdgeInsets.all(15),
                            margin: EdgeInsets.symmetric(vertical: 10),
                            width: MediaQuery.sizeOf(context).width,
                            decoration: BoxDecoration(
                              color: Color.fromARGB(35, 255, 255, 255),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Column(
                              children: [
                                Text(
                                  '${episode.episodeNumber} ${episode.title}',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  episode.description,
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 14),
                                ),
                              ],
                            )),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        }
      }),
    );
  }
}
