import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StudyItem extends StatelessWidget {
  StudyItem({super.key, required this.type, required this.itemColor});

  int type; // 1 is study set, 2 is folder, 3 is class
  Color itemColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      width: double.infinity,
      decoration: BoxDecoration(
          color: itemColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color.fromRGBO(46, 55, 86, 1), width: 2)
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if(type!=1)...[Icon(
            type==2? CupertinoIcons.folder: CupertinoIcons.person_2,
            size: 18,
            color: Colors.white,
          ), SizedBox(height: 12,)],
          Text(
            "Tên học phần",
            style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: Colors.white
            ),
          ),

          if(type !=2)...[SizedBox(height: 12,),Text(
            "12 thuật ngữ",
            style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: Colors.white
            ),
          ),],
          if(type != 3)...[SizedBox(height: 20,),Row(
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
          )]
        ],
      ),
    );
  }
}
