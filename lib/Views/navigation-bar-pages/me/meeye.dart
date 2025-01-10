import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_app/CustomWidgets/custom-Button.dart';
import 'package:music_app/CustomWidgets/custom-scaffold.dart';
import 'package:music_app/Services/auth.dart';
import 'package:music_app/ViewModels/user_view_model.dart';
import 'package:music_app/Views/navigation-bar-pages/me/edit/editPorf.dart';
import 'package:music_app/Views/navigation-bar-pages/me/my_gifts.dart';
import 'package:music_app/utils/local_storage_service.dart';

class Meeye extends StatefulWidget {
  const Meeye({super.key});

  @override
  State<Meeye> createState() => _MeeyeState();
}

class _MeeyeState extends State<Meeye> {
  final UserViewModel userViewModel = Get.put(UserViewModel());

  @override
  Widget build(BuildContext context) {
    String token = LocalStorageService().getToken() ??
        ""; // استبدل هذا التوكن بتوكن المستخدم الفعلي
    print(token);
    // استدعاء الدالة لجلب البروفايل عند تحميل الصفحة
    userViewModel.fetchUserProfile(token);
    return CustomScaffold(
      showNowPlaying: false,
      title: "",
      body: SingleChildScrollView(child: Obx(() {
        if (userViewModel.isLoading.value) {
          return SizedBox(
            height: MediaQuery.sizeOf(context).height,
            width: MediaQuery.sizeOf(context).width,
            child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Spacer(),
                  CircularProgressIndicator(),
                  Spacer(),
                ]),
          ); // عرض مؤشر التحميل
        } else if (userViewModel.errorMessage.isNotEmpty) {
          return Center(
              child: Text(
            userViewModel.errorMessage.value,
            style: TextStyle(color: Colors.white),
          )); // عرض رسالة خطأ
        } else {
          var user = userViewModel.user.value;
          return Column(
            children: [
              // Add a SizedBox to push the image lower from the top
              const SizedBox(
                  height:
                      30), // Adjust this value to control how far the image is from the top

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
                        user!.profilePicture ?? "",
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              _buildSettingsTile(
                icon: Icons.phone_android,
                title: 'Name',
                subtitle: user.username,
              ),
              _buildSettingsTile(
                icon: Icons.person,
                title: 'Email',
                subtitle: user.email ?? "",
              ),
              _buildSettingsTile(
                icon: Icons.lock,
                title: 'Change Info',
                subtitle: 'Your info',
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const EditProf(),
                      ));
                },
              ),
              _buildSettingsTile(
                  icon: Icons.card_giftcard,
                  title: 'Secret Gifts',
                  subtitle: 'Ones you got',
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MyGifts(),
                        ));
                  }),
              _buildSettingsTile(
                icon: Icons.share_outlined,
                title: 'Share Profile',
                subtitle: 'Your info',
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16.0, vertical: 16.0),
                child: SizedBox(
                  width: 120,
                  child: CustomButton(
                    text: "LogOut",
                    onPressed: () {
                      // Add your logout functionality here
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('Logout'),
                          content:
                              const Text('Are you sure you want to logout?'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context); // Close dialog
                              },
                              child: const Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () {
                                // Add logout logic here
                                Navigator.pop(context); // Close dialog
                                AuthService().logout();
                              },
                              child: const Text('Logout'),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          );
        }
      })),
    );
  }

  Widget _buildSettingsTile({
    required IconData icon,
    required String title,
    required String subtitle,
    void Function()? onTap,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color:
            Colors.grey.withOpacity(0.26), // Semi-transparent black background
        border: Border.all(
          color: const Color.fromARGB(255, 10, 10, 10),
          width: 1.0,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: Icon(
          icon,
          color: const Color.fromARGB(255, 72, 10, 10),
        ),
        title: Text(
          title,
          style: const TextStyle(
            color:
                Color.fromARGB(255, 105, 102, 102), // White text for contrast
          ),
        ),
        subtitle: Text(
          subtitle,
          style: const TextStyle(
            color: Colors.white70, // Slightly dimmed white for subtitles
          ),
        ),
        onTap: onTap,
      ),
    );
  }
}
