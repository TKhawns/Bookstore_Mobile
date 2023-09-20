import 'package:flutter/material.dart';

class NavigationItem {
  final String title;
  final IconData iconData;
  NavigationItem(this.iconData, this.title);
}

List<NavigationItem> getNavigationItemList() {
  return <NavigationItem>[
    NavigationItem(Icons.home_rounded, "Trang chủ "),
    NavigationItem(Icons.menu_book, "Sách hay"),
    NavigationItem(Icons.feed, "Mua bán"),
    NavigationItem(Icons.account_circle_rounded, "Tài khoản"),
  ];
}
