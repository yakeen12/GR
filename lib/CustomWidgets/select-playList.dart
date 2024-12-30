import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_app/ViewModels/playList_view_model.dart';
import 'package:music_app/providers/music_provider.dart';
import 'package:music_app/utils/local_storage_service.dart';
import 'package:provider/provider.dart';

class PlaylistSelectionDialog extends StatefulWidget {
  final String songId;

  const PlaylistSelectionDialog({
    Key? key,
    required this.songId,
  }) : super(key: key);

  @override
  State<PlaylistSelectionDialog> createState() =>
      _PlaylistSelectionDialogState();
}

class _PlaylistSelectionDialogState extends State<PlaylistSelectionDialog> {
  String? selectedPlaylistId;
  late PlaylistViewModel playListViewModel;
  bool isDataFetched = false;

  @override
  void initState() {
    super.initState();
    playListViewModel = PlaylistViewModel();
    var token = LocalStorageService().getToken();
    if (token != null && !isDataFetched) {
      playListViewModel.fetchUserPlaylists(token);
    }
  }

  @override
  Widget build(BuildContext context) {
    final musicProvider = Provider.of<MusicProvider>(context, listen: false);

    return AlertDialog(
      backgroundColor: Colors.black,
      title: Text(
        'Select a Playlist',
        style: TextStyle(color: Colors.white),
      ),
      content: Container(
        width: double.maxFinite,
        height: 300,
        child: FutureBuilder(
          future: _loadPlaylistsIfNeeded(
              playListViewModel, LocalStorageService().getToken()!),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (playListViewModel.playlists.isEmpty) {
              return Center(
                  child: Text('You did not make any playlist yet :)',
                      style: TextStyle(color: Colors.white)));
            } else {
              return ListView.builder(
                itemCount: playListViewModel.playlists.length,
                itemBuilder: (context, index) {
                  final playlist = playListViewModel.playlists[index];
                  return InkWell(
                    onTap: () {
                      setState(() {
                        selectedPlaylistId = playlist.id;
                        print("selectedPlaylistId $selectedPlaylistId");
                      });
                    },
                    child: Container(
                      margin: EdgeInsets.only(bottom: 15),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.network(
                              (playlist.songs.isNotEmpty)
                                  ? playlist.songs.first.img
                                  : "https://www.tuaw.com/wp-content/uploads/2024/08/Apple-Music.jpg",
                              width: 70,
                              height: 70,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                playlist.name,
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: 5),
                              Text(
                                "${playlist.songs.length} songs",
                                style:
                                    TextStyle(fontSize: 14, color: Colors.grey),
                              ),
                            ],
                          ),
                          Spacer(),
                          Radio<String>(
                            activeColor: const Color.fromARGB(255, 149, 37, 29),
                            fillColor: MaterialStateProperty.all(Colors.white),
                            value: playlist.id,
                            groupValue: selectedPlaylistId,
                            onChanged: (value) {
                              setState(() {
                                selectedPlaylistId = value!;
                                print(selectedPlaylistId);
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // إغلاق الحوار بدون اختيار
          },
          child: Text('Cancel',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        ),
        selectedPlaylistId != null
            ? Container(
                margin: EdgeInsets.only(right: 10),
                child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.white)),
                  onPressed: () async {
                    // إذا اختار بلاي ليست
                    if (selectedPlaylistId != null) {
                      print(
                          "musicProvider.currentSongId ${musicProvider.currentSongId!}");
                      await playListViewModel.addSongToPlaylist(
                          selectedPlaylistId!,
                          musicProvider.currentSongId!,
                          LocalStorageService().getToken()!); // أرسل الطلب
                      print(playListViewModel.errorMessage.value);
                      if (!playListViewModel.isLoading.value) {
                        Navigator.of(context)
                            .pop(); // اغلق الحوار وعد للميوزيك بلاير
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Song added to playList')));
                        return;
                      }
                    }
                  },
                  child: Text(
                    'Done',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                ),
              )
            : SizedBox(),
      ],
    );
  }

  Future<void> _loadPlaylistsIfNeeded(
      PlaylistViewModel playListViewModel, String token) async {
    if (!isDataFetched) {
      // تأكد إذا لم تكن قد تم تحميل البيانات
      await playListViewModel.fetchUserPlaylists(token);
      isDataFetched = true; // البيانات تم تحميلها
    }
  }
}
