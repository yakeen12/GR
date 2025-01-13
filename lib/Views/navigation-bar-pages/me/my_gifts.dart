import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_app/CustomWidgets/custom-scaffold.dart';
import 'package:music_app/ViewModels/secret_gift_view_model.dart';
import 'package:music_app/Views/navigation-bar-pages/me/my_gift_inside.dart';
import 'package:music_app/Views/navigation-bar-pages/playlist/myplaylistinside.dart';

class MyGifts extends StatefulWidget {
  const MyGifts({super.key});

  @override
  State<MyGifts> createState() => _MyGiftsState();
}

class _MyGiftsState extends State<MyGifts> {
  SecretGiftViewModel secretGiftViewModel = SecretGiftViewModel();
  @override
  Widget build(BuildContext context) {
    secretGiftViewModel.getGifts();
    return CustomScaffold(
        title: "",
        body: Obx(() {
          if (secretGiftViewModel.isLoading.value) {
            return Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            );
          } else if (secretGiftViewModel.errorMessage.isNotEmpty) {
            return Center(
              child: Text(
                secretGiftViewModel.errorMessage.value,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
            );
          } else if (!secretGiftViewModel.hasGifts) {
            return Center(
              child: Text(
                "you did not get any gifts yet :(",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
            );
          } else {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(children: [
                  ...List.generate(
                      secretGiftViewModel.gifts.value!.length,
                      (index) => InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MyGiftInside(
                                          secretGift: secretGiftViewModel
                                              .gifts.value![index],
                                        )),
                              );
                            },
                            child: Container(
                              margin: EdgeInsets.only(bottom: 15),
                              decoration: BoxDecoration(
                                  color:
                                      const Color.fromARGB(41, 255, 255, 255),
                                  borderRadius: BorderRadius.circular(15)),
                              padding: EdgeInsets.all(10),
                              child: Row(
                                children: [
                                  ClipRRect(
                                    child: Image.network(
                                      secretGiftViewModel
                                          .gifts.value![index].songList[0].img,
                                      height: 70,
                                      width: 70,
                                    ),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    secretGiftViewModel
                                        .gifts.value![index].content,
                                    maxLines: 2,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                            ),
                          ))
                ]),
              ),
            );
          }
        }));
  }
}
