import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_app/Models/song_model.dart';
import 'package:music_app/ViewModels/playList_view_model.dart';
import 'package:music_app/utils/local_storage_service.dart';

class CustomSongCardPlayList extends StatefulWidget {
  final Song song;
  final void Function()? onTap;
  final void Function()? moreOnTap;
  final String? playListId;

  const CustomSongCardPlayList(
      {super.key,
      required this.song,
      required this.onTap,
      this.moreOnTap,
      this.playListId});

  @override
  State<CustomSongCardPlayList> createState() => _CustomSongCardPlayListState();
}

class _CustomSongCardPlayListState extends State<CustomSongCardPlayList> {
  @override
  Widget build(BuildContext context) {
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
            PopupMenuButton<String>(
              color: Colors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15), // جعل الحواف مستديرة
              ),
              // child: Container(color: Colors.white),
              iconSize: 36,
              icon: Icon(
                Icons.more_vert,
                color: Colors.white,
              ),
              onSelected: (value) async {
                if (value == 'Share Song') {
                  // مشاركة الأغنية
                  // shareSong(
                  //     song); // نفذ عملية المشاركة (يمكنك استخدام مكتبة مثل share_plus)
                } else if (value == 'Remove From PlayList') {
                  // Navigator.of(context).pop(); // اغلق الحوار وعد للميوزيك بلاير
                  if (widget.playListId != null) {
                    widget.moreOnTap!();
                  }
                }
              },
              itemBuilder: (context) => [
                PopupMenuItem(
                  value: 'Share Song',
                  child: Container(
                      margin: EdgeInsets.only(
                        top: 10,
                      ),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.white)),
                      width: MediaQuery.sizeOf(context).width,
                      padding: EdgeInsets.all(15),
                      child: Text(
                        'Share Song',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      )),
                ),
                widget.playListId != null
                    ? PopupMenuItem(
                        value: 'Remove From PlayList',
                        child: Container(
                            margin: EdgeInsets.only(top: 10, bottom: 10),
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.white)),
                            width: MediaQuery.sizeOf(context).width,
                            padding: EdgeInsets.all(15),
                            child: Text(
                              'Remove From PlayList',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            )),
                      )
                    : PopupMenuItem(
                        value: 'nth',
                        child: SizedBox(),
                      ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
