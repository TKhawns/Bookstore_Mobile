// ignore_for_file: non_constant_identifier_names

class DashBoardData {
  String shopName;
  String total_order;
  String money;

  DashBoardData(
      {required this.shopName, required this.total_order, required this.money});

  factory DashBoardData.fromJson(Map<String, dynamic> json) {
    return DashBoardData(
        shopName: json["data"]['shop_name'],
        total_order: json['data']['total_order'],
        money: json['data']['new_order']);
  }
}
