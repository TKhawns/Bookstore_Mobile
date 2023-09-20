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
      padding: EdgeInsets.only(right: 25, bottom: 25, left: 25),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            child: Image.asset('assets/images/textlogo.png'),
            padding: EdgeInsets.only(bottom: 50),
          ),
          Container(
            padding: EdgeInsets.only(right: 110, bottom: 30),
            child: Text(
              "Welcome back",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  color: const Color.fromARGB(255, 0, 151, 178)),
            ),
          ),
          _buildPhoneField(),
          _buildPassField(),
          Container(
            padding: EdgeInsets.only(left: 30, right: 30, top: 100, bottom: 30),
            child: NormalButton(
              title: "Đăng nhập",
              onPressed: () {
                Navigator.pushReplacementNamed(context, "/home");
                return;
              },
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 30, bottom: 25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Don't have account ?",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                  ),
                ),
                _buildFooter()
              ],
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

  Widget _buildFooter() {
    return Container(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(4.0),
            )),
        child: Text(
          "Đăng ký",
          style: TextStyle(
              fontSize: 20, color: const Color.fromARGB(255, 0, 151, 178)),
        ),
        onPressed: () {
          Navigator.pushNamed(context, "/sign-up");
        },
      ),
    );
  }
}
