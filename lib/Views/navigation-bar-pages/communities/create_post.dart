import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:music_app/CustomWidgets/custom-Button.dart';
import 'package:music_app/CustomWidgets/custom-scaffold.dart';
import 'package:music_app/Models/episode_model.dart';
import 'package:music_app/Models/song_model.dart';
import 'package:music_app/ViewModels/post_view_model.dart';
import 'package:music_app/utils/local_storage_service.dart';

class CreatePostPage extends StatefulWidget {
  final Song? song;
  final Episode? episode;
  const CreatePostPage({Key? key, this.episode, this.song}) : super(key: key);

  @override
  _CreatePostPageState createState() => _CreatePostPageState();
}

class _CreatePostPageState extends State<CreatePostPage> {
  final TextEditingController _contentController = TextEditingController();
  String? selectedCommunity;

  // Dummy data for communities and songs
  final List<String> communities = ["Happy", "Sad", "Love"];

  @override
  void dispose() {
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    PostViewModel postViewModel = PostViewModel();

    return CustomScaffold(
      title: "Create Post",
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Community dropdown
              const Text(
                "Select Community",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              const SizedBox(height: 8),

              SizedBox(
                height: 10,
              ),
              // Submit button
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 150,
                    child: DropdownButtonFormField<String>(
                      dropdownColor: Colors.grey[900],
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey[800],
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.white, width: 1.5),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      value: selectedCommunity,
                      items: communities
                          .map((community) => DropdownMenuItem(
                                value: community,
                                child: Text(
                                  community,
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedCommunity = value;
                        });
                      },
                    ),
                  ),
                  SizedBox(
                    width: 120,
                    child: CustomButton(
                        onPressed: postViewModel.isLoading.value
                            ? null
                            : () {
                                if (selectedCommunity == null ||
                                    _contentController.text.isEmpty) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                          "Please fill in all required fields"),
                                      backgroundColor: Colors.red,
                                    ),
                                  );
                                  return;
                                } else {
                                  postViewModel.createPost(
                                      community: selectedCommunity!,
                                      content: _contentController.text,
                                      songId: widget.song?.id,
                                      episodeId: widget.episode?.id,
                                      token: LocalStorageService().getToken()!);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text(
                                            'your post has been created!')),
                                  );
                                  Navigator.pop(context);
                                }
                                // Handle post submission logic here
                                print("Community: $selectedCommunity");
                                print("Content: ${_contentController.text}");
                              },
                        text: postViewModel.isLoading.value
                            ? "Loading..."
                            : "Post"),
                  ),
                ],
              ),
              // Content input

              const SizedBox(height: 8),
              TextField(
                controller: _contentController,
                cursorColor: Colors.white,
                maxLines: 15,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey[800],
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide:
                        const BorderSide(color: Colors.white, width: 1.5),
                  ),
                  hintText: "Write your post here...",
                  hintStyle: const TextStyle(color: Colors.white54),
                ),
                style: const TextStyle(color: Colors.white),
              ),
              const SizedBox(height: 16),

              // Song dropdown

              const SizedBox(height: 8),
              // Song info
              Container(
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
                            widget.song != null
                                ? widget.song!.img
                                : widget.episode!.podcast.img,
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
                            widget.song != null
                                ? widget.song!.title
                                : widget.episode!.title,
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
                            widget.song != null
                                ? widget.song!.artist.name
                                : widget.episode!.podcast.title,
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
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
