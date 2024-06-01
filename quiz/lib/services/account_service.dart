import 'dart:convert';

import 'package:http/http.dart';
import 'package:quiz/models/account.dart';
import 'package:quiz/models/user.dart';
import 'package:quiz/shared/global_variable.dart';
import 'package:quiz/utilities/shared_preference_utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AccountService {
  Future<bool> signIn(String email, String password) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
    };
    Response response =
        await post(Uri.parse("${GlobalVariable.url}/api/account/login"),
            headers: headers,
            body: jsonEncode(<String, dynamic>{
              "email": email,
              "password": password,
              // Add any other data you want to send in the body
            }));
    int statusCode = response.statusCode;
    if (statusCode != 200) {
      return false;
    }
    final Map<String, dynamic> data = json.decode(response.body);

    var user = UserInfo.mapInLogin(data['dt']);
    print("user name: ${user.username}");
    await storeUserInfo(user);
    var account = Account.fromJson(data['dt']);
    await storeAccount(account);
    await storeToken(data['dt']['token']);
    return true;
  }

  Future<bool> signUp(
      String email, String password, String userName, int groupId) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
    };
    Response response =
        await post(Uri.parse("${GlobalVariable.url}/api/account"),
            headers: headers,
            body: jsonEncode(<String, dynamic>{
              "email": email,
              "password": password,
              "username": userName,
              "groupid": groupId,
            }));
    int statusCode = response.statusCode;
    if (statusCode != 201) {
      return false;
    }
    return true;
  }

  Future<bool> updateAccount(String newPassword, String oldPassword) async {
    Account? account = await getAccount();
    String? token = await getToken();
    print("token $token");
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      "Authorization": "Bearer $token"
    };
    Response response =
        await put(Uri.parse("${GlobalVariable.url}/api/account"),
            headers: headers,
            body: jsonEncode(<String, dynamic>{
              'id': account!.accountId,
              "email": account.email,
              "oldpassword": oldPassword,
              "newpassword": newPassword,
            }));
    int statusCode = response.statusCode;
    if (statusCode != 200) {
      return false;
    }
    return true;
  }
}
