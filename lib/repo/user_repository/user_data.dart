class UserData {
  String displayName;
  String token;
  String role;
  String id;
  String avatar;
  String address;
  String phone;

  UserData({
    required this.displayName,
    required this.token,
    required this.role,
    required this.id,
    required this.avatar,
    required this.address,
    required this.phone,
  });
  factory UserData.fromJson(Map<String, dynamic> map) {
    return UserData(
        displayName: map['full_name'],
        token: map['token'],
        role: map['role'],
        id: map['id'],
        avatar: map['avatar'],
        address: map['address'],
        phone: map['email']);
  }
  factory UserData.fromJsonInfo(Map<String, dynamic> map) {
    return UserData(
        displayName: map['full_name'],
        role: map['role'],
        id: map['id'],
        avatar: map['avatar'],
        address: map['address'],
        phone: map['email'],
        token: "");
  }
}
