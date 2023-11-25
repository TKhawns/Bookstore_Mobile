import 'package:flutter/material.dart';

class ShopNavigationItem {
  final String title;
  final String path;
  final IconData iconData;
  final String customerId;
  ShopNavigationItem(this.iconData, this.title, this.path, this.customerId);
}

List<ShopNavigationItem> getShopNavigationItemList(String customerId) {
  return <ShopNavigationItem>[
    ShopNavigationItem(Icons.home_rounded, "Trang chủ", "/home", customerId),
    ShopNavigationItem(Icons.menu_book, "Sách hay", "/hotbook", customerId),
    ShopNavigationItem(Icons.feed, "Cửa Hàng", "/dashboard", customerId),
    ShopNavigationItem(
        Icons.account_circle_rounded, "Tài khoản", "/profile", customerId),
  ];
}
