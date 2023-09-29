// ignore_for_file: prefer_const_constructors, unused_import

import 'package:bookstore_mobile/base/base_bloc.dart';
import 'package:bookstore_mobile/base/base_event.dart';
import 'package:bookstore_mobile/base/base_widget.dart';
import 'package:bookstore_mobile/module/home/home_page.dart';
import 'package:bookstore_mobile/module/signin/signin_bloc.dart';
import 'package:bookstore_mobile/module/signin/signin_fail.dart';
import 'package:bookstore_mobile/module/signin/signin_success.dart';
import 'package:bookstore_mobile/widget/loading_task.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../event/signin_event.dart';
import '../../repo/user_repo.dart';
import '../../repo/user_service.dart';
import '../../widget/bloc_listener.dart';
import '../../widget/normalbutton.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PageContainer(
        title: "Sign In",
        bloc: [],
        di: [
          Provider.value(value: UserService()),
          ProxyProvider<UserService, UserRepo>(
            update: (context, UserService, previous) =>
                UserRepo(userService: UserService),
          ),
        ],
        child: SignInFormWidget());
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
  handleEvent(BaseEvent event) {
    if (event is SignInSuccessEvent) {
      Navigator.pushReplacementNamed(context, "/home");
    }

    if (event is SignInFailEvent) {
      final snackBar = SnackBar(
        content: Text(event.errorMessage),
        backgroundColor: Colors.red,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Provider<SignInBloc>.value(
      value: SignInBloc(userRepo: Provider.of(context)),
      child: Consumer<SignInBloc>(builder: (context, bloc, child) {
        return BlocListener<SignInBloc>(
          listener: handleEvent,
          child: LoadingTask(
            bloc: bloc,
            child: Container(
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
                  _buildPhoneField(bloc),
                  _buildPassField(bloc),
                  _buildSignInButton(bloc),
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
            ),
          ),
        );
      }),
    );
  }

  Widget _buildPhoneField(SignInBloc bloc) {
    return StreamProvider<String?>.value(
      initialData: null,
      value: bloc.phoneStream,
      child: Consumer<String?>(
          builder: (context, msg, child) => Container(
                padding: EdgeInsets.only(top: 10),
                child: TextField(
                  controller: _txtPhoneController,
                  onChanged: (text) {
                    bloc.phoneSink.add(text);
                    print(text);
                  },
                  cursorColor: Colors.black,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                      errorText: msg,
                      icon: Icon(
                        Icons.phone,
                        color: Colors.blue,
                      ),
                      hintText: "(+84)382588919",
                      labelText: "Phone Number",
                      labelStyle: TextStyle(color: Colors.black)),
                ),
              )),
    );
  }

  Widget _buildPassField(SignInBloc bloc) {
    return StreamProvider<String?>.value(
      initialData: null,
      value: bloc.passStream,
      child: Consumer<String?>(
        builder: (context, msg, child) => Container(
          padding: EdgeInsets.only(top: 10),
          child: TextField(
            onChanged: (text) {
              bloc.passSink.add(text);
              print(text);
            },
            controller: _txtPassController,
            obscureText: true,
            cursorColor: Colors.black,
            decoration: InputDecoration(
                errorText: msg,
                icon: Icon(Icons.lock, color: Colors.blue),
                hintText: "Password",
                labelText: "Password",
                labelStyle: TextStyle(color: Colors.black)),
          ),
        ),
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
          Navigator.pushReplacementNamed(context, "/sign-up");
        },
      ),
    );
  }

  Widget _buildSignInButton(SignInBloc bloc) {
    return StreamProvider<bool>.value(
      initialData: true,
      value: bloc.btnStream,
      child: Consumer<bool>(
        builder: (context, enable, child) => Container(
          padding: EdgeInsets.only(left: 30, right: 30, top: 100, bottom: 30),
          child: NormalButton(
            title: "Đăng nhập",
            onPressed: enable
                ? () {
                    bloc.event.add(SignInEvent(
                      phone: _txtPhoneController.text,
                      pass: _txtPassController.text,
                    ));
                  }
                : null,
          ),
        ),
      ),
    );
  }
}
