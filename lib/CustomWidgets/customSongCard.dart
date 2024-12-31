import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_app/Models/song_model.dart';
import 'package:music_app/Views/music/musicPlayer.dart';
import 'package:music_app/providers/music_provider.dart';
import 'package:provider/provider.dart';

class CustomSongCardPlayList extends StatefulWidget {
  final Song song;
  final void Function()? onTap;

  const CustomSongCardPlayList({
    super.key,
    required this.song,
    required this.onTap,
  });

  @override
  State<CustomSongCardPlayList> createState() => _CustomSongCardPlayListState();
}

class _CustomSongCardPlayListState extends State<CustomSongCardPlayList> {
  @override
  Widget build(BuildContext context) {
    final musicProvider = Provider.of<MusicProvider>(context);

    return InkWell(
      onTap: widget.onTap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        child: Row(
          children: [
            // صورة البلاي ليست
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                widget.song.img,
                width: 70,
                height: 70,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: 10),
            Flex(direction: Axis.vertical, children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.song.title,
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 5),
                  Text(
                    widget.song.artist.name,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ]),
            Spacer(),
            IconButton(
              icon: Icon(
                Icons.more_vert,
                color: Colors.white,
              ),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
