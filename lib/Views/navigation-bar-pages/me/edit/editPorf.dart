import 'package:flutter/material.dart';
import 'package:music_app/CustomWidgets/CustomTextField.dart';
import 'package:music_app/CustomWidgets/custom-Button.dart';
import 'package:music_app/CustomWidgets/custom-scaffold.dart';

class EditProf extends StatefulWidget {
  @override
  State<EditProf> createState() => _EditProfState();
}

class _EditProfState extends State<EditProf> {
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
            child: Padding(
              padding: const EdgeInsets.all(
                  16.0), // Adds padding around the ListView
              child: ListView(
                children: [
                  CustomTextField(
                    controller: TextEditingController(text: ""),
                    hintText: "Name",
                  ),
                  SizedBox(
                      height:
                          16.0), // Adds vertical spacing between text fields
                  CustomTextField(
                    controller: TextEditingController(text: ""),
                    hintText: "Email",
                  ),
                ],
              ),
            ),
          ),

          // Save Button
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
            child: SizedBox(
              width: 120,
              child: CustomButton(
                text: "Save",
                onPressed: () {
                  // Add your save functionality here
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text('Save Changes'),
                      content: Text('Do you want to save the changes?'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context); // Close dialog
                          },
                          child: Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () {
                            // Implement your save logic here
                            Navigator.pop(context); // Close dialog
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Changes saved successfully!'),
                              ),
                            );
                          },
                          child: Text('Save'),
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
      title: Text(
        title,
        style: TextStyle(color: Colors.grey[600]),
      ),
      subtitle: Text(subtitle),
      onTap: () {
        // Add navigation or functionality here
      },
    );
  }
}
