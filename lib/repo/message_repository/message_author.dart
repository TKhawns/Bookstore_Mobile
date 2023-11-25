class AuthorMessage {
  String firstName;
  String id;
  AuthorMessage({required this.id, required this.firstName});
  factory AuthorMessage.fromJson(Map<String, dynamic> map) {
    return AuthorMessage(
      firstName: map['firstName'],
      id: map['id'],
    );
  }
}
