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
      user: UserInfo.fromJson(json['user']),
      cards: (json['cards'] as List).map((e) => MyCard.fromJson(e)).toList());
}

class StudySetBrief {
  int studySetId;
  String studySetName;
  DateTime createDate;
  UserInfo user;
  int totalCards;
  StudySetBrief(
      {required this.studySetId,
      required this.studySetName,
      required this.createDate,
      required this.user,
      required this.totalCards});
  factory StudySetBrief.fromJson(Map<String, dynamic> json) => StudySetBrief(
      studySetId: json['id'],
      studySetName: json['studySetName'],
      createDate: DateFormat('dd-MM-yyyy').parse(json['createDate']),
      user: UserInfo.fromJson(json['user']),
      totalCards: json['totalCards']);
}

class StudySetRequest {
  int studySetId;
  String studySetName;
  List<MyCard> cards;
  StudySetRequest(
      {required this.studySetId,
      required this.studySetName,
      required this.cards});
}

class StudySetModify {
  int studySetId;
  String studySetName;
  List<CardModify> cards;
  StudySetModify(
      {required this.studySetId,
      required this.studySetName,
      required this.cards});
}

