class AuthorData {
  int author_id;
  String full_name;
  String description;
  String image;
  int number_books;
  String link_youtube;

  AuthorData(
      {required this.author_id,
      required this.full_name,
      required this.description,
      required this.image,
      required this.number_books,
      required this.link_youtube});

  static List<AuthorData> parseAuthorDataList(map) {
    var list = map["data"] as List;
    return list.map((author) => AuthorData.fromJson(author)).toList();
  }

  factory AuthorData.fromJson(Map<String, dynamic> map) {
    return AuthorData(
        author_id: int.parse(map["author_id"].toString()),
        full_name: map["full_name"],
        description: map["description"],
        image: map["image"],
        number_books: int.parse(map["number_books"].toString()),
        link_youtube: map["link_youtube"].toString());
  }

  Map<String, dynamic> toJson() => {
        "full_name": full_name,
        "description": description,
        "image": image,
        "number_books": number_books,
        "link_youtube": link_youtube,
      };
}
