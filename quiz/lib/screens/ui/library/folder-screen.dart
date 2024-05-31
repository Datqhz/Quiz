import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../widgets/study-set.dart';

class FolderScreen extends StatelessWidget {
  const FolderScreen({super.key});

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
          child: Container(
            height: MediaQuery.of(context).size.height,
            color: Color.fromRGBO(10, 8, 45, 1),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    color: Color.fromRGBO(46, 55, 86, 1),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 12,),
                          Row(
                            children: [
                              Text(
                                "4 học phần",
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white
                                ),
                              ),
                              SizedBox(width: 4,),
                              Container(
                                color: Colors.grey.shade900,
                                width: 1,
                                height: 20,
                              ),
                              SizedBox(width: 4,),
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
                              SizedBox(width: 8,),
                              Text(
                                "hoqucojs1",
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 12,),
                          Text(
                            "Tên học phần",
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                                color: Colors.white
                            ),
                          ),
                          SizedBox(height: 20,),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 16),
                    child:Column(
                      children: [
                        StudyItem(type: 1, itemColor: Color.fromRGBO(46, 55, 86, 1)),
                        SizedBox(height: 12,),
                        StudyItem(type: 1, itemColor: Color.fromRGBO(46, 55, 86, 1)),
                        SizedBox(height: 12,),
                        StudyItem(type: 1, itemColor: Color.fromRGBO(46, 55, 86, 1)),
                        SizedBox(height: 12,),
                        StudyItem(type: 1, itemColor: Color.fromRGBO(46, 55, 86, 1)),
                        SizedBox(height: 12,),
                        StudyItem(type: 1, itemColor: Color.fromRGBO(46, 55, 86, 1)),
                        SizedBox(height: 12,),
                        StudyItem(type: 1, itemColor: Color.fromRGBO(46, 55, 86, 1)),
                        SizedBox(height: 12,),
                        StudyItem(type: 1, itemColor: Color.fromRGBO(46, 55, 86, 1)),
                        SizedBox(height: 12,),
                        StudyItem(type: 1, itemColor: Color.fromRGBO(46, 55, 86, 1)),
                        SizedBox(height: 12,),
                        StudyItem(type: 1, itemColor: Color.fromRGBO(46, 55, 86, 1)),
                      ],
                    ),
                  )

                ],
              ),
            ),
          ),
    )
    );
  }
}
