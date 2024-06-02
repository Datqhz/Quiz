import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:quiz/models/folder.dart';
import 'package:quiz/models/study_set.dart';
import 'package:quiz/providers/notify_change_provider.dart';
import 'package:quiz/services/folder_service.dart';
import 'package:quiz/services/study_set_service.dart';
import 'package:quiz/utilities/image_utils.dart';
import 'package:quiz/widgets/study-set-widget.dart';

class FolderScreen extends StatelessWidget {
  FolderScreen({super.key, required this.folderId, required this.folderStream});

  int folderId;
  NotifyChangeStream folderStream;

  ValueNotifier<List<StudySetBrief>?> studySets = ValueNotifier([]);
  ValueNotifier<Folder?> folder = ValueNotifier(null);

  NotifyChangeStream studySetStream = NotifyChangeStream();

  final _formKey = GlobalKey<FormState>();

  final TextEditingController _controller = TextEditingController();

  Future<void> fetchData() async {
    folder.value = await FolderService().getFolderById(folderId);
    studySets.value =
        await StudySetService().getAllStudySetByFolderId(folderId);
  }

  List<Widget> _loadStudySets() {
    List<Widget> rs = [];
    if (studySets.value != null) {
      for (var element in studySets.value!) {
        rs.add(StudySetWidget(
          itemColor: const Color.fromRGBO(46, 55, 86, 1),
          studySet: element,
          studySetStream: studySetStream,
        ));
        rs.add(const SizedBox(
          height: 12,
        ));
      }
    }
    return rs;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromRGBO(46, 55, 86, 1),
        appBar: AppBar(
          elevation: 1,
          title: const Text(
            "Thư mục",
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.w700, color: Colors.white),
          ),
          backgroundColor: const Color.fromRGBO(46, 55, 86, 1),
          foregroundColor: Colors.white,
          actions: <Widget>[
            PopupMenuButton<int>(
              icon: const Icon(
                CupertinoIcons.ellipsis_vertical,
                color: Colors.white,
                size: 18,
              ),
              color: Colors.black,
              onSelected: (value) async {
                if (value == 1) {
                  _controller.text = folder.value!.folderName;
                  showDialog(
                      context: context,
                      builder: (context) {
                        return Dialog(
                          elevation: 0,
                          backgroundColor: const Color.fromRGBO(46, 55, 86, 1),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 12),
                            height: 250,
                            child: Form(
                              key: _formKey,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  const Text(
                                    "Tạo thư mục",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white),
                                  ),
                                  TextFormField(
                                    controller: _controller,
                                    decoration: InputDecoration(
                                        hintText: 'Tên thư mục',
                                        hintStyle: TextStyle(
                                            color:
                                                Colors.white.withOpacity(0.6),
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400),
                                        enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.white
                                                    .withOpacity(0.6),
                                                width: 1)),
                                        focusedBorder:
                                            const UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Color.fromRGBO(
                                                        65, 63, 212, 1),
                                                    width: 2))),
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14,
                                      decoration: TextDecoration.none,
                                      decorationThickness: 0,
                                    ),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "Vui lòng nhập tên thư mục";
                                      }
                                      return null;
                                    },
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  const Expanded(
                                      child: SizedBox(
                                    height: 1,
                                  )),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        style: TextButton.styleFrom(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 16, vertical: 10),
                                          textStyle: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                              color: Color.fromRGBO(
                                                  153, 162, 232, 1)),
                                          backgroundColor: Colors.transparent,
                                        ),
                                        child: const Text(
                                          "HỦY",
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 40,
                                      ),
                                      TextButton(
                                        onPressed: () async {
                                          if (_formKey.currentState!
                                              .validate()) {
                                            FolderRequest request =
                                                FolderRequest(
                                                    folderId:
                                                        folder.value!.folderId,
                                                    folderName:
                                                        _controller.text.trim(),
                                                    userId: 0,
                                                    classId: 0);
                                            bool rs = await FolderService()
                                                .modifyFolder(request);
                                            if (rs) {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                SnackBar(
                                                  width: 2.6 *
                                                      MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      4,
                                                  behavior:
                                                      SnackBarBehavior.floating,
                                                  content: const Text(
                                                    'Cập nhật thư mục thành công',
                                                    textAlign: TextAlign.center,
                                                  ),
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              14)),
                                                  duration: const Duration(
                                                      seconds: 2),
                                                ),
                                              );
                                              folderStream.notifyDataChanged();
                                              Navigator.pop(context);
                                            } else {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                SnackBar(
                                                  width: 2.6 *
                                                      MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      4,
                                                  behavior:
                                                      SnackBarBehavior.floating,
                                                  content: const Text(
                                                    'Xảy ra lỗi trong quá trình cập nhật',
                                                    textAlign: TextAlign.center,
                                                  ),
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              14)),
                                                  duration: const Duration(
                                                      seconds: 2),
                                                ),
                                              );
                                            }
                                          }
                                        },
                                        style: TextButton.styleFrom(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 16, vertical: 10),
                                          textStyle: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                              color: Color.fromRGBO(
                                                  153, 162, 232, 1)),
                                          backgroundColor: Colors.transparent,
                                        ),
                                        child: const Text(
                                          "LƯU",
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      });
                } else if (value == 2) {}
              },
              itemBuilder: (BuildContext context) => [
                const PopupMenuItem<int>(
                  value: 1,
                  child: Text(
                    "Chỉnh sửa",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                const PopupMenuItem<int>(
                  value: 2,
                  child: Text(
                    "Xóa",
                    style: TextStyle(color: Colors.red),
                  ),
                )
              ],
            ),
          ],
        ),
        body: SafeArea(
          child: StreamBuilder<void>(
              stream: folderStream.stream,
              builder: (context, folderSnapshot) {
                return StreamBuilder<void>(
                    stream: studySetStream.stream,
                    builder: (context, studySetSnapshot) {
                      return FutureBuilder(
                          future: fetchData(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.done) {
                              if (folder.value != null) {
                                print(
                                    "${studySets.value!.length} - ${folder.value!.folderId}");
                              }
                              return Container(
                                height: MediaQuery.of(context).size.height,
                                color: const Color.fromRGBO(10, 8, 45, 1),
                                child: SingleChildScrollView(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: double.infinity,
                                        color:
                                            const Color.fromRGBO(46, 55, 86, 1),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 15),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const SizedBox(
                                                height: 12,
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    "${studySets.value!.length} học phần",
                                                    style: const TextStyle(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: Colors.white),
                                                  ),
                                                  const SizedBox(
                                                    width: 4,
                                                  ),
                                                  Container(
                                                    color: Colors.grey.shade900,
                                                    width: 1,
                                                    height: 20,
                                                  ),
                                                  const SizedBox(
                                                    width: 4,
                                                  ),
                                                  if (folder.value != null) ...[
                                                    Container(
                                                      height: 30,
                                                      width: 30,
                                                      clipBehavior:
                                                          Clip.antiAlias,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      15)),
                                                      child: CircleAvatar(
                                                        child: Image.memory(
                                                            convertBase64ToUint8List(
                                                                folder
                                                                    .value!
                                                                    .user
                                                                    .image)),
                                                      ),
                                                    )
                                                  ],
                                                  const SizedBox(
                                                    width: 8,
                                                  ),
                                                  Text(
                                                    folder.value != null
                                                        ? folder.value!.user
                                                            .username
                                                        : '',
                                                    style: const TextStyle(
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: Colors.white),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 12,
                                              ),
                                              Text(
                                                folder.value != null
                                                    ? folder.value!.folderName
                                                    : '',
                                                style: const TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.w700,
                                                    color: Colors.white),
                                              ),
                                              const SizedBox(
                                                height: 20,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 15, vertical: 16),
                                        child:
                                            Column(children: _loadStudySets()),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            }
                            return const SpinKitCircle(
                              size: 50,
                              color: Colors.blue,
                            );
                          });
                    });
              }),
        ));
  }
}
