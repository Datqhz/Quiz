import 'package:flutter/material.dart';
import 'package:quiz/screens/ui/library/class-screen.dart';

import '../../../widgets/study-set.dart';

class ClassView extends StatelessWidget {
  const ClassView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      color: Color.fromRGBO(10, 8, 45, 1),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 120,
            ),
            StudyItem(type: 2, itemColor:Colors.transparent),
            SizedBox(height: 8,),
            StudyItem(type: 2, itemColor:Colors.transparent),
            SizedBox(height: 8,),
            GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>ClassScreen()));
                },
                child: StudyItem(type: 3, itemColor:Colors.transparent)
            ),
            SizedBox(height: 8, ),
            StudyItem(type: 3, itemColor:Colors.transparent),
          ],
        ),
      ),
    );
  }
}
