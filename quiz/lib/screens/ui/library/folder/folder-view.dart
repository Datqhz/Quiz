import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:quiz/models/folder.dart';
import 'package:quiz/models/user.dart';
import 'package:quiz/providers/notify_change_provider.dart';
import 'package:quiz/services/folder_service.dart';
import 'package:quiz/utilities/shared_preference_utils.dart';
import 'package:quiz/widgets/folder-widget.dart';

class FolderView extends StatelessWidget {
  FolderView({super.key,required this.folderStream});

  NotifyChangeStream folderStream;
  ValueNotifier<List<Folder>?> folders = ValueNotifier([]);

  Future<void> fetchData() async {
    UserInfo? user = await getUserInfo();
    folders.value = await FolderService().getAllFolderOfUserId(user!.userId);
  }

  List<Widget> _loadFolders() {
    List<Widget> rs = [];
    if (folders.value != null) {
      for (var folder in folders.value!) {
        rs.add(FolderWidget(
          folder: folder,
          listFolderStream: folderStream,
        ));
        rs.add(const SizedBox(
          height: 8,
        ));
      }
    }

    return rs;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      color: const Color.fromRGBO(10, 8, 45, 1),
      child: StreamBuilder<void>(
        stream: folderStream.stream,
        builder: (context, snapshot) {
          return FutureBuilder(
              future: fetchData(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (folders.value!.isNotEmpty) {
                    return SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 120,
                          ),
                          ..._loadFolders()
                        ],
                      ),
                    );
                  }
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 100,
                        child: Image.asset('assets/images/folder.png'),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      const SizedBox(
                        width: 200,
                        child: Text(
                          "Sắp xếp học phần của bạn theo chủ đề, giáo viên, khóa học, v.v.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Colors.white),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      TextButton(
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return Dialog(
                                  elevation: 0,
                                  backgroundColor:
                                      const Color.fromRGBO(46, 55, 86, 1),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 12),
                                    height: 300,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        const Text(
                                          "Tạo thư mục",
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.white),
                                        ),
                                        TextFormField(
                                          decoration: InputDecoration(
                                              hintText: 'Tên thư mục',
                                              hintStyle: TextStyle(
                                                  color: Colors.white
                                                      .withOpacity(0.6),
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400),
                                              enabledBorder:
                                                  UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: Colors.white
                                                              .withOpacity(0.6),
                                                          width: 1)),
                                              focusedBorder:
                                                  const UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: Color.fromRGBO(
                                                              65, 63, 212, 1),
                                                          width: 2))
                                              ),
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 14,
                                            decoration: TextDecoration.none,
                                            decorationThickness: 0,
                                          ),
                                          onChanged: (value) {},
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        TextFormField(
                                          decoration: InputDecoration(
                                              hintText: 'Mô tả(tùy chọn)',
                                              hintStyle: TextStyle(
                                                  color: Colors.white
                                                      .withOpacity(0.6),
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400),
                                              enabledBorder:
                                                  UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: Colors.white
                                                              .withOpacity(0.6),
                                                          width: 1)),
                                              focusedBorder:
                                                  const UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: Color.fromRGBO(
                                                              65, 63, 212, 1),
                                                          width: 2))
                                              ),
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 14,
                                            decoration: TextDecoration.none,
                                            decorationThickness: 0,
                                          ),
                                          onChanged: (value) {},
                                        ),
                                        const Expanded(
                                            child: SizedBox(
                                          height: 1,
                                        )),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            TextButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              style: TextButton.styleFrom(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 16,
                                                        vertical: 10),
                                                textStyle: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w500,
                                                    color: Color.fromRGBO(
                                                        153, 162, 232, 1)),
                                                backgroundColor:
                                                    Colors.transparent,
                                              ),
                                              child: const Text(
                                                "HỦY",
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 40,
                                            ),
                                            TextButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              style: TextButton.styleFrom(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 16,
                                                        vertical: 10),
                                                textStyle: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w500,
                                                    color: Color.fromRGBO(
                                                        153, 162, 232, 1)),
                                                backgroundColor:
                                                    Colors.transparent,
                                              ),
                                              child: const Text(
                                                "TẠO",
                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              });
                        },
                        style: TextButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 10),
                            textStyle: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.white),
                            backgroundColor:
                                const Color.fromRGBO(67, 85, 255, 1),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8))),
                        child: const Text(
                          "Tạo thư mục",
                        ),
                      )
                    ],
                  );
                }
                return const SpinKitCircle(
                  size: 50,
                  color: Colors.blue,
                );
              });
        },
      ),
    );
  }
}
