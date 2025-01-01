import 'package:flutter/material.dart';

class Gift extends StatelessWidget {
  const Gift({super.key});

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
            const Row(
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
            const SizedBox(height: 20),

            // Song Details Section
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Row(
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
            const SizedBox(height: 20),

            // Message Box Section
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(12),
              ),
              child: const TextField(
                maxLength: 200,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'type your message here',
                  counterText: '0/200',
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Dropdown and Buttons Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: '@chosse comunity', // Default value
                        items: const [
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
                const SizedBox(width: 10),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.black,
                    backgroundColor: Colors.grey[300],
                  ),
                  child: const Text('Send'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
