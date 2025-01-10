import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:music_app/CustomWidgets/custom-scaffold.dart';
import 'package:music_app/Models/song_model.dart';
import 'package:music_app/Models/user_model.dart';
import 'package:music_app/ViewModels/search_view_model.dart';
import 'package:music_app/ViewModels/secret_gift_view_model.dart';

class SendGiftFromPF extends StatefulWidget {
  final User user;

  const SendGiftFromPF({
    required this.user,
    Key? key,
  }) : super(key: key);

  @override
  _SendGiftFromPFState createState() => _SendGiftFromPFState();
}

class _SendGiftFromPFState extends State<SendGiftFromPF> {
  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();
  SearchViewModel searchViewModel = SearchViewModel();

  List<Song> selectedSongs = [];

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      title: 'Send a Gift to ${widget.user.username}',
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(widget.user.profilePicture!),
                    radius: 30,
                  ),
                  SizedBox(width: 10),
                  Text(widget.user.username,
                      style: TextStyle(fontSize: 18, color: Colors.white)),
                ],
              ),
              SizedBox(height: 20),
              TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: "Search...",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.grey, width: 1),
                  ),
                ),
                // onTapOutside: (event) {
                //   searchViewModel.clearResults();
                //   _searchController.clear();
                // },
                onChanged: (query) {
                  if (query.isNotEmpty) {
                    searchViewModel.searchSongs(query);
                  } else {
                    searchViewModel.clearResults();
                  }
                },
              ),
              SizedBox(height: 10),
              Obx(() {
                if (searchViewModel.isLoading.value)
                  return CircularProgressIndicator();
                if (searchViewModel.errorMessage.value.isNotEmpty)
                  return Text(
                    searchViewModel.errorMessage.value,
                    style: TextStyle(color: Colors.white),
                  );

                return Column(children: [
                  ...List.generate(searchViewModel.songsGift.length, (index) {
                    final song = searchViewModel.songsGift[index];
                    return Container(
                      margin: EdgeInsets.all(5),
                      padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                      height: 80,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Color.fromARGB(44, 255, 255, 255),
                      ),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: Image.network(
                              song.img,
                              fit: BoxFit.cover,
                              height: 50,
                            ),
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                song.title,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                song.artist.name,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                          Spacer(),
                          if (selectedSongs.length < 3)
                            IconButton(
                              icon: Icon(
                                Icons.add,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                if (!selectedSongs
                                    .any((s) => s.id == song.id)) {
                                  setState(() {
                                    selectedSongs.add(song);
                                  });
                                }
                              },
                            )
                        ],
                      ),
                    );
                  })
                ]);
              }),
              Divider(),
              Text(
                'Selected Songs (max 3):',
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
              ),
              Wrap(
                children: selectedSongs
                    .map(
                      (song) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Chip(
                          padding: EdgeInsets.all(10),
                          label: Text(song.title),
                          onDeleted: () {
                            setState(() {
                              selectedSongs.remove(song);
                            });
                          },
                        ),
                      ),
                    )
                    .toList(),
              ),
              SizedBox(height: 10),
              TextField(
                controller: _messageController,
                maxLines: 2,
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
                inputFormatters: [
                  LengthLimitingTextInputFormatter(80),
                ],
                decoration: InputDecoration(
                  labelText: 'Write a message',
                  labelStyle: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                  fillColor: Colors.white.withOpacity(0.2),
                  filled: true,
                  border: InputBorder.none,
                ),
                onChanged: (text) {},
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _sendGift,
                child: Text('Send Gift'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _sendGift() async {
    if (selectedSongs.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(
          'Please select at least one song.',
          style: TextStyle(color: Colors.white),
        )),
      );
      return;
    }

    List<String> songsIds = selectedSongs.map((song) => song.id).toList();
    final content = _messageController.text;
    SecretGiftViewModel secretGiftViewModel = SecretGiftViewModel();
    await secretGiftViewModel.sendGift(widget.user.id, songsIds, content);

    if (secretGiftViewModel.errorMessage.value == "Gift sent successfully") {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.green,
          content: Text('Gift sent successfully!'),
        ),
      );
      Navigator.pop(context);
    } else {
      print("mes?: ${secretGiftViewModel.errorMessage.value}");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to send gift.')),
      );
    }
  }
}
