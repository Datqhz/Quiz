import 'dart:convert';
import 'dart:math';

import 'package:http/http.dart';
import 'package:quiz/models/study_set.dart';
import 'package:quiz/models/user.dart';
import 'package:quiz/shared/global_variable.dart';
import 'package:quiz/utilities/shared_preference_utils.dart';

class StudySetService {
  Future<StudySet?> getStudySetById(int id) async {
    String? token = await getToken();
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      "Authorization": "Bearer $token"
    };
    Response response = await get(
        Uri.parse("${GlobalVariable.url}/api/study-set/$id"),
        headers: headers);
    int statusCode = response.statusCode;
    if (statusCode != 200) {
      return null;
    }
    final Map<String, dynamic> data = json.decode(response.body);

    var studySet = StudySet.fromJson(data['dt']);
    return studySet;
  }

  Future<bool> createStudySet(StudySetRequest studySet) async {
    UserInfo? user = await getUserInfo();
    String? token = await getToken();
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      "Authorization": "Bearer $token"
    };
    Response response = await post(
        Uri.parse("${GlobalVariable.url}/api/study-set"),
        headers: headers,
        body: jsonEncode(<String, dynamic>{
          "studySetName": studySet.studySetName,
          "userId": user!.userId,
          "cards": studySet.cards
              .map((card) => {'term': card.term, 'definition': card.definition})
              .toList()
        }));
    int statusCode = response.statusCode;
    if (statusCode != 201) {
      return false;
    }
    return true;
  }

  Future<List<StudySetBrief>?> getAllStudySetByUserId(int id,
      {int page = 0, int limit = 0}) async {
    String url = "${GlobalVariable.url}/api/study-set/user/$id";
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
    List<StudySetBrief> list = (data['dt']['studySets'] as List)
        .map((e) => StudySetBrief.fromJson(e))
        .toList();
    return list;
  }

  Future<List<StudySetBrief>?> getAllStudySetByFolderId(int id,
      {int page = 0, int limit = 0}) async {
    String url = "${GlobalVariable.url}/api/study-set/folder/$id";
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
    List<StudySetBrief> list = (data['dt']['studySets'] as List)
        .map((e) => StudySetBrief.fromJson(e))
        .toList();
    return list;
  }
}
