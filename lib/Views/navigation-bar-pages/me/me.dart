import 'package:flutter/material.dart';
import 'package:music_app/CustomWidgets/custom-Button.dart';
import 'package:music_app/CustomWidgets/custom-scaffold.dart';
import 'package:music_app/Views/navigation-bar-pages/me/edit/editPorf.dart';

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
          SizedBox(
              height:
                  70), // Adjust this value to control how far the image is from the top

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
          Expanded(
            child: ListView(
              children: [
                _buildSettingsTile(
                  icon: Icons.phone_android,
                  title: 'Name',
                  subtitle: 'GR',
                ),
                _buildSettingsTile(
                  icon: Icons.person,
                  title: 'Email',
                  subtitle: 'GR@gmail.com',
                ),
                _buildSettingsTile(
                  icon: Icons.password_rounded,
                  title: 'Password',
                  subtitle: '******',
                ),
                _buildSettingsTile(
                  icon: Icons.lock,
                  title: 'Change Info',
                  subtitle: 'Your info',
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => EditProf(),
                        ));
                  },
                ),
                _buildSettingsTile(
                  icon: Icons.card_giftcard,
                  title: 'Secret Gifts',
                  subtitle: 'Ones you got',
                ),
                _buildSettingsTile(
                  icon: Icons.share_outlined,
                  title: 'Share Profile',
                  subtitle: 'Your info',
                ),
              ],
            ),
          ),
          // Logout Button
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
            child: SizedBox(
              width: 120,
              child: CustomButton(
                text: "LogOut",
                onPressed: () {
                  // Add your logout functionality here
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text('Logout'),
                      content: Text('Are you sure you want to logout?'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context); // Close dialog
                          },
                          child: Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () {
                            // Add logout logic here
                            Navigator.pop(context); // Close dialog
                            Navigator.pushReplacementNamed(
                                context, '/login'); // Example navigation
                          },
                          child: Text('Logout'),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsTile({
    required IconData icon,
    required String title,
    required String subtitle,
    void Function()? onTap,
  }) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color:
            Colors.black.withOpacity(0.26), // Semi-transparent black background
        border: Border.all(
          color: const Color.fromARGB(255, 10, 10, 10),
          width: 1.0,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: Icon(
          icon,
          color: Theme.of(context).colorScheme.secondary,
        ),
        title: Text(
          title,
          style: TextStyle(
            color:
                Color.fromARGB(255, 105, 102, 102), // White text for contrast
          ),
        ),
        subtitle: Text(
          subtitle,
          style: TextStyle(
            color: Colors.white70, // Slightly dimmed white for subtitles
          ),
        ),
        onTap: onTap,
      ),
    );
  }
}
