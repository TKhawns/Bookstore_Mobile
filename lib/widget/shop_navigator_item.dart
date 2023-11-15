import 'package:flutter/material.dart';

class ShopNavigationItem {
  final String title;
  final String path;
  final IconData iconData;
  ShopNavigationItem(this.iconData, this.title, this.path);
}

List<ShopNavigationItem> getShopNavigationItemList() {
  return <ShopNavigationItem>[
    ShopNavigationItem(Icons.home_rounded, "Trang chủ", "/home"),
    ShopNavigationItem(Icons.menu_book, "Sách hay", "/hotbook"),
    ShopNavigationItem(Icons.feed, "Cửa Hàng", "/dashboard"),
    ShopNavigationItem(Icons.account_circle_rounded, "Tài khoản", "/profile"),
  ];
}
