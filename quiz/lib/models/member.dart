import 'package:quiz/models/class.dart';
import 'package:quiz/models/user.dart';

class Member{
  int memberId;
  UserInfo user;
  Class e_class;
  
  Member({required this.memberId, required this.user,required this.e_class});

  factory Member.fromJson(Map<String, dynamic> json) => Member(
    memberId: json['id'],
    user: UserInfo.fromJson(json['member']),
    e_class: Class.fromJson(json['class'])
  );
}