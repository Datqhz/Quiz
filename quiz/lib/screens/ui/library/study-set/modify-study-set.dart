import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quiz/models/card.dart';
import 'package:quiz/models/study_set.dart';
import 'package:quiz/providers/notify_change_provider.dart';
import 'package:quiz/services/study_set_service.dart';

class ModifyStudySet extends StatefulWidget {
  ModifyStudySet(
      {super.key, required this.changeStream, required this.studySet});

  NotifyChangeStream changeStream;
  StudySet studySet;
  @override
  State<ModifyStudySet> createState() => _ModifyStudySetState();
}

class _ModifyStudySetState extends State<ModifyStudySet> {
  ValueNotifier idx = ValueNotifier(0);
  List<FlashCardModify> cards = [];
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  List<CardModify> cardsDelete = [];

  Future<bool> _modifyStudySet() async {
    List<CardModify> mycards = [];
    mycards.addAll(cardsDelete);
    for (var element in cards) {
      mycards.add(element.getCardInfo());
    }
    StudySetModify modify = StudySetModify(studySetId: widget.studySet.studySetId,
     studySetName: _nameController.text.trim(), 
     cards: mycards);
    return await StudySetService().modifyStudySet(modify);
  }

  _loadCards() {
    for (var card in widget.studySet.cards) {
      cards.add(FlashCardModify(
        idx: idx.value,
        onDelete: removeCard,
        card: ValueNotifier(card.mapToCardModify()),
      ));
      idx.value += 1;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadCards();
    _nameController.text = widget.studySet.studySetName;
  }

  void removeCard(int idxRemove) {
    cards.removeWhere((widget) {
      if (widget.idx == idxRemove) {
        if (widget.card != null) {
          cardsDelete.add(widget.card!.value);
        }
        return true;
      }
      return false;
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
                            bool rs = await _modifyStudySet();
                            if (rs) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  width: 2.6 *
                                      MediaQuery.of(context).size.width /
                                      4,
                                  behavior: SnackBarBehavior.floating,
                                  content: const Text(
                                    'Cập nhật học phần thành công',
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
                                    'Xảy ra lỗi trong quá trình cập nhật.',
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
                    cards.add(FlashCardModify(
                      idx: idx.value,
                      onDelete: removeCard,
                    ));
                    idx.value += 1;
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

class FlashCardModify extends StatelessWidget {
  FlashCardModify(
      {super.key, required this.idx, required this.onDelete, this.card});

  ValueNotifier<CardModify>? card;

  int idx;
  final Function onDelete;
  final TextEditingController _termController = TextEditingController();
  final TextEditingController _defineController = TextEditingController();

  CardModify getCardInfo() {
    CardModify rs = CardModify(
        cardId: card != null ? card!.value.cardId : 0,
        term: _termController.text,
        definition: _defineController.text,
        option: option());
    return rs;
  }

  int option() {
    if (card != null) {
      if (_termController.text.trim() != card!.value.term ||
          _defineController.text.trim() != card!.value.definition) {
        return 1;
      }
      return 3;
    }

    return 0;
  }

  @override
  Widget build(BuildContext context) {
    if (card != null) {
      _termController.text = card!.value.term;
      _defineController.text = card!.value.definition;
    }
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
                onPressed: () {
                  if (card != null) {
                    var temp = card!.value;
                    card!.value = CardModify(
                        cardId: temp.cardId,
                        term: temp.term,
                        definition: temp.definition,
                        option: 2);
                  }
                  onDelete(idx);
                },
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
