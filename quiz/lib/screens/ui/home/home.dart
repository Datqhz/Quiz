import 'dart:math';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quiz/models/study_set.dart';
import 'package:quiz/providers/study_set_provider.dart';
import 'package:quiz/screens/ui/library/study-set-view.dart';
import 'package:quiz/services/study_set_service.dart';
import 'package:quiz/utilities/image_utils.dart';
import 'package:quiz/utilities/shared_preference_utils.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ValueNotifier<List<StudySet>?> studySetList = ValueNotifier([]);
  late StudySetListStream studySetListStream;

  @override
  void initState() {
    super.initState();
    studySetListStream = StudySetListStream();
    fetchData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> fetchData() async {
    var user = await getUserInfo();
    studySetList.value = await StudySetService()
        .getAllStudySetByUserId(user!.userId, page: 1, limit: 6);
    studySetListStream.initStream(studySetList.value!);
  }

  Widget _achievement() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Thành tựu",
            style: TextStyle(
                fontSize: 14, fontWeight: FontWeight.w600, color: Colors.white),
          ),
          const SizedBox(
            height: 8,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            width: double.infinity,
            decoration: BoxDecoration(
                color: const Color.fromRGBO(46, 55, 86, 1),
                borderRadius: BorderRadius.circular(8)),
            child: const Column(
              children: [
                Text(
                  "Hiện chưa có chuỗi nào",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white),
                ),
                SizedBox(
                  height: 6,
                ),
                Icon(
                  CupertinoIcons.flame,
                  color: Colors.white,
                  size: 30,
                ),
                SizedBox(
                  height: 6,
                ),
                Text(
                  "Hãy học để bắt đầu chuỗi mới của bạn!",
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w300,
                      color: Colors.white),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _studySet(StudySet studySet) {
    StudySetStream studySetStream = StudySetStream();
    return StreamBuilder<void>(
        stream: studySetStream.stream,
        builder: (context, snapshot) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => StudySetView(
                    studySetStream: studySetStream,
                    studySetListStream: studySetListStream,
                  ),
                ),
              );
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              margin: const EdgeInsets.only(right: 12),
              width: double.infinity,
              decoration: BoxDecoration(
                  color: const Color.fromRGBO(46, 55, 86, 1),
                  borderRadius: BorderRadius.circular(12)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    studySet.studySetName,
                    style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.white),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Text(
                    studySet.cards.length.toString() + " Thuật ngữ",
                    style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: Colors.white),
                  ),
                  const Expanded(
                    child: SizedBox(),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        height: 30,
                        width: 30,
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15)),
                        child: CircleAvatar(
                          child: Image.memory(
                            convertBase64ToUint8List(studySet.user.image),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 6,
                      ),
                      Text(
                        studySet.user.username,
                        style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: Colors.white),
                      ),
                      const Expanded(child: SizedBox()),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        child: Icon(
                          CupertinoIcons.ellipsis_vertical,
                          size: 14,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }

  Widget _studySetSlide() {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Học phần",
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.white),
              ),
              Text(
                "Xem tất cả",
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.blue),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        StreamBuilder<List<StudySet>>(
            stream: studySetListStream.stream,
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return CircularProgressIndicator();
              }
              studySetList.value = snapshot.data!;
              return CarouselSlider(
                  items: _loadListStudySet(snapshot.data!),
                  options: CarouselOptions(
                    height: 150,
                    enableInfiniteScroll: false,
                    viewportFraction: 0.92,
                  ));
            })
      ],
    );
  }

  List<Widget> _loadListStudySet(List<StudySet> data) {
    List<Widget> rs = [];
    data.forEach((element) {
      rs.add(_studySet(element));
    });
    return rs;
  }

  Widget _class() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 18),
      margin: const EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
          border:
              Border.all(color: const Color.fromRGBO(33, 36, 69, 1), width: 2),
          borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Tên lớp",
            style: TextStyle(
                fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white),
          ),
          const SizedBox(
            height: 12,
          ),
          const Row(
            children: [
              Text(
                "Teacher M",
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Colors.white),
              ),
              SizedBox(
                width: 4,
              ),
              Icon(
                CupertinoIcons.circle_fill,
                size: 4,
              ),
              SizedBox(
                width: 4,
              ),
              Text(
                "Ho Chi Minh",
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Colors.white),
              ),
              SizedBox(
                width: 4,
              ),
              Icon(
                CupertinoIcons.circle_fill,
                size: 4,
              ),
              SizedBox(
                width: 4,
              ),
              Text(
                "Ho Chi Minh",
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Colors.white),
              ),
            ],
          ),
          const SizedBox(
            height: 12,
          ),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(30)),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      CupertinoIcons.square_on_square,
                      size: 12,
                    ),
                    Text(
                      "18 học phần",
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                width: 6,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(30)),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      CupertinoIcons.person_2,
                      size: 12,
                    ),
                    Text(
                      "103 thành viên",
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                    ),
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget _classSlide() {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Lớp học",
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.white),
              ),
              Text(
                "Xem tất cả",
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.blue),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        CarouselSlider(
            items: [
              _class(),
              _class(),
              _class(),
              _class(),
            ],
            options: CarouselOptions(
              height: 120,
              enableInfiniteScroll: false,
              viewportFraction: 0.92,
            ))
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Stack(
      children: [
        Container(
          padding: const EdgeInsets.only(top: 170),
          height: double.infinity,
          width: MediaQuery.of(context).size.width,
          color: const Color.fromRGBO(10, 8, 45, 1),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _achievement(),
                const SizedBox(
                  height: 20,
                ),
                _studySetSlide(),
                const SizedBox(
                  height: 20,
                ),
                _classSlide()
              ],
            ),
          ),
        ),
        // home appbar
        Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.only(left: 15, right: 15, bottom: 40),
              decoration: const BoxDecoration(
                  color: Color.fromRGBO(46, 55, 86, 1),
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.elliptical(200, 20),
                      bottomLeft: Radius.elliptical(200, 20))),
              child: Column(
                children: [
                  const SizedBox(
                    height: 6,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Quiz",
                        style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w700,
                            color: Colors.white),
                      ),
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            CupertinoIcons.bell,
                            size: 28,
                            color: Colors.white,
                          ))
                    ],
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          CupertinoIcons.search,
                          size: 30,
                          color: Colors.grey,
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Text(
                          "Học phần, sách giáo khoa, câu hỏi",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey.shade500),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ))
      ],
    ));
  }
}
