import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {



  Widget _achievement(){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Thành tựu",
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.white
            ),
          ),
          const SizedBox(height: 8,),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            width: double.infinity,
            decoration: BoxDecoration(
              color:const Color.fromRGBO(46, 55, 86, 1),
              borderRadius: BorderRadius.circular(8)
            ),
            child: const Column(
              children: [
                Text(
                  "Hiện chưa có chuỗi nào",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white
                  ),
                ),
                SizedBox(height: 6,),
                Icon(
                  CupertinoIcons.flame,
                  color: Colors.white,
                  size: 30,
                ),
                SizedBox(height: 6,),
                Text(
                  "Hãy học để bắt đầu chuỗi mới của bạn!",
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w300,
                      color: Colors.white
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _studySet(){
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      margin: EdgeInsets.only(right: 12),
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color.fromRGBO(46, 55, 86, 1),
        borderRadius: BorderRadius.circular(12)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Tên học phần",
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.white
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          const Text(
            "12 thuật ngữ",
            style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: Colors.white
            ),
          ),
          const Expanded(
            child: SizedBox(
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: 30,
                width: 30,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15)
                ),
                child: CircleAvatar(
                  child: Image.asset("assets/images/img1.jpg"),
                ),
              ),
              const SizedBox(
                width: 6,
              ),
              const Text(
                "Hujjsdjdsi",
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Colors.white
                ),
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
    );
  }

  Widget _studySetSlide(){
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Học phần",
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.white
                ),
              ),
              Text(
                "Xem tất cả",
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.blue
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8,),
        CarouselSlider(
            items: [
              _studySet(),
              _studySet(),
              _studySet(),
              _studySet()
            ],
            options: CarouselOptions(
              height: 150,
              enableInfiniteScroll: false,
              viewportFraction: 0.92,
            )
        )
      ],
    );
  }

  Widget _class(){
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 18),
      margin: EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
        border: Border.all(color: const Color.fromRGBO(33, 36, 69, 1), width: 2),
        borderRadius: BorderRadius.circular(12)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Tên lớp",
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.white
            ),
          ),
          const SizedBox(height: 12,),
          const Row(
            children: [
              Text(
                "Teacher M",
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Colors.white
                ),
              ),
              SizedBox(width: 4,),
              Icon(CupertinoIcons.circle_fill,size: 4,),
              SizedBox(width: 4,),
              Text(
                "Ho Chi Minh",
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Colors.white
                ),
              ),
              SizedBox(width: 4,),
              Icon(CupertinoIcons.circle_fill, size: 4,),
              SizedBox(width: 4,),
              Text(
                "Ho Chi Minh",
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Colors.white
                ),
              ),
            ],
          ),
          const SizedBox(height: 12,),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(30)
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(CupertinoIcons.square_on_square, size: 12,),
                    Text(
                      "18 học phần",
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Colors.white
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 6,),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(30)
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(CupertinoIcons.person_2, size: 12,),
                    Text(
                      "103 thành viên",
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Colors.white
                      ),
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
  Widget _classSlide(){
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Lớp học",
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.white
                ),
              ),
              Text(
                "Xem tất cả",
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.blue
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8,),
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
            )
        )
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
                    const SizedBox(height: 20,),
                    _studySetSlide(),
                    const SizedBox(height: 20,),
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
                      bottomLeft: Radius.elliptical(200, 20)
                    )
                  ),
                  child: Column(
                    children: [
                      const SizedBox(height: 6,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Quiz",
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.w700,
                              color: Colors.white
                            ),
                          ),
                          IconButton(
                              onPressed: (){
                              },
                              icon: const Icon(
                                  CupertinoIcons.bell,
                                  size: 28,
                                  color: Colors.white,
                              )
                          )
                        ],
                      ),
                      const SizedBox(height: 6,),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
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
                            const SizedBox(width: 8,),
                            Text(
                              "Học phần, sách giáo khoa, câu hỏi",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey.shade500
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                )
            )
          ],
        )
    );
  }
}
