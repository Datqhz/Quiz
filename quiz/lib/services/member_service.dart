import 'dart:convert';

import 'package:http/http.dart';
import 'package:quiz/models/folder.dart';
import 'package:quiz/models/member.dart';
import 'package:quiz/shared/global_variable.dart';
import 'package:quiz/utilities/shared_preference_utils.dart';

class MemberService {

Future<List<Member>?> getAllMemberOfClass(int id) async {
    String url = "${GlobalVariable.url}/api/member/class/$id";
    String? token = await getToken();
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      "Authorization": "Bearer $token"
    };
    Response response = await get(Uri.parse(url), headers: headers);
    int statusCode = response.statusCode;
    if (statusCode != 200) {
      return null;
    }
    final Map<String, dynamic> data = json.decode(response.body);
    List<Member> list =
        (data['dt'] as List).map((e) => Member.fromJson(e)).toList();
    return list;
  }

  Future<List<Folder>?> getAllFolderOfUserId(int id,
      {int page = 0, int limit = 0}) async {
    String url = "${GlobalVariable.url}/api/folder/user/$id";
    if (!(page == 0 || limit == 0)) {
      url += "?page=$page&limit=$limit";
    }
    String? token = await getToken();
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      "Authorization": "Bearer $token"
    };
    Response response = await get(Uri.parse(url), headers: headers);
    int statusCode = response.statusCode;
    if (statusCode != 200) {
      return null;
    }
    final Map<String, dynamic> data = json.decode(response.body);
    List<Folder> list =
        (data['dt']['folders'] as List).map((e) => Folder.fromJson(e)).toList();
    return list;
  }
}
