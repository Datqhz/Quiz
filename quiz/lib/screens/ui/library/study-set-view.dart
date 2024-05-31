import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quiz/screens/ui/study-set-screen.dart';
import 'package:quiz/widgets/study-set.dart';

class StudySetView extends StatefulWidget {
  const StudySetView({super.key});

  @override
  State<StudySetView> createState() => _StudySetViewState();
}

class _StudySetViewState extends State<StudySetView> {
  List<String> _sorts = ['Tất cả', 'Đã tạo', 'Đã học', 'Đã tải về'];
  String _sort = 'Tất cả';

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      color: Color.fromRGBO(10, 8, 45, 1),
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 110,
            ),
            Container(
              constraints: BoxConstraints(maxWidth: 150, maxHeight: 40),
              // Limit the width
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4.0),
                border: Border.all(
                  color: Color.fromRGBO(46, 55, 86, 1),
                  style: BorderStyle.solid,
                  width: 2,
                ),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton(
                  items: _sorts
                      .map((value) => DropdownMenuItem(
                            child: Text(
                              value,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 13),
                            ),
                            value: value,
                          ))
                      .toList(),
                  onChanged: (String? value) {},
                  value: _sorts.first,
                  icon: Icon(
                    CupertinoIcons.chevron_down,
                    color: Colors.white,
                    size: 14,
                  ),
                  dropdownColor: Color.fromRGBO(46, 55, 86, 1),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              decoration: InputDecoration(
                  hintText: 'Bộ lọc',
                  hintStyle: TextStyle(
                      color: Colors.white.withOpacity(0.8),
                      fontSize: 14,
                      fontWeight: FontWeight.w400),
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white.withOpacity(0.6), width: 1)),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 1))
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
            SizedBox(
              height: 20,
            ),
            GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>StudySetScreen()));
                },
                child: StudyItem(type: 2, itemColor:Colors.transparent)
            ),
            SizedBox(height: 8,),
            StudyItem(type: 2, itemColor:Colors.transparent),
            SizedBox(height: 8,),
            StudyItem(type: 3, itemColor:Colors.transparent),
            SizedBox(height: 8, ),
            StudyItem(type: 3, itemColor:Colors.transparent),
            SizedBox(height: 8,),
            StudyItem(type: 1, itemColor:Colors.transparent),
            SizedBox(height: 8,),
            StudyItem(type: 1 , itemColor:Colors.transparent),
            SizedBox(height: 8,),
          ],
        ),
      ),
    );
  }
}
