import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quiz/providers/study_set_provider.dart';
import 'package:quiz/screens/ui/library/class-view.dart';
import 'package:quiz/screens/ui/library/create-class.dart';
import 'package:quiz/screens/ui/library/create-study-set.dart';
import 'package:quiz/screens/ui/library/folder-view.dart';
import 'package:quiz/screens/ui/library/study-set-view.dart';

class LibraryScreen extends StatefulWidget {
  const LibraryScreen({super.key});

  @override
  State<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

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
            studySetStream: StudySetStream(),
            studySetListStream: StudySetListStream(),
          ),
          FolderView(),
          ClassView()
        ]),
        Positioned(
            top: 0,
            right: 0,
            left: 0,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 15),
              width: double.infinity,
              color: Color.fromRGBO(10, 8, 45, 1),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 8,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
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
                                      builder: (context) => CreateStudySet()));
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
                                                              color:
                                                                  Color.fromRGBO(
                                                                      65,
                                                                      63,
                                                                      212,
                                                                      1),
                                                              width: 2))
                                                  // labelText: "Bộ lọc" ,
                                                  // labelStyle: TextStyle(
                                                  //     color: Colors.white.withOpacity(0.8),
                                                  //     fontSize: 14,
                                                  //     fontWeight: FontWeight.w400
                                                  // ),
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
                                                              color:
                                                                  Color.fromRGBO(
                                                                      65,
                                                                      63,
                                                                      212,
                                                                      1),
                                                              width: 2))
                                                  // labelText: "Bộ lọc" ,
                                                  // labelStyle: TextStyle(
                                                  //     color: Colors.white.withOpacity(0.8),
                                                  //     fontSize: 14,
                                                  //     fontWeight: FontWeight.w400
                                                  // ),
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
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 16,
                                                        vertical: 10),
                                                    textStyle: const TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w500,
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
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 16,
                                                        vertical: 10),
                                                    textStyle: const TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w500,
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
                            } else {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          CreateClassScreen()));
                            }
                          },
                          icon: Icon(
                            CupertinoIcons.add,
                            color: Colors.white,
                            size: 24,
                          ))
                    ],
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  TabBar(
                    labelPadding: EdgeInsets.only(bottom: 12, right: 30),
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
