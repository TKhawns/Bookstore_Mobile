import 'package:flutter/material.dart';

class NavigationItem {
  final String title;
  final String path;
  final IconData iconData;
  final String customerId;
  NavigationItem(this.iconData, this.title, this.path, this.customerId);
}

List<NavigationItem> getNavigationItemList(String customerId) {
  return <NavigationItem>[
    NavigationItem(Icons.home_rounded, "Trang chủ", "/home", customerId),
    NavigationItem(Icons.menu_book, "Sách hay", "/hotbook", customerId),
    NavigationItem(Icons.feed, "Mua bán", "/showdialog", customerId),
    NavigationItem(
        Icons.account_circle_rounded, "Tài khoản", "/profile", customerId),
  ];
}
