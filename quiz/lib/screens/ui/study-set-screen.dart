import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quiz/widgets/flash-card.dart';

class StudySetScreen extends StatefulWidget {
  const StudySetScreen({super.key});

  @override
  State<StudySetScreen> createState() => _StudySetScreenState();
}

class _StudySetScreenState extends State<StudySetScreen> {

  int _termIdx = 0;
  int _sortOption = 0;

  Widget _termCard(){
    return FlipCard(
      fill: Fill.fillBack, // Fill the back side of the card to make in the same size as the front.
      direction: FlipDirection.VERTICAL, // default
      side: CardSide.FRONT, // The side to initially display.
      front: Container(
        decoration: BoxDecoration(
          color: Color.fromRGBO(46, 55, 86, 1),
          borderRadius: BorderRadius.circular(12)
        ),
        child: Stack(
          children: [
            Center(
              child:  Text(
                'Term',
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.w400
                ) ,
              ),
            ),
            Positioned(
                bottom: 15,
                right: 15,
                child: Icon(CupertinoIcons.viewfinder, color: Colors.white, size: 20,)
            )
          ],
        ),
      ),
      back: Container(
        decoration: BoxDecoration(
            color: Color.fromRGBO(46, 55, 86, 1),
            borderRadius: BorderRadius.circular(12)
        ),
        child: Stack(
          children: [
            Center(
              child:  Text(
                'Definition',
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.w400
                ) ,
              ),
            ),
            Positioned(
                bottom: 15,
                right: 15,
                child: Icon(CupertinoIcons.viewfinder, color: Colors.white, size: 20,)
            )
          ],
        ),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.0),
        child: AppBar(
          elevation: 0,
          backgroundColor: Color.fromRGBO(10, 8, 45, 1),
          actions: [
            IconButton(
                onPressed: (){
                },
                icon: Icon(
                  CupertinoIcons.ellipsis_vertical,
                  color: Colors.white,
                  size: 24,
                )
            )
          ],
        ),
      ),
      backgroundColor: Color.fromRGBO(46, 55, 86, 1),
      body: SafeArea(
        child:Container(
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.symmetric(horizontal: 15),
          color: Color.fromRGBO(10, 8, 45, 1),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 12,),
                CarouselSlider(
                    items: [
                      _termCard(),
                      _termCard(),
                      _termCard(),
                      _termCard(),
                    ],
                    options: CarouselOptions(
                        height: 200,
                        enableInfiniteScroll: false,
                        viewportFraction: 0.8,
                        enlargeCenterPage: true,
                        autoPlayCurve: Curves.fastOutSlowIn,
                        onPageChanged: (index, reason) {
                          setState(() {
                            _termIdx = index;
                          });
                        }
                        ),
                ),
                SizedBox(height: 16,),
                Text(
                  "Day 9",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.white
                  ),
                ),
                SizedBox(height: 16,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      height: 35,
                      width: 35,
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25)
                      ),
                      child: CircleAvatar(
                        child: Image.asset("assets/images/img1.jpg"),
                      ),
                    ),
                    SizedBox(width: 8,),
                    Text(
                      "hoqucojs1",
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.white
                      ),
                    ),
                    SizedBox(width: 8,),
                    Container(
                      height: 16,
                      decoration: BoxDecoration(
                        border: Border(
                          right: BorderSide(
                            color: Colors.white.withOpacity(0.4),
                            width: 0.5
                          )
                        )
                      ),
                    ),
                    SizedBox(width: 8,),
                    Text(
                      "20 thuật ngữ",
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.white
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8,),
                Container(
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(46, 55, 86, 1),
                    borderRadius: BorderRadius.circular(12)
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 18),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(CupertinoIcons.bolt_circle_fill, color: Color.fromRGBO(67,85, 255, 1),size: 20),
                      SizedBox(width: 12,),
                      Text(
                        "Học",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.white
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 8,),
                Container(
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(46, 55, 86, 1),
                      borderRadius: BorderRadius.circular(12)
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 18),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(CupertinoIcons.bolt_circle_fill, color: Color.fromRGBO(67,85, 255, 1),size: 20),
                      SizedBox(width: 12,),
                      Text(
                        "Học",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.white
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 8,),
                Container(
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(46, 55, 86, 1),
                      borderRadius: BorderRadius.circular(12)
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 18),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(CupertinoIcons.bolt_circle_fill, color: Color.fromRGBO(67,85, 255, 1),size: 20),
                      SizedBox(width: 12,),
                      Text(
                        "Học",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.white
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 22,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Thẻ",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Colors.white
                      ),
                    ),
                    GestureDetector(
                      onTap: (){
                        showModalBottomSheet(
                            backgroundColor: Colors.transparent,
                            context: context,
                            builder: (context) {
                              return Container(
                                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                                height: 160,
                                decoration: BoxDecoration(
                                    color: Color.fromRGBO(46, 55, 86, 1),
                                    borderRadius: BorderRadius.only(topLeft: Radius.circular(18), topRight: Radius.circular(18))
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Sắp xếp theo thuật ngữ",
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.white
                                      ),
                                    ),
                                    SizedBox(height: 10,),
                                    GestureDetector(
                                      onTap: (){
                                        Navigator.pop(context);
                                        if(_sortOption !=0){
                                          setState(() {
                                            _sortOption = 0;
                                          });

                                        }
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 10),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Theo thứ tự ban đầu",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w400,
                                                  color: Colors.white
                                              ),
                                            ),
                                            if(_sortOption == 0) ...[Icon(
                                              CupertinoIcons.checkmark_alt, color: Colors.white,
                                            )]
                                          ],
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: (){
                                        Navigator.pop(context);
                                        if(_sortOption !=1){
                                          setState(() {
                                            _sortOption = 1;
                                          });

                                        }
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 10),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Bảng chữ cái",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w400,
                                                  color: Colors.white
                                              ),
                                            ),
                                            if(_sortOption == 1) ...[Icon(
                                              CupertinoIcons.checkmark_alt, color: Colors.white,
                                            )]
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
                            _sortOption==0?"Thứ tự gốc":"Bảng chữ cái",
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                color: Colors.white
                            ),
                          ),
                          SizedBox(width: 8,),
                          Icon(CupertinoIcons.line_horizontal_3_decrease, color: Colors.white,)
                        ],
                      ),
                    )
                  ],
                ),
                SizedBox(height: 12,),
                ...[
                  FlashCardWidget(),
                  SizedBox(height: 12,),
                  FlashCardWidget(),
                  SizedBox(height: 12,),
                  FlashCardWidget(),
                  SizedBox(height: 12,),
                  FlashCardWidget(),
                  SizedBox(height: 12,),
                ]
              ],
            ),
          ),
        ),
      ),
    );
  }
}
