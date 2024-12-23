import 'package:flutter/material.dart';
import 'package:music_app/CustomWidgets/custom-scaffold.dart';

class Me extends StatefulWidget {
  @override
  State<Me> createState() => _MeState();
}

class _MeState extends State<Me> {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: Column(
        children: [
          // Add a SizedBox to push the image lower from the top
          SizedBox(height: 70), // Adjust this value to control how far the image is from the top
          
          SizedBox(
            width: 150, // Set the width of the container
            height: 150, // Set the height of the container
            child: Container(
              width: 130,
              height: 130,
              decoration: BoxDecoration(
                border: Border.all(width: 4, color: Colors.black54),
                boxShadow: [
                  BoxShadow(
                    spreadRadius: 2,
                    blurRadius: 10,
                    color: Colors.black.withOpacity(0.2),
                  ),
                ],
                shape: BoxShape.circle,
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                    'https://upload.wikimedia.org/wikipedia/en/3/35/The_Eminem_Show.jpg',
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.6,
            child: ListView(
              children: [
                SettingsTile(
                  icon: Icons.phone_android,
                  title: 'Your mobile number',
                  subtitle: '+962780349944',
                ),
                SettingsTile(
                  icon: Icons.person,
                  title: 'Your account',
                  subtitle: 'Your personal info',
                ),
                SettingsTile(
                  icon: Icons.subscriptions,
                  title: 'Subscriptions',
                  subtitle: 'Manage your purchases',
                ),
                SettingsTile(
                  icon: Icons.lock,
                  title: 'Privacy settings',
                  subtitle: 'Music privacy, stories & sharing',
                ),
                SettingsTile(
                  icon: Icons.music_note,
                  title: 'Music settings',
                  subtitle: 'Audio quality & music behavior',
                ),
                SettingsTile(
                  icon: Icons.notifications,
                  title: 'Notifications',
                  subtitle: 'Recommendations, chats & activities',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SettingsTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const SettingsTile({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        icon,
        color: Theme.of(context).colorScheme.secondary,
      ),
      title: Text(title,style:TextStyle(color: Colors.grey[600]) ,),
      subtitle: Text(subtitle),
    //  trailing: Icon(Icons.arrow_forward_ios),
      onTap: () {
        // Add navigation or functionality here
      },
    );
  }
}
