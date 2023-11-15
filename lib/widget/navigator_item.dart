import 'package:flutter/material.dart';

class NavigationItem {
  final String title;
  final String path;
  final IconData iconData;
  // final String customerId;
  NavigationItem(this.iconData, this.title, this.path);
}

List<NavigationItem> getNavigationItemList() {
  return <NavigationItem>[
    NavigationItem(Icons.home_rounded, "Trang chủ", "/home"),
    NavigationItem(Icons.menu_book, "Sách hay", "/hotbook"),
    NavigationItem(Icons.feed, "Mua bán", "/showdialog"),
    NavigationItem(Icons.account_circle_rounded, "Tài khoản", "/profile"),
  ];
}
