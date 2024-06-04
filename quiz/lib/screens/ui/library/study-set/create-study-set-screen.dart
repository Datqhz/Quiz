import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quiz/models/card.dart';
import 'package:quiz/models/study_set.dart';
import 'package:quiz/providers/notify_change_provider.dart';
import 'package:quiz/services/study_set_service.dart';

class CreateStudySet extends StatefulWidget {
  CreateStudySet({super.key, required this.changeStream, this.folderId});

  NotifyChangeStream changeStream;
  int? folderId;
  @override
  State<CreateStudySet> createState() => _CreateStudySetState();
}

class _CreateStudySetState extends State<CreateStudySet> {
  int idx = 0;
  List<FlashCard> cards = [];
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  Future<bool> _createStudySet() async {
    List<MyCard> mycards = [];
    cards.forEach((element) {
      mycards.add(element.getCardInfo());
    });
    StudySetRequest studySet = StudySetRequest(
        studySetId: 0,
        studySetName: _nameController.text.trim(),
        cards: mycards);
    if(widget.folderId!=null){
      return await StudySetService().createStudySetAndAddToFolder(studySet, widget.folderId!);
    }
    return await StudySetService().createStudySet(studySet);
  }

  void removeCard(int idxRemove) {
    cards.removeWhere((widget) {
      return widget.idx == idxRemove;
    });
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(46, 55, 86, 1),
      body: SafeArea(
        child: Stack(
          children: [
            Form(
              key: _formKey,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                color: const Color.fromRGBO(10, 8, 45, 1),
                child: ListView(
                  children: [
                    const SizedBox(
                      height: 80,
                    ),
                    const Text(
                      'TIÊU ĐỀ',
                      style: TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                          fontWeight: FontWeight.w500),
                    ),
                    TextFormField(
                        controller: _nameController,
                        decoration: InputDecoration(
                            hintText: 'Chủ đề, chương',
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
                                    BorderSide(color: Colors.white, width: 2))),
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          decoration: TextDecoration.none,
                          decorationThickness: 0,
                        ),
                        validator: (value) {
                          if (value!.trim().isEmpty) {
                            return "Vui lòng nhập tên học phần";
                          }
                          return null;
                        }),
                    const SizedBox(
                      height: 40,
                    ),
                    ...cards
                  ],
                ),
              ),
            ),
            Positioned(
              child: Container(
                  height: 60,
                  color: const Color.fromRGBO(46, 55, 86, 1),
                  child: Row(children: [
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          CupertinoIcons.arrow_left,
                          color: Colors.white,
                        )),
                    const SizedBox(
                      width: 8,
                    ),
                    const Text(
                      'Tạo học phần',
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.w600),
                    ),
                    const Expanded(
                        child: SizedBox(
                      height: 1,
                    )),
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          CupertinoIcons.gear,
                          color: Colors.white,
                        )),
                    IconButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            bool rs = await _createStudySet();
                            if (rs) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  width: 2.6 *
                                      MediaQuery.of(context).size.width /
                                      4,
                                  behavior: SnackBarBehavior.floating,
                                  content: const Text(
                                    'Tạo học phần thành công',
                                    textAlign: TextAlign.center,
                                  ),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(14)),
                                  duration: const Duration(seconds: 2),
                                ),
                              );
                              widget.changeStream.notifyDataChanged();
                              Navigator.pop(context);
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  width: 2.6 *
                                      MediaQuery.of(context).size.width /
                                      4,
                                  behavior: SnackBarBehavior.floating,
                                  content: const Text(
                                    'Xảy ra lỗi trong quá trình tạo.',
                                    textAlign: TextAlign.center,
                                  ),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(14)),
                                  duration: const Duration(seconds: 2),
                                ),
                              );
                            }
                          }
                        },
                        icon: const Icon(
                          CupertinoIcons.checkmark_alt,
                          color: Colors.white,
                        )),
                  ])),
            ),
            Positioned(
              bottom: 15,
              right: 15,
              child: Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                    color: const Color.fromRGBO(67, 85, 255, 1),
                    borderRadius: BorderRadius.circular(50)),
                child: IconButton(
                  onPressed: () {
                    cards.add(FlashCard(
                      idx: idx,
                      onDelete: removeCard,
                    ));
                    idx += 1;
                    setState(() {});
                  },
                  icon: const Icon(
                    CupertinoIcons.add,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class FlashCard extends StatelessWidget {
  FlashCard({super.key, required this.idx, required this.onDelete});

  int idx;
  final Function onDelete;
  final TextEditingController _termController = TextEditingController();
  final TextEditingController _defineController = TextEditingController();

  MyCard getCardInfo() {
    return MyCard(
        cardId: 0,
        term: _termController.text,
        definition: _defineController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
          color: const Color.fromRGBO(46, 55, 86, 1),
          borderRadius: BorderRadius.circular(3)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            controller: _termController,
            decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: Colors.white.withOpacity(0.6), width: 1)),
                focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white, width: 2))),
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
            height: 8,
          ),
          const Text(
            'THUẬT NGỮ',
            style: TextStyle(
                fontSize: 14, color: Colors.white, fontWeight: FontWeight.w500),
          ),
          const SizedBox(
            height: 10,
          ),
          TextFormField(
            controller: _defineController,
            decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: Colors.white.withOpacity(0.6), width: 1)),
                focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white, width: 2))),
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
            height: 8,
          ),
          const Text(
            'ĐỊNH NGHĨA',
            style: TextStyle(
                fontSize: 14, color: Colors.white, fontWeight: FontWeight.w500),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                onPressed: () => onDelete(idx),
                icon: const Icon(
                  CupertinoIcons.trash,
                  color: Colors.red,
                  size: 18,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
