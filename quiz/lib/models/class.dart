import 'package:intl/intl.dart';
import 'package:quiz/models/user.dart';

class Class{
  int classId;
  String className;
  DateTime? createDate;
  String description;
  UserInfo user;
  int? NumOfFolder;
  int? NumOfMember;
  Class({required this.classId, required this.className, required this.description, required this.user, this.createDate, this.NumOfMember, this.NumOfFolder});

  factory Class.fromJson(Map<String, dynamic> json) => Class(
    classId: json['id'],
    className: json['className'],
    description: json['description'],
    user: UserInfo.fromJson(json['user']),
    createDate: json['createDate']!= null? DateFormat('dd-MM-yyyy').parse(json['createDate']): null,
    NumOfFolder: json['numOfFolder'],
    NumOfMember: json['numOfMember']
  );
}

class ClassRequest{
  int classId;
  String className;
  String description;

  ClassRequest({required this.classId, required this.className, required this.description});
}
