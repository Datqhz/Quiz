import 'dart:convert';

import 'package:http/http.dart';
import 'package:quiz/models/study_set.dart';
import 'package:quiz/shared/global_variable.dart';
import 'package:quiz/utilities/shared_preference_utils.dart';

class StudySetService {
  Future<StudySet?> getStudySetById(int id) async {
    String? token = await getToken();
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      "Authorization": "Bearer $token"
    };
    Response response = await post(
        Uri.parse("${GlobalVariable.url}/api/user/$id"),
        headers: headers);
    int statusCode = response.statusCode;
    if (statusCode != 200) {
      return null;
    }
    final Map<String, dynamic> data = json.decode(response.body);

    var user = StudySet.fromJson(data['dt']);
    return user;
  }

  Future<List<StudySet>?> getAllStudySetByUserId(int id,
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
    List<StudySet> list =
        (data['dt']['studySets'] as List).map((e) => StudySet.fromJson(e)).toList();
    return list;
  }
}
