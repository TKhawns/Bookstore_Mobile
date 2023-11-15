class UserData {
  String displayName;
  String token;
  String role;
  String id;

  UserData(
      {required this.displayName,
      required this.token,
      required this.role,
      required this.id});
  factory UserData.fromJson(Map<String, dynamic> map) {
    return UserData(
        displayName: map['full_name'],
        token: map['token'],
        role: map['role'],
        id: map['id']);
  }
}
