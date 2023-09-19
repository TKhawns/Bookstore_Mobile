import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../module/signin/sign_page.dart';

class PageContainer extends StatelessWidget {
  final String title;
  final Widget child;

  PageContainer({required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<SignInPage>(
          create: (_) => SignInPage(),
        )
      ],
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            title,
            style: TextStyle(color: Colors.blue),
          ),
        ),
        body: child,
      ),
    );
  }
}
