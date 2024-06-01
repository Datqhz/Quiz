class UserInfo {
  int userId;
  String username;
  String image;
  DateTime? createDate;
  int? groupId;
  int? accountId;
  UserInfo(
      {required this.userId,
      required this.username,
      required this.image,
      this.createDate,
      this.groupId,
      this.accountId});

  Map<String, dynamic> toJson() => {
        'id': userId,
        "userName": username,
        'image': image,
        'createDate': createDate,
        'groupId': groupId,
        'accountId': accountId
      };
  factory UserInfo.fromJson(Map<String, dynamic> json) => UserInfo(
        userId: json['id'],
        username: json['userName'],
        image: json['image'],
      );
  static UserInfo mapInLogin(Map<String, dynamic> json) => UserInfo(
        userId: json['userId'],
        username: json['userName'],
        image: json['image'],
      );
}
