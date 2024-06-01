import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quiz/models/folder.dart';
import 'package:quiz/providers/notify_change_provider.dart';
import 'package:quiz/screens/ui/library/folder/folder-screen.dart';
import 'package:quiz/utilities/image_utils.dart';

class FolderWidget extends StatelessWidget {
  FolderWidget(
      {super.key, required this.folder, required this.listFolderStream});

  Folder folder;
  NotifyChangeStream listFolderStream;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => FolderScreen(
                      folder: folder,
                    )));
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
              CupertinoIcons.folder,
              size: 18,
              color: Colors.white,
            ),
            const SizedBox(
              height: 12,
            ),
            Text(
              folder.folderName,
              style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
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
                        convertBase64ToUint8List(folder.user.image)),
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                Text(
                  folder.user.username,
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
