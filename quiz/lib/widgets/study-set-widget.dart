import 'package:flutter/material.dart';
import 'package:quiz/models/study_set.dart';
import 'package:quiz/providers/notify_change_provider.dart';
import 'package:quiz/providers/study_set_provider.dart';
import 'package:quiz/screens/ui/study-set-screen.dart';
import 'package:quiz/utilities/image_utils.dart';

class StudySetWidget extends StatelessWidget {
  StudySetWidget({super.key, required this.itemColor, required this.studySet, required this.studySetStream});
  Color itemColor;
  StudySetBrief studySet;
  NotifyChangeStream studySetStream;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => StudySetScreen(
                    studySetId: studySet.studySetId,
                    studySetStream: studySetStream)));
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        width: double.infinity,
        decoration: BoxDecoration(
            color: itemColor,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
                color: const Color.fromRGBO(46, 55, 86, 1), width: 2)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              studySet.studySetName,
              style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Colors.white),
            ),
            const SizedBox(
              height: 12,
            ),
            Text(
              "${studySet.totalCards} thuật ngữ",
              style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: Colors.white),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: 30,
                  width: 30,
                  clipBehavior: Clip.antiAlias,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(15)),
                  child: CircleAvatar(
                    child: Image.memory(
                        convertBase64ToUint8List(studySet.user.image)),
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                Text(
                  studySet.user.username,
                  style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Colors.white),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
