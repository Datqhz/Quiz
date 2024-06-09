import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:quiz/models/folder.dart';
import 'package:quiz/models/folder_detail.dart';
import 'package:quiz/models/study_set.dart';
import 'package:quiz/models/user.dart';
import 'package:quiz/providers/notify_change_provider.dart';
import 'package:quiz/services/folder_detail_service.dart';
import 'package:quiz/services/study_set_service.dart';
import 'package:quiz/shared/colors.dart';
import 'package:quiz/utilities/image_utils.dart';
import 'package:quiz/utilities/shared_preference_utils.dart';
import 'package:quiz/widgets/study-set-tick-widget.dart';

class ChooseStudySetScreen extends StatefulWidget {
  ChooseStudySetScreen(
      {super.key, required this.folder, required this.folderStream});

  NotifyChangeStream folderStream;
  Folder folder;
  @override
  State<ChooseStudySetScreen> createState() => _ChooseStudySetScreenState();
}

class _ChooseStudySetScreenState extends State<ChooseStudySetScreen> {
  ValueNotifier studySets = ValueNotifier([]);
  ValueNotifier<List<StudySetBrief>> choosedStudySets = ValueNotifier([]);
  ValueNotifier studySetSelectedCount = ValueNotifier(0);

  Future<void> fetchData() async {
    UserInfo? user = await getUserInfo();
    studySets.value = await StudySetService()
        .getAllStudySetByUserIdAndNotInFolder(
            user!.userId, widget.folder.folderId);
  }

  void _addStudySet(StudySetBrief studySet) {
    if (!choosedStudySets.value.contains(studySet)) {
      var temp = choosedStudySets.value;
      temp.add(studySet);
      choosedStudySets.value = temp;
      studySetSelectedCount.value = studySetSelectedCount.value + 1;
    }
  }

  void _removeStudySet(StudySetBrief studySet) {
    if (choosedStudySets.value.contains(studySet)) {
      var temp = choosedStudySets.value;
      temp.remove(studySet);
      choosedStudySets.value = temp;
      studySetSelectedCount.value = studySetSelectedCount.value - 1;
    }
  }

  Future<bool> _saveData() async {
    List<FolderDetail> folderDetails = [];
    for (var element in choosedStudySets.value) {
      folderDetails.add(FolderDetail(
          folderId: widget.folder.folderId, studySetId: element.studySetId));
    }
    return await FolderDetailService().addStudySetsToFolder(folderDetails);
  }

  List<Widget> _loadStudySets() {
    List<Widget> rs = [];
    for (var studySet in studySets.value) {
      rs.add(StudySetTickWidget(
        studySet: studySet,
        choosed: _addStudySet,
        unChoosed: _removeStudySet,
      ));
      rs.add(const SizedBox(
        height: 8,
      ));
    }
    return rs;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundScreenColor,
      body: SafeArea(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: [
              FutureBuilder(
                  future: fetchData(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      return Container(
                        height: MediaQuery.of(context).size.height,
                        color: const Color.fromRGBO(10, 8, 45, 1),
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 140,
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
                    }
                    return const SpinKitCircle(
                      size: 50,
                      color: Colors.blue,
                    );
                  }),
              Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    width: double.infinity,
                    color: const Color.fromRGBO(46, 55, 86, 1),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(children: [
                            IconButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: const Icon(
                                  CupertinoIcons.arrow_left,
                                  color: Colors.white,
                                )),
                            const SizedBox(
                              width: 8,
                            ),
                            const Text(
                              'Chọn học phần',
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600),
                            ),
                            const Expanded(
                                child: SizedBox(
                              height: 1,
                            )),
                            TextButton(
                              onPressed: () async {
                                bool rs = await _saveData();
                                if (rs) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      width: 2.6 *
                                          MediaQuery.of(context).size.width /
                                          4,
                                      behavior: SnackBarBehavior.floating,
                                      content: const Text(
                                        'Lưu thành công.',
                                        textAlign: TextAlign.center,
                                      ),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(14)),
                                      duration: const Duration(seconds: 2),
                                    ),
                                  );
                                  widget.folderStream.notifyDataChanged();
                                  Navigator.pop(context);
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      width: 2.6 *
                                          MediaQuery.of(context).size.width /
                                          4,
                                      behavior: SnackBarBehavior.floating,
                                      content: const Text(
                                        'Xảy ra lỗi trong quá trình lưu.',
                                        textAlign: TextAlign.center,
                                      ),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(14)),
                                      duration: const Duration(seconds: 2),
                                    ),
                                  );
                                }
                              },
                              style: TextButton.styleFrom(
                                  backgroundColor: Colors.transparent),
                              child: const Text(
                                "Lưu",
                                style: TextStyle(
                                    color: Color.fromARGB(255, 244, 237, 255),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ]),
                          const SizedBox(
                            height: 12,
                          ),
                          Row(
                            children: [
                              Text(
                                widget.folder.folderName,
                                style: const TextStyle(
                                    fontSize: 18,
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
                                    borderRadius: BorderRadius.circular(15)),
                                child: CircleAvatar(
                                  child: Image.memory(convertBase64ToUint8List(
                                      widget.folder.user.image)),
                                ),
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              Text(
                                widget.folder.user.username,
                                style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          ValueListenableBuilder(
                              valueListenable: studySetSelectedCount,
                              builder: (context, value, snapshot) {
                                return Text(
                                  "$value đã chọn",
                                  style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white),
                                );
                              }),
                          const SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
