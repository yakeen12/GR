import 'package:flutter/material.dart';

class Gift extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // User ID Section
            Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundImage:
                      AssetImage('assets/user.jpg'), // Replace with your image
                ),
                SizedBox(width: 10),
                Text(
                  '@user Id',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),

            // Song Details Section
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: AssetImage(
                        'assets/song.jpg'), // Replace with your image
                  ),
                  SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '@Song Name',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text('@song Artist'),
                      Text('@Song Time'),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),

            // Message Box Section
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(12),
              ),
              child: TextField(
                maxLength: 200,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'type your message here',
                  counterText: '0/200',
                ),
              ),
            ),
            SizedBox(height: 20),

            // Dropdown and Buttons Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: '@chosse comunity', // Default value
                        items: [
                          DropdownMenuItem(
                            value: '@chosse comunity',
                            child: Text('@chosse comunity'),
                          ),
                          DropdownMenuItem(
                            value: '@option 1',
                            child: Text('@option 1'),
                          ),
                        ],
                        onChanged: (value) {},
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    primary: Colors.grey[300],
                    onPrimary: Colors.black,
                  ),
                  child: Text('Send'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
