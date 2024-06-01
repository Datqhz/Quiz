import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quiz/models/folder.dart';
import 'package:quiz/models/study_set.dart';
import 'package:quiz/providers/notify_change_provider.dart';
import 'package:quiz/services/study_set_service.dart';
import 'package:quiz/utilities/image_utils.dart';
import 'package:quiz/widgets/study-set-widget.dart';


class FolderScreen extends StatelessWidget {
  FolderScreen({super.key, required this.folder});

  Folder folder;
  ValueNotifier<List<StudySetBrief>?> studySets = ValueNotifier([]);
  NotifyChangeStream folderStream = NotifyChangeStream();
  Future<void> fetchData() async {
    studySets.value =
        await StudySetService().getAllStudySetByFolderId(folder.folderId);
  }

  List<Widget> _loadStudySets() {
    List<Widget> rs = [];
    if (studySets.value != null) {
      for (var element in studySets.value!) {
        rs.add(StudySetWidget(
          itemColor: const Color.fromRGBO(46, 55, 86, 1),
          studySet: element,
        ));
        rs.add(const SizedBox(
          height: 12,
        ));
      }
    }
    return rs;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromRGBO(46, 55, 86, 1),
        appBar: AppBar(
          elevation: 1,
          title: const Text(
            "Thư mục",
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.w700, color: Colors.white),
          ),
          backgroundColor: const Color.fromRGBO(46, 55, 86, 1),
          foregroundColor: Colors.white,
          actions: [
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  CupertinoIcons.ellipsis_vertical,
                  color: Colors.white,
                  size: 24,
                )),
          ],
        ),
        body: SafeArea(
          child: StreamBuilder<void>(
              stream: folderStream.stream,
              builder: (context, snapshot) {
                return FutureBuilder(
                    future: fetchData(),
                    builder: (context, snapshot) {
                      return Container(
                        height: MediaQuery.of(context).size.height,
                        color: const Color.fromRGBO(10, 8, 45, 1),
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: double.infinity,
                                color: const Color.fromRGBO(46, 55, 86, 1),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(
                                        height: 12,
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            "${studySets.value!.length} học phần",
                                            style: const TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.white),
                                          ),
                                          const SizedBox(
                                            width: 4,
                                          ),
                                          Container(
                                            color: Colors.grey.shade900,
                                            width: 1,
                                            height: 20,
                                          ),
                                          const SizedBox(
                                            width: 4,
                                          ),
                                          Container(
                                            height: 30,
                                            width: 30,
                                            clipBehavior: Clip.antiAlias,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(15)),
                                            child: CircleAvatar(
                                              child: Image.memory(
                                                  convertBase64ToUint8List(
                                                      folder.user.image)),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 8,
                                          ),
                                          Text(
                                            folder.user.username,
                                            style: const TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.white),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 12,
                                      ),
                                      Text(
                                        folder.folderName,
                                        style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w700,
                                            color: Colors.white),
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 16),
                                child: Column(children: _loadStudySets()),
                              )
                            ],
                          ),
                        ),
                      );
                    });
              }),
        ));
  }
}
