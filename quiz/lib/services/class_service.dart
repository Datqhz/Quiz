import 'dart:convert';

import 'package:http/http.dart';
import 'package:quiz/models/class.dart';
import 'package:quiz/models/user.dart';
import 'package:quiz/shared/global_variable.dart';
import 'package:quiz/utilities/shared_preference_utils.dart';

class ClassService {
  Future<Class?> getClassById(int id) async {
    String? token = await getToken();
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      "Authorization": "Bearer $token"
    };
    Response response = await get(
        Uri.parse("${GlobalVariable.url}/api/class/$id"),
        headers: headers);
    int statusCode = response.statusCode;
    if (statusCode != 200) {
      return null;
    }
    final Map<String, dynamic> data = json.decode(response.body);

    var e_class = Class.fromJson(data['dt']);
    return e_class;
  }


  Future<bool> createClass(ClassRequest classRequest) async {
    UserInfo? user = await getUserInfo();
    String? token = await getToken();
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      "Authorization": "Bearer $token"
    };
    Response response = await post(
        Uri.parse("${GlobalVariable.url}/api/class"),
        headers: headers,
        body: jsonEncode(<String, dynamic>{
          "className": classRequest.className,
          "userId": user!.userId,
          "description": classRequest.description
          }));
    int statusCode = response.statusCode;
    if (statusCode != 201) {
      return false;
    }
    return true;
  }

Future<bool> modifyClass(ClassRequest classRequest) async {
    UserInfo? user = await getUserInfo();
    String? token = await getToken();
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      "Authorization": "Bearer $token"
    };
    Response response = await put(
        Uri.parse("${GlobalVariable.url}/api/class"),
        headers: headers,
        body: jsonEncode(<String, dynamic>{
          "id": classRequest.classId,
          "className": classRequest.className,
          "description": classRequest.description
          }));
    int statusCode = response.statusCode;
    if (statusCode != 200) {
      return false;
    }
    return true;
  }


  Future<bool> deleteClass(int classId) async {
    String? token = await getToken();
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      "Authorization": "Bearer $token"
    };
    Response response = await delete(
        Uri.parse("${GlobalVariable.url}/api/class/$classId"),
        headers: headers);
    int statusCode = response.statusCode;
    if (statusCode != 200) {
      return false;
    }
    return true;
  }

  Future<List<Class>?> getAllClassUserIdJoined(int id,
      {int page = 0, int limit = 0}) async {
    String url = "${GlobalVariable.url}/api/class/user-joined/$id";
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
    List<Class> list =
        (data['dt']['classes'] as List).map((e) => Class.fromJson(e)).toList();
    return list;
  }
   Future<List<Class>?> getAllClassByOwnerId(int id) async {
    String url = "${GlobalVariable.url}/api/class/user-own/$id";
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
    List<Class> list =
        (data['dt'] as List).map((e) => Class.fromJson(e)).toList();
    return list;
  }
}
