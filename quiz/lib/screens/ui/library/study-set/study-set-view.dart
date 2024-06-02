import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:quiz/models/user.dart';
import 'package:quiz/providers/notify_change_provider.dart';
import 'package:quiz/providers/study_set_provider.dart';
import 'package:quiz/services/study_set_service.dart';
import 'package:quiz/utilities/shared_preference_utils.dart';
import 'package:quiz/widgets/study-set-widget.dart';

class StudySetView extends StatefulWidget {
  StudySetView({super.key, required this.studySetStream});

  NotifyChangeStream studySetStream;
  @override
  State<StudySetView> createState() => _StudySetViewState();
}

class _StudySetViewState extends State<StudySetView> {
  List<String> _sorts = ['Tất cả', 'Đã tạo', 'Đã học', 'Đã tải về'];
  String _sort = 'Tất cả';

  
  ValueNotifier studySets = ValueNotifier([]);

  @override
  void initState() {
    super.initState();
    // personalStream.notifyDataChanged();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> fetchData() async {
    UserInfo? user = await getUserInfo();
    studySets.value =
        await StudySetService().getAllStudySetByUserId(user!.userId);
  }

  List<Widget> _loadStudySets() {
    List<Widget> rs = [];
    for (var studySet in studySets.value) {
      rs.add(StudySetWidget(itemColor: Colors.transparent, studySet: studySet, studySetStream: widget.studySetStream,));
      rs.add(const SizedBox(
        height: 8,
      ));
    }
    return rs;
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<void>(
      stream: widget.studySetStream.stream,
      builder: (context, snapshot) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          color: const Color.fromRGBO(10, 8, 45, 1),
          child: FutureBuilder(
              future: fetchData(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 110,
                        ),
                        Container(
                          constraints: const BoxConstraints(
                              maxWidth: 150, maxHeight: 40),
                          // Limit the width
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4.0),
                            border: Border.all(
                              color: const Color.fromRGBO(46, 55, 86, 1),
                              style: BorderStyle.solid,
                              width: 2,
                            ),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton(
                              items: _sorts
                                  .map((value) => DropdownMenuItem(
                                        value: value,
                                        child: Text(
                                          value,
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 13),
                                        ),
                                      ))
                                  .toList(),
                              onChanged: (String? value) {},
                              value: _sorts.first,
                              icon: const Icon(
                                CupertinoIcons.chevron_down,
                                color: Colors.white,
                                size: 14,
                              ),
                              dropdownColor:
                                  const Color.fromRGBO(46, 55, 86, 1),
                            ),
                          ),
                        ),
                        const SizedBox(
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
                                  borderSide: BorderSide(
                                      color: Colors.white.withOpacity(0.6),
                                      width: 1)),
                              focusedBorder: const UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.white, width: 1))
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
                        const SizedBox(
                          height: 20,
                        ),
                        ..._loadStudySets(),
                        const SizedBox(
                          height: 8,
                        ),
                      ],
                    ),
                  );
                }
                return const SpinKitCircle(
                  color: Colors.blue,
                  size: 50,
                );
              }),
        );
      },
    );
  }
}
