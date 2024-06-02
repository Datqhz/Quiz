import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quiz/models/class.dart';
import 'package:quiz/providers/notify_change_provider.dart';
import 'package:quiz/screens/ui/library/class/class-screen.dart';

class ClassWidget extends StatelessWidget {
  ClassWidget({super.key, required this.e_class, required this.classStream});

  Class e_class;
  NotifyChangeStream classStream;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ClassScreen(
                    classId: e_class.classId, classStream: classStream)));
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        width: double.infinity,
        decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
                color: const Color.fromRGBO(46, 55, 86, 1), width: 2)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(
              CupertinoIcons.person_2,
              size: 18,
              color: Colors.white,
            ),
            const SizedBox(
              height: 12,
            ),
            Text(
              e_class.className,
              style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Colors.white),
            ),
            const SizedBox(
              height: 12,
            ),
            Text(
              "${e_class.NumOfFolder} thư mục",
              style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
