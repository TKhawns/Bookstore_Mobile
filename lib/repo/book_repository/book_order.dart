class BookOrder {
  int order_id;
  String title;
  String description;
  String image;
  String cost;
  String shipCost;

  BookOrder({
    required this.order_id,
    required this.title,
    required this.description,
    required this.image,
    required this.cost,
    required this.shipCost,
  });

  static List<BookOrder> parseBookDataList(map) {
    var list = map["data"] as List;
    return list.map((book) => BookOrder.fromJson(book)).toList();
  }

  factory BookOrder.fromJson(Map<String, dynamic> map) {
    return BookOrder(
      order_id: int.parse(map["order_id"].toString()),
      title: map["title"],
      description: map["description"],
      image: map["image"],
      cost: map["price"],
      shipCost: map["shipcost"],
    );
  }

  Map<String, dynamic> toJson() => {
        "title": title,
        "description": description,
        "image": image,
        "price": cost,
        "shipcost": shipCost,
      };
}
