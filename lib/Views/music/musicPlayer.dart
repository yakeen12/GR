import 'package:flutter/material.dart';
import 'package:music_app/CustomWidgets/custom-scaffold.dart';

class MusicPlayer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      // backgroundColor: Colors.greenAccent.shade100, // Background color
      body: Center(
        child: Container(
          height: MediaQuery.sizeOf(context).height,
          // width: 300, // Adjust the width to match your design
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            // color: Colors.black,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 133),
              // Album Cover
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  color: Colors.grey,
                  height: 300,
                  width: double.infinity,
                  child: Center(
                    child: Text(
                      'Album Cover',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16),
              // Song Info
              Container(
                padding: EdgeInsets.symmetric(horizontal: 24),
                // color: Colors.amber,

                width: MediaQuery.sizeOf(context).width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Device',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Song Title - Lorem Ipsum',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Artist - Lorem Ipsum',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),
              // Progress Bar
              Column(
                children: [
                  Slider(
                    value: 0.3, // Current progress
                    onChanged: (value) {},
                    activeColor: Colors.white,
                    inactiveColor: Colors.grey,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '2:27',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                      ),
                      Text(
                        '-0:34',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 16),
              // Playback Controls
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Icon(Icons.shuffle, color: Colors.grey, size: 24),
                  Icon(Icons.skip_previous, color: Colors.white, size: 32),
                  Icon(Icons.play_circle_fill, color: Colors.white, size: 48),
                  Icon(Icons.skip_next, color: Colors.white, size: 32),
                  Icon(Icons.repeat, color: Colors.grey, size: 24),
                ],
              ),
              SizedBox(height: 16),
              // Devices Available
            ],
          ),
        ),
      ),
    );
  }
}
