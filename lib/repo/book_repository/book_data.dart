// ignore_for_file: non_constant_identifier_names

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
  String shopName;
  String shop_image;
  String quantity = '1';

  BookData({
    required this.book_id,
    required this.title,
    required this.description,
    required this.score,
    required this.image,
    required this.cost,
    required this.count,
    required this.shipCost,
    required this.authorName,
    required this.shopName,
    required this.shop_image,
    required this.quantity,
  });

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
      authorName: map['authorname'],
      shopName: map['shopname'],
      shop_image: map['shop_image'],
      quantity: map['quantity'],
    );
  }

  Map<String, dynamic> toJson() => {
        "book_id": book_id,
        "title": title,
        "description": description,
        "score": score,
        "image": image,
        "price": cost,
        "number_books": count,
        "shipcost": shipCost,
        "authorname": authorName,
        "shopname": shopName,
        "shop_image": shop_image,
        "quantity": quantity,
      };
}
