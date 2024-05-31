import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../models/card.dart';

class CreateStudySet extends StatefulWidget {
  const CreateStudySet({super.key});

  @override
  State<CreateStudySet> createState() => _CreateStudySetState();
}

class _CreateStudySetState extends State<CreateStudySet> {

  List<FlashCard> cards = [FlashCard(),FlashCard(),FlashCard()];
  _getListCard(){
    List<MyCard> mycards = [];
    cards.forEach((element) {
      mycards.add(element.getCardInfo());
    });
    mycards.forEach((element) {
      print(element.toString());
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(46, 55, 86, 1),
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15),
              color: Color.fromRGBO(10, 8, 45, 1),
              child: ListView(
                children: [
                  SizedBox(height: 60,),
                  Text(
                    'TIÊU ĐỀ',
                    style: TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                        fontWeight: FontWeight.w500
                    ) ,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        hintText: 'Chủ đề, chương',
                        hintStyle: TextStyle(
                            color: Colors.white.withOpacity(0.8),
                            fontSize: 14,
                            fontWeight: FontWeight.w400),
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white.withOpacity(0.6), width: 1)),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white, width: 2))
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
                  SizedBox(height: 12,),
                  Text(
                    'MÔ TẢ',
                    style: TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                        fontWeight: FontWeight.w500
                    ) ,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        hintText: 'Chủ đề, chương',
                        hintStyle: TextStyle(
                            color: Colors.white.withOpacity(0.8),
                            fontSize: 14,
                            fontWeight: FontWeight.w400),
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white.withOpacity(0.6), width: 1)),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white, width: 2))
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
                  SizedBox(height: 60,),
                  ...cards
                ],
              ),
            ),
            Positioned(
                child: Container(
                  color: Color.fromRGBO(46, 55, 86, 1),
                    child: Row(
                        children: [
                          IconButton(
                              onPressed: (){
                                Navigator.pop(context);
                              },
                              icon: Icon(CupertinoIcons.arrow_left, color: Colors.white,)
                          ),
                          SizedBox(width: 8,),
                          Text(
                            'Tạo học phần',
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.w600
                            ) ,
                          ),
                          Expanded(child: SizedBox(height: 1,)),
                          IconButton(
                              onPressed: (){},
                              icon: Icon(CupertinoIcons.gear, color: Colors.white,)
                          ),
                          IconButton(
                              onPressed: (){
                                _getListCard();
                              },
                              icon: Icon(CupertinoIcons.checkmark_alt, color: Colors.white,)
                          ),
                        ]
                    )
                ),
            ),
            Positioned(
              bottom: 15,
                right: 15,
                child: Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(67, 85, 255, 1),
                    borderRadius: BorderRadius.circular(50)
                  ),
                  child: IconButton(
                      onPressed: (){
                        cards.add(FlashCard());
                        setState(() {
                        });
                      },
                      icon: Icon(CupertinoIcons.add, color: Colors.white, size: 20,),
                  ),
                ),
            )
          ],
        ),
      ),
    );
  }
}

class FlashCard extends StatelessWidget {
  FlashCard({super.key});

  late
  TextEditingController _termController = TextEditingController();
  TextEditingController _defineController = TextEditingController();

  MyCard getCardInfo(){
    return MyCard(term: _termController.text, defination: _defineController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      margin: EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color:Color.fromRGBO(46, 55, 86, 1) ,
        borderRadius: BorderRadius.circular(3)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            controller: _termController,
            decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white.withOpacity(0.6), width: 1)),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white, width: 2))
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
          SizedBox(height: 8,),
          Text(
            'THUẬT NGỮ',
            style: TextStyle(
                fontSize: 14,
                color: Colors.white,
                fontWeight: FontWeight.w500
            ) ,
          ),
          SizedBox(height: 10,),
          TextFormField(
            controller: _defineController,
            decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white.withOpacity(0.6), width: 1)),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white, width: 2))
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
          SizedBox(height: 8,),
          Text(
            'ĐỊNH NGHĨA',
            style: TextStyle(
                fontSize: 14,
                color: Colors.white,
                fontWeight: FontWeight.w500
            ) ,
          ),
        ],
      ),
    );
  }
}

