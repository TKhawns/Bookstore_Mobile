import 'package:bookstore_mobile/base/base_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../widget/normalbutton.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PageContainer(title: "Sign In", child: SignInFormWidget());
  }
}

class SignInFormWidget extends StatefulWidget {
  const SignInFormWidget({super.key});

  @override
  State<SignInFormWidget> createState() => _SignInFormWidgetState();
}

class _SignInFormWidgetState extends State<SignInFormWidget> {
  final TextEditingController _txtPhoneController = TextEditingController();
  final TextEditingController _txtPassController = TextEditingController();

  // code of check validate Sign in here

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(25),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          _buildPhoneField(),
          _buildPassField(),
          Container(
            padding: EdgeInsets.only(top: 30),
            child: NormalButton(
              title: "Đăng nhập",
              onPressed: () {},
            ),
          )
        ],
      ),
    );
  }

  Widget _buildPhoneField() {
    return Container(
      padding: EdgeInsets.only(top: 10),
      child: TextField(
        controller: _txtPhoneController,
        cursorColor: Colors.black,
        keyboardType: TextInputType.phone,
        decoration: InputDecoration(
            icon: Icon(
              Icons.phone,
              color: Colors.blue,
            ),
            hintText: "(+84)382588919",
            labelText: "Phone Number",
            labelStyle: TextStyle(color: Colors.black)),
      ),
    );
  }

  Widget _buildPassField() {
    return Container(
      padding: EdgeInsets.only(top: 10),
      child: TextField(
        controller: _txtPassController,
        obscureText: true,
        cursorColor: Colors.black,
        decoration: InputDecoration(
            icon: Icon(Icons.lock, color: Colors.blue),
            hintText: "Password",
            labelText: "Password",
            labelStyle: TextStyle(color: Colors.black)),
      ),
    );
  }
}
