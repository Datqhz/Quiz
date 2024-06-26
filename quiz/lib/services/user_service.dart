import 'dart:convert';

import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:quiz/models/user.dart';
import 'package:quiz/shared/global_variable.dart';
import 'package:quiz/utilities/image_utils.dart';
import 'package:quiz/utilities/shared_preference_utils.dart';

class UserService {

  
  Future<UserInfo?> getUserById(int id) async {
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

    var user = UserInfo.fromJson(data['dt']);
    return user;
  }

  Future<bool> updateUser(String username, {XFile? image}) async {
    String imageAsBase64 = '';
    UserInfo? user = await getUserInfo();
    if (image != null) {
      imageAsBase64 = await convertToBase64(image);
    }
    String? token = await getToken();
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      "Authorization": "Bearer $token"
    };
    Response response = await put(Uri.parse("${GlobalVariable.url}/api/user"),
        headers: headers,
        body: jsonEncode(<String, dynamic>{
          'id': user!.userId,
          "username": username,
          "image": imageAsBase64,
        }));
    int statusCode = response.statusCode;
    if (statusCode != 200) {
      return false;
    }
    return true;
  }
}
