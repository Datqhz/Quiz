import 'package:intl/intl.dart';
import 'package:quiz/models/class.dart';
import 'package:quiz/models/user.dart';

class Folder{
  int folderId;
  String folderName;
  DateTime? createDate;
  UserInfo user;
  Class? e_class;

  Folder({required this.folderId, required this.folderName, required this.user, this.createDate, this.e_class});
  factory Folder.fromJson(Map<String, dynamic> json) => Folder(
    folderId: json['id'],
    folderName: json['folderName'],
    createDate: json['createDate']!= null? DateFormat('dd-MM-yyyy').parse(json['createDate']): null,
    user: UserInfo.fromJson(json['user']),
    e_class:  json['e_class']!=null? Class.fromJson(json['class']): null
  );
}

class FolderRequest{
  int folderId;
  String folderName;
  int userId;
  int classId;

  FolderRequest({required this.folderId, required this.folderName, required this.userId, required this.classId});
}

