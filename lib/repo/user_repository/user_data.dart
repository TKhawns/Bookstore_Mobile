class UserData {
  String displayName;
  String token;

  UserData({required this.displayName, required this.token});
  factory UserData.fromJson(Map<String, dynamic> map) {
    return UserData(displayName: map['full_name'], token: map['token']);
  }
}
