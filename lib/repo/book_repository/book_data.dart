class BookData {
  int book_id;
  String title;
  String description;
  String score;
  String image;
  String cost;
  int count;
  String shipCost;
  String authorName;

  BookData(
      {required this.book_id,
      required this.title,
      required this.description,
      required this.score,
      required this.image,
      required this.cost,
      required this.count,
      required this.shipCost,
      required this.authorName});

  static List<BookData> parseBookDataList(map) {
    var list = map["data"] as List;
    return list.map((book) => BookData.fromJson(book)).toList();
  }

  factory BookData.fromJson(Map<String, dynamic> map) {
    return BookData(
        book_id: int.parse(map["book_id"].toString()),
        title: map["title"],
        description: map["description"],
        score: map["score"],
        image: map["image"],
        cost: map["price"],
        count: int.parse(map["number_books"].toString()),
        shipCost: map["shipcost"],
        authorName: map['authorname']);
  }

  Map<String, dynamic> toJson() => {
        "title": title,
        "description": description,
        "score": score,
        "image": image,
        "price": cost,
        "number_books": count,
        "shipcost": shipCost,
        "authorname": authorName,
      };
}
