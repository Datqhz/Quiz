import 'package:intl/intl.dart';
import 'package:quiz/models/card.dart';
import 'package:quiz/models/user.dart';

class StudySet {
  int studySetId;
  String studySetName;
  DateTime createDate;
  UserInfo user;
  List<MyCard> cards;
  StudySet(
      {required this.studySetId,
      required this.studySetName,
      required this.createDate,
      required this.user,
      required this.cards});
  factory StudySet.fromJson(Map<String, dynamic> json) => StudySet(
      studySetId: json['id'],
      studySetName: json['studySetName'],
      createDate: DateFormat('dd-MM-yyyy').parse(json['createDate']),
      user: UserInfo.mapInStudySet(json['user']),
      cards: (json['cards'] as List).map((e) => MyCard.fromJson(e)).toList());
}
