import 'package:flutter/material.dart';

class MemberWidget extends StatelessWidget {
  const MemberWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      width: double.infinity,
      decoration: BoxDecoration(
          color: Color.fromRGBO(46, 55, 86, 1),
          borderRadius: BorderRadius.circular(8)
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            height: 34,
            width: 34,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15)
            ),
            child: CircleAvatar(
              child: Image.asset("assets/images/img1.jpg"),
            ),
          ),
          SizedBox(width: 18,),
          Text(
            "hoqucojs1",
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.white
            ),
          ),
        ],
      )
    );
  }
}
