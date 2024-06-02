import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:quiz/models/class.dart';
import 'package:quiz/providers/notify_change_provider.dart';
import 'package:quiz/screens/ui/library/class/add-edit-class-screen.dart';
import 'package:quiz/services/class_service.dart';
import 'package:quiz/services/folder_service.dart';
import 'package:quiz/services/member_service.dart';
import 'package:quiz/widgets/folder-widget.dart';
import 'package:quiz/widgets/member-widget.dart';

class ClassScreen extends StatefulWidget {
  ClassScreen({super.key, required this.classId, required this.classStream});

  int classId;
  NotifyChangeStream classStream;
  @override
  State<ClassScreen> createState() => _ClassScreenState();
}

class _ClassScreenState extends State<ClassScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  ValueNotifier folderList = ValueNotifier([]);
  ValueNotifier memberList = ValueNotifier([]);
  ValueNotifier<Class?> eClass = ValueNotifier(null);
  NotifyChangeStream folderStream = NotifyChangeStream();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> fetchFolderData() async {
    folderList.value =
        await FolderService().getAllFolderOfClass(widget.classId);
  }

  Future<void> fetchClassData() async {
    eClass.value = await ClassService().getClassById(widget.classId);
  }

  Future<void> fetchMemberData() async {
    memberList.value =
        await MemberService().getAllMemberOfClass(widget.classId);
  }

  List<Widget> _loadMembers() {
    List<Widget> rs = [
      const SizedBox(
        height: 130,
      )
    ];
    for (var member in memberList.value) {
      rs.add(MemberWidget(
        member: member,
      ));
      rs.add(const SizedBox(
        height: 12,
      ));
    }
    return rs;
  }

  List<Widget> _loadFolders() {
    List<Widget> rs = [
      const SizedBox(
        height: 130,
      )
    ];
    for (var folder in folderList.value) {
      rs.add(FolderWidget(
        folder: folder,
        listFolderStream: folderStream,
      ));
      rs.add(const SizedBox(
        height: 12,
      ));
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
          "Lớp",
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.w700, color: Colors.white),
        ),
        backgroundColor: const Color.fromRGBO(46, 55, 86, 1),
        foregroundColor: Colors.white,
        actions: <Widget>[
          PopupMenuButton<int>(
            icon: const Icon(
              CupertinoIcons.ellipsis_vertical,
              color: Colors.white,
              size: 18,
            ),
            color: Colors.black,
            onSelected: (value) async {
              if (value == 1) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AddEditClassScreen(
                            classStream: widget.classStream,
                            eClass: eClass.value)));
              }else if(value == 2){

              }
            },
            itemBuilder: (BuildContext context) => [
              const PopupMenuItem<int>(
                value: 1,
                child: Text(
                  "Chỉnh sửa",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              const PopupMenuItem<int>(
                value: 2,
                child: Text(
                  "Xóa",
                  style: TextStyle(color: Colors.red),
                ),
              )
            ],
          ),
        ],
      ),
      body: SafeArea(
          child: Stack(
        children: [
          TabBarView(controller: _tabController, children: [
            Container(
              height: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 15),
              color: const Color.fromRGBO(10, 8, 45, 1),
              child: StreamBuilder<void>(
                  stream: folderStream.stream,
                  builder: (context, snapshot) {
                    return FutureBuilder(
                        future: fetchFolderData(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            return SingleChildScrollView(
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: _loadFolders()),
                            );
                          }
                          return const SpinKitCircle(
                            size: 50,
                            color: Colors.blue,
                          );
                        });
                  }),
            ),
            Container(
              height: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 15),
              color: const Color.fromRGBO(10, 8, 45, 1),
              child: FutureBuilder(
                  future: fetchMemberData(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      return SingleChildScrollView(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: _loadMembers()),
                      );
                    }
                    return const SpinKitCircle(
                      size: 50,
                      color: Colors.blue,
                    );
                  }),
            ),
          ]),
          Positioned(
              top: 0,
              right: 0,
              left: 0,
              child: Container(
                width: double.infinity,
                color: const Color.fromRGBO(46, 55, 86, 1),
                child: StreamBuilder<void>(
                    stream: widget.classStream.stream,
                    builder: (context, snapshot) {
                      return FutureBuilder(
                          future: fetchClassData(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.done) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                    height: 12,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15),
                                    child: Text(
                                      eClass.value != null
                                          ? "${eClass.value!.NumOfFolder} thư mục"
                                          : "",
                                      style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.white),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 12,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15),
                                    child: Text(
                                      eClass.value != null
                                          ? eClass.value!.className
                                          : "",
                                      style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.white),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  TabBar(
                                    labelPadding: const EdgeInsets.only(
                                        bottom: 12, right: 30),
                                    tabAlignment: TabAlignment.fill,
                                    unselectedLabelColor:
                                        Colors.white.withOpacity(0.7),
                                    isScrollable: false,
                                    indicatorWeight: 3,
                                    controller: _tabController,
                                    tabs: const [
                                      Text(
                                        "THƯ MỤC",
                                        style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Text(
                                        "THÀNH VIÊN",
                                        style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              );
                            }
                            return const SpinKitCircle(
                              color: Colors.blue,
                              size: 50,
                            );
                          });
                    }),
              ))
        ],
      )),
    );
  }
}
