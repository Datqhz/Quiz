class Account {
  int accountId;
  String email;
  Account({required this.accountId, required this.email});

  Map<String, dynamic> toJson() => {
    'accountId': accountId,
    'email': email
  };
  factory Account.fromJson(Map<String, dynamic> json) => Account(
    accountId: json['accountId'],
    email: json['email']
  );
}