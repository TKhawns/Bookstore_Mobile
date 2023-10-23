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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 100,
              color: Color.fromARGB(255, 0, 151, 178),
              padding: EdgeInsets.only(left: 15, right: 15, top: 15),
              child: Row(
                children: [
                  Container(
                    height: 80,
                    child: CircleAvatar(
                      radius: 35, // Image radius
                      backgroundImage:
                          AssetImage("assets/images/william_shakespear.jpg"),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.only(left: 10),
                            child: Text(
                              "Books Store",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 3),
                            child: Icon(
                              Icons.verified_rounded,
                              color: Colors.blue,
                              size: 20,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 10),
                        child: Text(
                          "Ha Noi, Viet Nam",
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 15),
                        child: Row(
                          children: [
                            Icon(
                              Icons.star,
                              color: Colors.yellow,
                            ),
                            Container(
                              padding: EdgeInsets.only(left: 3),
                              child: Text(
                                "4,7",
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
