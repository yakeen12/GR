import 'package:flutter/material.dart';
import 'package:music_app/CustomWidgets/custom-scaffold.dart';

class Communities extends StatelessWidget {
  const Communities({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      title: 'Communities',
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top Section for Community Categories
          SizedBox(
            height: 100,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                _buildCategoryCard('Love', Icons.self_improvement),
                _buildCategoryCard('Sad', Icons.palette),
                _buildCategoryCard('Happy', Icons.medical_services_rounded),
                _buildCategoryCard('Random', Icons.rate_review_sharp),
              ],
            ),
          ),

          // Tab Section
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Row(
              children: [
                Text('My feed',
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                SizedBox(width: 16),
              ],
            ),
          ),

          // Post Input Section

          const SizedBox(height: 14),

          // Post List Section
          Expanded(
            child: ListView(
              children: [
                _buildPostCard(
                  name: 'Aarav Sharma',
                  location: 'Bangalore, India',
                  community: 'Reiki Healing',
                  content:
                      '"The whole secret of existence lies in the pursuit of meaning, purpose, and connection. It is a delicate dance between self-discovery, compassion for others, and embracing the ever-unfolding mysteries of life."',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryCard(String title, IconData icon) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: const Color.fromARGB(255, 0, 0, 0),
            child: Icon(icon, color: const Color.fromARGB(255, 181, 16, 16)),
          ),
          const SizedBox(height: 8),
          Text(title, style: const TextStyle(fontSize: 11)),
        ],
      ),
    );
  }

  Widget _buildPostCard({
    required String name,
    required String location,
    required String community,
    required String content,
  }) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16)),
                    Text(location,
                        style: const TextStyle(color: Colors.grey, fontSize: 14)),
                  ],
                ),
                Text(community,
                    style: const TextStyle(
                        color: Colors.purple, fontWeight: FontWeight.bold)),
              ],
            ),
            const SizedBox(height: 8),
            Text(content, style: const TextStyle(fontSize: 14)),
          ],
        ),
      ),
    );
  }
}
