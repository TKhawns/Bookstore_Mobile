import 'package:bookstore_mobile/base/base_widget.dart';
import 'package:bookstore_mobile/module/signin/signin_page.dart';
import 'package:bookstore_mobile/module/signup/signup_bloc.dart';
import 'package:bookstore_mobile/module/signup/signup_fail.dart';
import 'package:bookstore_mobile/module/signup/signup_success.dart';
import 'package:bookstore_mobile/widget/bloc_listener.dart';
import 'package:bookstore_mobile/widget/loading_task.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../base/base_event.dart';
import '../../event/signup_event.dart';
import '../../repo/user_repository/user_repo.dart';
import '../../repo/user_repository/user_service.dart';

import '../../widget/normalbutton.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PageContainer(
        title: "Sign Up",
        di: [
          Provider.value(
            value: UserService(),
          ),
          ProxyProvider<UserService, UserRepo>(
            update: (context, UserService, previous) =>
                UserRepo(userService: UserService),
          ),
        ],
        bloc: [],
        child: SignUpFormWidget());
  }
}

class SignUpFormWidget extends StatefulWidget {
  const SignUpFormWidget({super.key});

  @override
  State<SignUpFormWidget> createState() => _SignUpFormWidgetState();
}

class _SignUpFormWidgetState extends State<SignUpFormWidget> {
  final TextEditingController _txtDisplayNameController =
      TextEditingController();
  final TextEditingController _txtPhoneController = TextEditingController();
  final TextEditingController _txtPassController = TextEditingController();

  handleEvent(BaseEvent event) {
    if (event is SignUpSuccessEvent) {
      Navigator.pushReplacementNamed(context, "/home");
    }
    if (event is SignUpFailEvent) {
      final snackBar = SnackBar(
        content: Text(event.errorMessage),
        backgroundColor: Colors.red,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Provider<SignUpBloc>.value(
      value: SignUpBloc(userRepo: Provider.of(context)),
      child: Consumer<SignUpBloc>(builder: (context, bloc, child) {
        return BlocListener<SignUpBloc>(
          listener: handleEvent,
          child: LoadingTask(
            bloc: bloc,
            child: Container(
              padding: EdgeInsets.only(right: 25, bottom: 10, left: 25),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                    child: Image.asset('assets/images/textlogo.png'),
                    padding: EdgeInsets.only(bottom: 50),
                  ),
                  Container(
                    padding: EdgeInsets.only(right: 180, bottom: 30),
                    child: Text(
                      "Welcome,",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                          color: const Color.fromARGB(255, 0, 151, 178)),
                    ),
                  ),
                  _buildDisplayNameField(),
                  _buildPhoneField(),
                  _buildPassField(),
                  Container(
                    padding: EdgeInsets.only(
                        left: 30, right: 30, top: 100, bottom: 10),
                    child: NormalButton(
                      title: "Đăng ký",
                      onPressed: () {
                        bloc.event.add(SignUpEvent(
                          displayName: _txtDisplayNameController.text,
                          phone: _txtPhoneController.text,
                          pass: _txtPassController.text,
                        ));
                      },
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 30, bottom: 25),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Have an account ?",
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
            ),
          ),
        );
      }),
    );
  }

  Widget _buildDisplayNameField() {
    return Container(
      padding: EdgeInsets.only(top: 10),
      child: TextField(
        controller: _txtDisplayNameController,
        obscureText: false,
        cursorColor: Colors.black,
        decoration: InputDecoration(
          icon: Icon(
            Icons.account_box,
            color: Colors.blue,
          ),
          hintText: "Display Name",
          labelText: "Display Name",
          labelStyle: TextStyle(color: Colors.black),
        ),
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
          "Đăng nhập",
          style: TextStyle(
              fontSize: 20, color: const Color.fromARGB(255, 0, 151, 178)),
        ),
        onPressed: () {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (BuildContext context) => SignInPage()),
            ModalRoute.withName('/sign-in'),
          );
        },
      ),
    );
  }
}
