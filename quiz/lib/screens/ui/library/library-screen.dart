import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quiz/models/folder.dart';
import 'package:quiz/providers/notify_change_provider.dart';
import 'package:quiz/screens/ui/library/class/class-view.dart';
import 'package:quiz/screens/ui/library/class/create-class-screen.dart';
import 'package:quiz/screens/ui/library/folder/folder-view.dart';
import 'package:quiz/screens/ui/library/study-set/create-study-set-screen.dart';
import 'package:quiz/screens/ui/library/study-set/study-set-view.dart';
import 'package:quiz/services/folder_service.dart';

class LibraryScreen extends StatefulWidget {
  const LibraryScreen({super.key});

  @override
  State<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  NotifyChangeStream studySetStream = NotifyChangeStream();
  NotifyChangeStream classStream = NotifyChangeStream();
  NotifyChangeStream folderStream = NotifyChangeStream();
  final TextEditingController _folderNameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Stack(
      children: [
        TabBarView(controller: _tabController, children: [
          StudySetView(
            studySetStream: studySetStream,
          ),
          FolderView(
            folderStream: folderStream,
          ),
          ClassView(classStream: classStream,)
        ]),
        Positioned(
            top: 0,
            right: 0,
            left: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              width: double.infinity,
              color: const Color.fromRGBO(10, 8, 45, 1),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Thư viện",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: Colors.white),
                      ),
                      IconButton(
                          onPressed: () {
                            if (_tabController.index == 0) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => CreateStudySet(
                                            changeStream: studySetStream,
                                          )));
                            } else if (_tabController.index == 1) {
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
                                        height: 250,
                                        child: Form(
                                          key: _formKey,
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
                                                controller:
                                                    _folderNameController,
                                                decoration: InputDecoration(
                                                    hintText: 'Tên thư mục',
                                                    hintStyle: TextStyle(
                                                        color: Colors.white
                                                            .withOpacity(0.6),
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w400),
                                                    enabledBorder:
                                                        UnderlineInputBorder(
                                                            borderSide: BorderSide(
                                                                color: Colors
                                                                    .white
                                                                    .withOpacity(
                                                                        0.6),
                                                                width: 1)),
                                                    focusedBorder:
                                                        const UnderlineInputBorder(
                                                            borderSide: BorderSide(
                                                                color: Color
                                                                    .fromRGBO(
                                                                        65,
                                                                        63,
                                                                        212,
                                                                        1),
                                                                width: 2))),
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 14,
                                                  decoration:
                                                      TextDecoration.none,
                                                  decorationThickness: 0,
                                                ),
                                                validator: (value) {
                                                  if (value!.isEmpty) {
                                                    return "Vui lòng nhập tên thư mục";
                                                  }
                                                  return null;
                                                },
                                              ),
                                              const SizedBox(
                                                height: 20,
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
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 16,
                                                          vertical: 10),
                                                      textStyle:
                                                          const TextStyle(
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              color: Color
                                                                  .fromRGBO(
                                                                      153,
                                                                      162,
                                                                      232,
                                                                      1)),
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
                                                    onPressed: () async {
                                                      if (_formKey.currentState!
                                                          .validate()) {
                                                        FolderRequest request =
                                                            FolderRequest(
                                                                folderId: 0,
                                                                folderName:
                                                                    _folderNameController
                                                                        .text
                                                                        .trim(),
                                                                userId: 0,
                                                                classId: 0);
                                                        bool rs =
                                                            await FolderService()
                                                                .createFolder(
                                                                    request);
                                                        if (rs) {
                                                          ScaffoldMessenger.of(
                                                                  context)
                                                              .showSnackBar(
                                                            SnackBar(
                                                              width: 2.6 *
                                                                  MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width /
                                                                  4,
                                                              behavior:
                                                                  SnackBarBehavior
                                                                      .floating,
                                                              content:
                                                                  const Text(
                                                                'Tạo thư mục thành công',
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                              ),
                                                              shape: RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              14)),
                                                              duration:
                                                                  const Duration(
                                                                      seconds:
                                                                          2),
                                                            ),
                                                          );
                                                          folderStream
                                                              .notifyDataChanged();
                                                          Navigator.pop(
                                                              context);
                                                        } else {
                                                          ScaffoldMessenger.of(
                                                                  context)
                                                              .showSnackBar(
                                                            SnackBar(
                                                              width: 2.6 *
                                                                  MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width /
                                                                  4,
                                                              behavior:
                                                                  SnackBarBehavior
                                                                      .floating,
                                                              content:
                                                                  const Text(
                                                                'Xảy ra lỗi trong quá trình tạo',
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                              ),
                                                              shape: RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              14)),
                                                              duration:
                                                                  const Duration(
                                                                      seconds:
                                                                          2),
                                                            ),
                                                          );
                                                        }
                                                      }
                                                    },
                                                    style: TextButton.styleFrom(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 16,
                                                          vertical: 10),
                                                      textStyle:
                                                          const TextStyle(
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              color: Color
                                                                  .fromRGBO(
                                                                      153,
                                                                      162,
                                                                      232,
                                                                      1)),
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
                                      ),
                                    );
                                  });
                            } else {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          CreateClassScreen(classStream: classStream,)));
                            }
                          },
                          icon: const Icon(
                            CupertinoIcons.add,
                            color: Colors.white,
                            size: 24,
                          ))
                    ],
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  TabBar(
                    labelPadding: const EdgeInsets.only(bottom: 12, right: 30),
                    tabAlignment: TabAlignment.start,
                    unselectedLabelColor: Colors.white.withOpacity(0.7),
                    indicatorSize: TabBarIndicatorSize.label,
                    isScrollable: true,
                    indicatorWeight: 3,
                    controller: _tabController,
                    tabs: const [
                      Text(
                        "Học phần",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        "Thư mục",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        "Lớp học",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ))
      ],
    ));
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}
