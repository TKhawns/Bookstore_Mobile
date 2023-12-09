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

  // static ShopData parseShopInfoList(map) {
  //   var list = map["data"];
  //   return list.map((book) => ShopData.fromJson(book)).toList();
  // }

  factory ShopData.fromJson(map) {
    return ShopData(
      name: map["data"]["name"].toString(),
      address: map["data"]["address"],
      image: map["data"]["image"],
      number_books: map["data"]["number_books"],
    );
  }

  Map<String, dynamic> toJson() => {
        "name": name,
        "address": address,
        "image": image,
        "number_books": number_books,
      };
}
