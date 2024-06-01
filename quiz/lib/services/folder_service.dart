import 'dart:convert';

import 'package:http/http.dart';
import 'package:quiz/models/folder.dart';
import 'package:quiz/models/user.dart';
import 'package:quiz/shared/global_variable.dart';
import 'package:quiz/utilities/shared_preference_utils.dart';

class FolderService {

  Future<Folder?> getFolderById(int id) async {
    String? token = await getToken();
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      "Authorization": "Bearer $token"
    };
    Response response = await get(
        Uri.parse("${GlobalVariable.url}/api/folder/$id"),
        headers: headers);
    int statusCode = response.statusCode;
    if (statusCode != 200) {
      return null;
    }
    final Map<String, dynamic> data = json.decode(response.body);

    var folder = Folder.fromJson(data['dt']);
    return folder;
  }

  Future<bool> createFolder(FolderRequest folder) async {
    UserInfo? user = await getUserInfo();
    String? token = await getToken();
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      "Authorization": "Bearer $token"
    };
    Response response = await post(
        Uri.parse("${GlobalVariable.url}/api/folder"),
        headers: headers,
        body: jsonEncode(<String, dynamic>{
          "folderName": folder.folderName,
          "userId": user!.userId,
          "classId": folder.classId
          }));
    int statusCode = response.statusCode;
    if (statusCode != 201) {
      return false;
    }
    return true;
  }

  Future<List<Folder>?> getAllFolderOfClass(int id,
      {int page = 0, int limit = 0}) async {
    String url = "${GlobalVariable.url}/api/folder/class/$id";
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
