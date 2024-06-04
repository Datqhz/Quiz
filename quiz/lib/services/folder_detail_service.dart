import 'dart:convert';

import 'package:http/http.dart';
import 'package:quiz/shared/global_variable.dart';
import 'package:quiz/utilities/shared_preference_utils.dart';

class FolderDetailService {
  Future<bool> addStudySetToFolder(int studySetId, int folderId) async {
    String? token = await getToken();
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      "Authorization": "Bearer $token"
    };
    Response response =
        await post(Uri.parse("${GlobalVariable.url}/api/folder-detail"),
            headers: headers,
            body: jsonEncode(<String, dynamic>{
              "studySetId": studySetId,
              "folderId": folderId,
            }));
    int statusCode = response.statusCode;
    if (statusCode != 201) {
      return false;
    }
    return true;
  }
  Future<bool> addStudySetToFolders(int studySetId, List<int> folderIds) async {
    String? token = await getToken();
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      "Authorization": "Bearer $token"
    };
    Response response =
        await post(Uri.parse("${GlobalVariable.url}/api/folder-detail/folders"),
            headers: headers,
            body: jsonEncode(<String, dynamic>{
              "studySetId": studySetId,
              "folderIds": folderIds.toList(),
            }));
    int statusCode = response.statusCode;
    if (statusCode != 201) {
      return false;
    }
    return true;
  }
    Future<bool> addStudySetsToFolder(List<int> studySetIds,  int folderId) async {
    String? token = await getToken();
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      "Authorization": "Bearer $token"
    };
    Response response =
        await post(Uri.parse("${GlobalVariable.url}/api/folder-detail/studySets"),
            headers: headers,
            body: jsonEncode(<String, dynamic>{
              "studySetIds": studySetIds,
              "folderId": folderId,
            }));
    int statusCode = response.statusCode;
    if (statusCode != 201) {
      return false;
    }
    return true;
  }
}
