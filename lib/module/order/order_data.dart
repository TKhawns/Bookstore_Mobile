// ignore_for_file: non_constant_identifier_names

class OrderData {
  String title;
  String image;
  String count;
  String name;
  String address;
  OrderData({
    required this.title,
    required this.image,
    required this.count,
    required this.name,
    required this.address,
  });

  static List<OrderData> parseBookDataList(map) {
    var list = map["data"] as List;
    return list.map((book) => OrderData.fromJson(book)).toList();
  }

  factory OrderData.fromJson(Map<String, dynamic> map) {
    return OrderData(
      title: map["title"],
      image: map["image"],
      count: map["count"],
      name: map["name"],
      address: map['address'],
    );
  }

  Map<String, dynamic> toJson() => {
        "title": title,
        "image": image,
        "count": count,
        "name": name,
        "address": address,
      };
}
