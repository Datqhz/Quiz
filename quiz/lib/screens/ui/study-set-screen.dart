import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:quiz/models/card.dart';
import 'package:quiz/models/study_set.dart';
import 'package:quiz/models/user.dart';
import 'package:quiz/providers/notify_change_provider.dart';
import 'package:quiz/providers/study_set_provider.dart';
import 'package:quiz/services/study_set_service.dart';
import 'package:quiz/utilities/image_utils.dart';
import 'package:quiz/utilities/shared_preference_utils.dart';
import 'package:quiz/widgets/flash-card.dart';

class StudySetScreen extends StatefulWidget {
  StudySetScreen(
      {super.key, required this.studySetId, required this.studySetStream});

  int studySetId;
  NotifyChangeStream studySetStream;
  @override
  State<StudySetScreen> createState() => _StudySetScreenState();
}

class _StudySetScreenState extends State<StudySetScreen> {
  int _termIdx = 0;
  int _sortOption = 0;
  ValueNotifier<StudySet?> studySet = ValueNotifier(null);
  NotifyChangeStream personalStream = NotifyChangeStream();

  Future<void> fetchData() async {
    UserInfo? user = await getUserInfo();
    studySet.value = await StudySetService().getStudySetById(widget.studySetId);
  }

  @override
  void initState() {
    super.initState();
    personalStream.notifyDataChanged();
  }

  Widget _termCard(MyCard card) {
    return FlipCard(
      fill: Fill
          .fillBack, // Fill the back side of the card to make in the same size as the front.
      direction: FlipDirection.VERTICAL, // default
      side: CardSide.FRONT, // The side to initially display.
      front: Container(
        decoration: BoxDecoration(
            color: const Color.fromRGBO(46, 55, 86, 1),
            borderRadius: BorderRadius.circular(12)),
        child: Stack(
          children: [
            Center(
              child: Text(
                card.term,
                style: const TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.w400),
              ),
            ),
            const Positioned(
                bottom: 15,
                right: 15,
                child: Icon(
                  CupertinoIcons.viewfinder,
                  color: Colors.white,
                  size: 20,
                ))
          ],
        ),
      ),
      back: Container(
        decoration: BoxDecoration(
            color: const Color.fromRGBO(46, 55, 86, 1),
            borderRadius: BorderRadius.circular(12)),
        child: Stack(
          children: [
            Center(
              child: Text(
                card.definition,
                style: const TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.w400),
              ),
            ),
            const Positioned(
                bottom: 15,
                right: 15,
                child: Icon(
                  CupertinoIcons.viewfinder,
                  color: Colors.white,
                  size: 20,
                ))
          ],
        ),
      ),
    );
  }

  List<Widget> _loadCards() {
    List<Widget> rs = [];
    if (studySet.value != null) {
      for (var card in studySet.value!.cards) {
        rs.add(_termCard(card));
      }
    }

    return rs;
  }

  List<Widget> _loadFlashCards() {
    List<Widget> rs = [];
    if (studySet.value != null) {
      for (var card in studySet.value!.cards) {
        rs.add(FlashCardWidget(card: card));
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
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50.0),
        child: AppBar(
          elevation: 0,
          backgroundColor: const Color.fromRGBO(10, 8, 45, 1),
          actions: [
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  CupertinoIcons.ellipsis_vertical,
                  color: Colors.white,
                  size: 24,
                ))
          ],
        ),
      ),
      backgroundColor: const Color.fromRGBO(46, 55, 86, 1),
      body: SafeArea(
        child: StreamBuilder(
          stream: personalStream.stream,
          builder: (context, snapshot) {
            return FutureBuilder(
              future: fetchData(),
              builder: (context, futureSnapshot) {
                if (futureSnapshot.connectionState == ConnectionState.done) {
                  return Container(
                    height: MediaQuery.of(context).size.height,
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    color: const Color.fromRGBO(10, 8, 45, 1),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 12,
                          ),
                          //list card
                          CarouselSlider(
                            items: _loadCards(),
                            options: CarouselOptions(
                                height: 200,
                                enableInfiniteScroll: false,
                                viewportFraction: 0.8,
                                enlargeCenterPage: true,
                                autoPlayCurve: Curves.fastOutSlowIn,
                                onPageChanged: (index, reason) {
                                  // setState(() {
                                  //   _termIdx = index;
                                  // });
                                }),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Text(
                            studySet.value != null
                                ? studySet.value!.studySetName
                                : "",
                            style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: Colors.white),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          //user create info
                          if (studySet.value != null) ...[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  height: 35,
                                  width: 35,
                                  clipBehavior: Clip.antiAlias,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(25)),
                                  child: CircleAvatar(
                                    child: Image.memory(
                                        convertBase64ToUint8List(
                                            studySet.value!.user.image)),
                                  ),
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  studySet.value!.user.username,
                                  style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white),
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                Container(
                                  height: 16,
                                  decoration: BoxDecoration(
                                      border: Border(
                                          right: BorderSide(
                                              color:
                                                  Colors.white.withOpacity(0.4),
                                              width: 0.5))),
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  "${studySet.value!.cards.length} thuật ngữ",
                                  style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white),
                                ),
                              ],
                            )
                          ],
                          const SizedBox(
                            height: 8,
                          ),
                          Container(
                            decoration: BoxDecoration(
                                color: const Color.fromRGBO(46, 55, 86, 1),
                                borderRadius: BorderRadius.circular(12)),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 18),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(CupertinoIcons.bolt_circle_fill,
                                    color: Color.fromRGBO(67, 85, 255, 1),
                                    size: 20),
                                SizedBox(
                                  width: 12,
                                ),
                                Text(
                                  "Học",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Container(
                            decoration: BoxDecoration(
                                color: const Color.fromRGBO(46, 55, 86, 1),
                                borderRadius: BorderRadius.circular(12)),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 18),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(CupertinoIcons.bolt_circle_fill,
                                    color: Color.fromRGBO(67, 85, 255, 1),
                                    size: 20),
                                SizedBox(
                                  width: 12,
                                ),
                                Text(
                                  "Học",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Container(
                            decoration: BoxDecoration(
                                color: const Color.fromRGBO(46, 55, 86, 1),
                                borderRadius: BorderRadius.circular(12)),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 18),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(CupertinoIcons.bolt_circle_fill,
                                    color: Color.fromRGBO(67, 85, 255, 1),
                                    size: 20),
                                SizedBox(
                                  width: 12,
                                ),
                                Text(
                                  "Học",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 22,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Thẻ",
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white),
                              ),
                              GestureDetector(
                                onTap: () {
                                  showModalBottomSheet(
                                      backgroundColor: Colors.transparent,
                                      context: context,
                                      builder: (context) {
                                        return Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 15, vertical: 20),
                                          height: 160,
                                          decoration: const BoxDecoration(
                                              color:
                                                  Color.fromRGBO(46, 55, 86, 1),
                                              borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(18),
                                                  topRight:
                                                      Radius.circular(18))),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const Text(
                                                "Sắp xếp theo thuật ngữ",
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.white),
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  Navigator.pop(context);
                                                  if (_sortOption != 0) {
                                                    setState(() {
                                                      _sortOption = 0;
                                                    });
                                                  }
                                                },
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(vertical: 10),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      const Text(
                                                        "Theo thứ tự ban đầu",
                                                        style: TextStyle(
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            color:
                                                                Colors.white),
                                                      ),
                                                      if (_sortOption == 0) ...[
                                                        const Icon(
                                                          CupertinoIcons
                                                              .checkmark_alt,
                                                          color: Colors.white,
                                                        )
                                                      ]
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  Navigator.pop(context);
                                                  if (_sortOption != 1) {
                                                    setState(() {
                                                      _sortOption = 1;
                                                    });
                                                  }
                                                },
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(vertical: 10),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      const Text(
                                                        "Bảng chữ cái",
                                                        style: TextStyle(
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            color:
                                                                Colors.white),
                                                      ),
                                                      if (_sortOption == 1) ...[
                                                        const Icon(
                                                          CupertinoIcons
                                                              .checkmark_alt,
                                                          color: Colors.white,
                                                        )
                                                      ]
                                                    ],
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        );
                                      });
                                },
                                child: Row(
                                  children: [
                                    Text(
                                      _sortOption == 0
                                          ? "Thứ tự gốc"
                                          : "Bảng chữ cái",
                                      style: const TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.white),
                                    ),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    const Icon(
                                      CupertinoIcons.line_horizontal_3_decrease,
                                      color: Colors.white,
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          ..._loadFlashCards()
                        ],
                      ),
                    ),
                  );
                }
                return const SpinKitCircle(
                  size: 50,
                  color: Colors.blue,
                );
              },
            );
          },
        ),
      ),
    );
  }
}
