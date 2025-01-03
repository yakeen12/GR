import 'package:flutter/material.dart';

class PostWidget extends StatelessWidget {
  final String communityName;
  final String userName;
  final String userAvatarUrl;
  final String content;
  final String songTitle;
  final String artistName;
  final String songCoverUrl;
  final DateTime createdAt;

  const PostWidget({
    Key? key,
    required this.communityName,
    required this.userName,
    required this.userAvatarUrl,
    required this.content,
    required this.songTitle,
    required this.artistName,
    required this.songCoverUrl,
    required this.createdAt,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey[900],
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Community name
            Text(
              communityName,
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
                  backgroundImage: NetworkImage(userAvatarUrl),
                ),
                const SizedBox(width: 8.0),
                Text(
                  userName,
                  style: const TextStyle(color: Colors.white, fontSize: 16.0),
                ),
              ],
            ),
            const SizedBox(height: 12.0),

            // Post content
            Text(
              content,
              style: const TextStyle(color: Colors.white, fontSize: 14.0),
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 16.0),

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
                          songCoverUrl,
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
                          songTitle,
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
                          artistName,
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

            // Created at (Date and Time)
            const SizedBox(height: 12.0),
            Align(
              alignment: Alignment.bottomRight,
              child: Text(
                '${createdAt.toLocal()}'.split(' ')[0] +
                    ' at ' +
                    '${createdAt.toLocal().hour}:${createdAt.toLocal().minute.toString().padLeft(2, '0')}',
                style: const TextStyle(
                  color: Colors.white54,
                  fontSize: 12.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
