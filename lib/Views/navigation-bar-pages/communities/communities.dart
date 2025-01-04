import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_app/CustomWidgets/custom-scaffold.dart';
import 'package:music_app/CustomWidgets/post_widget.dart';
import 'package:music_app/ViewModels/post_view_model.dart';
import 'package:music_app/utils/local_storage_service.dart';

class Communities extends StatefulWidget {
  Communities({super.key});

  @override
  State<Communities> createState() => _CommunitiesState();
}

class _CommunitiesState extends State<Communities> {
  String selectedFeed = "Home"; // الفيد الافتراضي
  PostViewModel postViewModel = PostViewModel();

  @override
  void initState() {
    super.initState();
    fetchPosts(); // جلب البيانات عند بدء الصفحة
  }

  // دالة لجلب البيانات بناءً على الفيد المحدد
  void fetchPosts() {
    final token = LocalStorageService().getToken()!;
    if (selectedFeed == "Home") {
      postViewModel.getAllPosts(token); // جلب كل البوستات
    } else {
      postViewModel.getPostsByCommunity(
          selectedFeed, token); // جلب بوستات الكوميونيتي
    }
  }

  // دالة لتحديث الفيد وجلب البيانات الجديدة
  void updateFeed(String newFeed) {
    setState(() {
      selectedFeed = newFeed; // تحديث الفيد
    });
    fetchPosts(); // جلب البيانات الجديدة
  }

  // دالة لإظهار القائمة المنبثقة لاختيار الفيد
  void _showFeedSelector(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          color: Colors.black,
          child: ListView(children: [
            ListTile(
              title: Text("Home",
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold)),
              onTap: () {
                updateFeed("Home"); // تغيير الفيد إلى Home
                Navigator.pop(context); // إغلاق القائمة
              },
            ),
            ListTile(
              title: Text("Happy", style: const TextStyle(color: Colors.white)),
              onTap: () {
                updateFeed("Happy"); // تغيير الفيد إلى Happy
                Navigator.pop(context); // إغلاق القائمة
              },
            ),
            ListTile(
              title: Text("Love", style: const TextStyle(color: Colors.white)),
              onTap: () {
                updateFeed("Love"); // تغيير الفيد إلى Love
                Navigator.pop(context); // إغلاق القائمة
              },
            ),
            ListTile(
              title: Text("Sad", style: const TextStyle(color: Colors.white)),
              onTap: () {
                updateFeed("Sad"); // تغيير الفيد إلى Sad
                Navigator.pop(context); // إغلاق القائمة
              },
            ),
          ]),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10),
            GestureDetector(
              onTap: () {
                _showFeedSelector(context); // إظهار قائمة اختيار الفيد
              },
              child: Row(
                children: [
                  Text(
                    selectedFeed,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  const Icon(
                    Icons.arrow_drop_down,
                    color: Colors.white,
                    size: 35,
                  ),
                ],
              ),
            ),
            Obx(() {
              if (postViewModel.isLoading.value) {
                return Expanded(
                  child: Center(
                      child: CircularProgressIndicator(
                    color: Colors.white,
                  )),
                ); // تحميل
              } else if (postViewModel.errorMessage.isNotEmpty) {
                return Expanded(
                  child: Center(
                      child: Text(
                    postViewModel.errorMessage.value,
                    style: TextStyle(color: Colors.white),
                  )),
                ); // لا يوجد بوستات
              } else if (!postViewModel.hasPosts) {
                return Expanded(
                  child: Center(
                      child: Text(
                    "No posts available.",
                    style: TextStyle(color: Colors.white),
                  )),
                ); // لا يوجد بوستات
              } else {
                return Expanded(
                  child: ListView.builder(
                    itemCount: postViewModel.posts.value!.length,
                    itemBuilder: (context, index) {
                      final post = postViewModel.posts.value![index];
                      return PostWidget(post: post);
                    },
                  ),
                );
              }
            }),
          ],
        ),
      ),
    );
  }
}
