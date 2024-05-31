class UserInfo {
  int userId;
  String username;
  String image;
  DateTime? createDate;
  int? groupId;
  int? accountId;
  UserInfo({required this.userId, required this.username,
   required this.image, this.createDate, this.groupId, this.accountId});

   Map<String, dynamic> toJson() => {
      'userId': userId,
      "username": username,
      'image': image,
      'createDate': createDate,
      'groupId': groupId,
      'accountId': accountId
   };
   factory UserInfo.fromJson(Map<String, dynamic> json) => UserInfo(
    userId: json['userId'],
    username: json['userName'],
    image: json['image'],
   );
}