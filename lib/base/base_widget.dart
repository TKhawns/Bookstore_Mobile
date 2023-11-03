// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors_in_immutables, depend_on_referenced_packages, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../module/signin/signin_page.dart';

class PageContainer extends StatelessWidget {
  final String title;
  final Widget child;

  final List<SingleChildWidget> bloc;
  final List<SingleChildWidget> di;
  //final List<Widget> actions;

  PageContainer({
    required this.title,
    required this.child,
    required this.bloc,
    required this.di,
    //required this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<SignInPage>(create: (_) => SignInPage()),
        ...di,
        ...bloc,
      ],
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            title,
            style: TextStyle(color: Colors.white, fontSize: 25),
          ),
        ),
        body: child,
      ),
    );
  }
}
