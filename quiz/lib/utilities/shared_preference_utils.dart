
import 'dart:convert';

import 'package:quiz/models/account.dart';
import 'package:quiz/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> storeUserInfo(UserInfo user) async
{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String userJson = jsonEncode(user.toJson());
  await prefs.setString('user', userJson);
}

Future<UserInfo?> getUserInfo() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? userJson = await prefs.getString('user');
  if(userJson == null){
    return null;
  }
  Map<String, dynamic> userMap = jsonDecode(userJson);
  return UserInfo.fromJson(userMap);
}

Future<void> storeToken(String token) async
{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('token', token);
}

Future<String?> getToken() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? token = await prefs.getString('token');
  return token;
}

Future<void> storeAccount(Account account) async
{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String accountJson = jsonEncode(account.toJson());
  await prefs.setString('account', accountJson);
}

Future<Account?> getAccount() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? accountJson = await prefs.getString('account');
  if(accountJson == null){
    return null;
  }
  Map<String, dynamic> accountMap = jsonDecode(accountJson);
  return Account.fromJson(accountMap);
}

String token = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJqdGkiOiIxZDAyNWNiNC0wNjQwLTQ5NWItOTA1MC1lMzExZDE2NTBlZjAiLCJzdWIiOiJlQGdtYWlsLmNvbSIsImVtYWlsIjoiZUBnbWFpbC5jb20iLCJhY2NvdW50aWQiOiI0IiwiZ3JvdXAiOiJ0ZWFjaGVyIiwibmJmIjoxNzE3MTQyNzcxLCJleHAiOjE3MTcyMjkxNzEsImlhdCI6MTcxNzE0Mjc3MSwiaXNzIjoiUXVpei5NaWNyb3NlcnZpY2UiLCJhdWQiOiIwOTBkZjM1ZmRjYTQ3YjAxYzgwYWU4NzE4ZTA3MWE2NzZiMmI0MmFjNzg5ZGUyODQ2YzUwZTBjMjljM2JjODlkIn0.JqOSnLQwvnbt76k9zWZldzI_C6H8bWIIaRRtTSJdspk';