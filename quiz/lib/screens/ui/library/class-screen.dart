import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quiz/widgets/member-widget.dart';

import '../../../widgets/study-set.dart';

class ClassScreen extends StatefulWidget {
  const ClassScreen({super.key});

  @override
  State<ClassScreen> createState() => _ClassScreenState();
}

class _ClassScreenState extends State<ClassScreen> with SingleTickerProviderStateMixin{
  late TabController _tabController;


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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(46, 55, 86, 1),
      appBar: AppBar(
        elevation: 1,
        title: Text(
          "Lớp",
          style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: Colors.white
          ),
        ),
        backgroundColor: Color.fromRGBO(46, 55, 86, 1),
        foregroundColor: Colors.white,
        actions: [
          IconButton(
              onPressed: (){

              },
              icon: Icon(
                CupertinoIcons.ellipsis_vertical,
                color: Colors.white,
                size: 24,
              )
          ),
        ],
      ),
      body: SafeArea(
          child: Stack(
            children: [
              TabBarView(
                  controller: _tabController,
                  children: [
                    Container(
                      height: double.infinity,
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      color: Color.fromRGBO(10, 8, 45, 1),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 130,),
                            StudyItem(type: 1, itemColor: Color.fromRGBO(46, 55, 86, 1)),
                            SizedBox(height: 12,),
                            StudyItem(type: 1, itemColor: Color.fromRGBO(46, 55, 86, 1)),
                            SizedBox(height: 12,),
                            StudyItem(type: 1, itemColor: Color.fromRGBO(46, 55, 86, 1)),
                            SizedBox(height: 12,),
                            StudyItem(type: 1, itemColor: Color.fromRGBO(46, 55, 86, 1)),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      height: double.infinity,
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      color: Color.fromRGBO(10, 8, 45, 1),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 130,),
                            MemberWidget(),
                            SizedBox(height: 12,),
                            MemberWidget(),
                            SizedBox(height: 12,),
                            MemberWidget(),
                            SizedBox(height: 12,),
                            MemberWidget(),
                          ],
                        ),
                      ),
                    ),
                  ]
              ),
              Positioned(
                  top: 0,
                  right: 0,
                  left: 0,
                  child: Container(
                    width: double.infinity,
                    color: Color.fromRGBO(46, 55, 86, 1),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 12,),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Text(
                            "4 học phần",
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Colors.white
                            ),
                          ),
                        ),
                        SizedBox(height: 12,),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Text(
                            "Tên học phần",
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                                color: Colors.white
                            ),
                          ),
                        ),
                        SizedBox(height: 20,),
                        TabBar(
                          labelPadding: EdgeInsets.only(bottom: 12, right: 30),
                          tabAlignment: TabAlignment.fill,
                          unselectedLabelColor: Colors.white.withOpacity(0.7),
                          isScrollable: false,
                          indicatorWeight: 3,
                          controller: _tabController,
                          tabs: const [
                            Text(
                              "HỌC PHẦN",
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
                    ),
                  )
              )
            ],
          )
      ),
    );
  }

}


