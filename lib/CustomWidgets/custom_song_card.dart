import 'package:flutter/material.dart';

class CustomSongCard extends StatefulWidget {
  final String title;
  final String artist;
  final String imageUrl;
  const CustomSongCard(
      {super.key,
      required this.artist,
      required this.imageUrl,
      required this.title});
  @override
  State<CustomSongCard> createState() => _CustomSongCardState();
}

class _CustomSongCardState extends State<CustomSongCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      margin: const EdgeInsets.only(right: 15),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child:
                Image.network(widget.imageUrl, height: 150, fit: BoxFit.cover),
          ),
          const SizedBox(height: 8),
          Text(
            widget.title,
            style: const TextStyle(
                color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            widget.artist,
            style: const TextStyle(
                color: Colors.grey, fontSize: 12, fontWeight: FontWeight.bold),
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
