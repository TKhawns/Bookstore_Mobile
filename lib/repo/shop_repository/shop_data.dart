// ignore_for_file: non_constant_identifier_names

class ShopData {
  String name;
  String address;
  String image;
  String number_books;

  ShopData({
    required this.name,
    required this.image,
    required this.address,
    required this.number_books,
  });

  static List<ShopData> parseShopInfoList(map) {
    var list = map["data"] as List;
    return list.map((book) => ShopData.fromJson(book)).toList();
  }

  factory ShopData.fromJson(Map<String, dynamic> map) {
    return ShopData(
      name: map["name"].toString(),
      address: map["address"],
      image: map["image"],
      number_books: map["number_books"],
    );
  }

  Map<String, dynamic> toJson() => {
        "name": name,
        "address": address,
        "image": image,
        "number_books": number_books,
      };
}
