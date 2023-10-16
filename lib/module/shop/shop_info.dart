import 'package:flutter/material.dart';

class ShopInfoWidget extends StatefulWidget {
  const ShopInfoWidget({super.key});

  @override
  State<ShopInfoWidget> createState() => _ShopInfoWidgetState();
}

class _ShopInfoWidgetState extends State<ShopInfoWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Shop's Name"),
      ),
      body: Container(
        color: Colors.white,
      ),
    );
  }
}
