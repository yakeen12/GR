import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_app/CustomWidgets/custom-scaffold.dart';
import 'package:music_app/ViewModels/playList_view_model.dart';
import 'package:music_app/utils/local_storage_service.dart';

class CreatePlaylist extends StatelessWidget {
  TextEditingController playListsNameController = TextEditingController();
  final PlaylistViewModel playlistViewModel = Get.put(PlaylistViewModel());
  final token = LocalStorageService().getToken();
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Give your playlist a name',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: playListsNameController,
                cursorColor: Colors.white,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 18),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Color.fromARGB(110, 91, 9, 9),
                  hintText: 'PlayLists name',
                  hintStyle: TextStyle(color: Colors.white),
                  border: InputBorder.none,
                ),
              ),
              SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      FocusScope.of(context).unfocus(); // إخفاء لوحة المفاتيح
                      Future.delayed(Duration(milliseconds: 200), () {
                        Navigator.pop(context);
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey[700],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding:
                          EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                    ),
                    child: Text(
                      'Cancel',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      final playlistName = playListsNameController.text;

                      if (playlistName.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: Text('Playlist name cannot be empty')),
                        );
                        return;
                      }

                      await playlistViewModel.createPlaylist(
                        token: token!,
                        playListName: playlistName,
                      );

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content: Text('Playlist created successfully!')),
                      );

                      FocusScope.of(context).unfocus(); // إخفاء لوحة المفاتيح
                      Future.delayed(Duration(milliseconds: 200), () {
                        Navigator.pop(context);
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 95, 14, 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding:
                          EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                    ),
                    child: Text(
                      'Create',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
