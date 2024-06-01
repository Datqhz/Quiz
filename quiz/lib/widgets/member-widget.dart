import 'package:flutter/material.dart';
import 'package:quiz/models/member.dart';
import 'package:quiz/utilities/image_utils.dart';

class MemberWidget extends StatelessWidget {
  MemberWidget({super.key, required this.member});

  Member member;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      width: double.infinity,
      decoration: BoxDecoration(
          color: const Color.fromRGBO(46, 55, 86, 1),
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
              child: Image.memory(convertBase64ToUint8List(member.user.image)),
            ),
          ),
          const SizedBox(width: 18,),
          Text(
            member.user.username,
            style: const TextStyle(
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
