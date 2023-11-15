// ignore_for_file: depend_on_referenced_packages, avoid_print, prefer_const_constructors

import 'dart:async';

import 'package:bookstore_mobile/module/signup/signup_fail.dart';
import 'package:bookstore_mobile/module/signup/signup_success.dart';
import 'package:rxdart/rxdart.dart';
import '../../base/base_bloc.dart';
import '../../base/base_event.dart';
import '../../event/signin_event.dart';
import '../../event/signup_event.dart';
import '../../repo/user_repository/user_repo.dart';
import '../../widget/validation.dart';

class SignUpBloc extends BaseBloc {
  final _displayNameSubject = BehaviorSubject<String>();
  final _phoneSubject = BehaviorSubject<String>();
  final _passSubject = BehaviorSubject<String>();
  final _btnSubject = BehaviorSubject<bool>();

  late UserRepo _userRepo;

  SignUpBloc({required UserRepo userRepo}) {
    _userRepo = userRepo;
    validateForm();
  }
  var displayNameValidation = StreamTransformer<String, String?>.fromHandlers(
    handleData: (displayName, sink) {
      if (Validation.isDisplayNameValid(displayName)) {
        sink.add(null);
        return;
      }
      sink.add("Display Name invalid");
    },
  );
  var phoneValidation = StreamTransformer<String, String?>.fromHandlers(
    handleData: (phone, sink) {
      if (Validation.isPhoneValid(phone)) {
        sink.add(null);
        return;
      }
      sink.add("Phone invalid");
    },
  );
  var passValidation = StreamTransformer<String, String?>.fromHandlers(
    handleData: (pass, sink) {
      if (Validation.isPassValid(pass)) {
        sink.add(null);
        return;
      }
      sink.add("Password too short");
    },
  );

  Stream<String?> get displayNameStream =>
      _displayNameSubject.stream.transform(displayNameValidation);
  Sink<String> get displayNameSink => _displayNameSubject.sink;

  Stream<String?> get phoneStream =>
      _phoneSubject.stream.transform(phoneValidation);
  Sink<String> get phoneSink => _phoneSubject.sink;

  Stream<String?> get passStream =>
      _passSubject.stream.transform(passValidation);
  Sink<String> get passSink => _passSubject.sink;

  Stream<bool> get btnStream => _btnSubject.stream;
  Sink<bool> get btnSink => _btnSubject.sink;

  validateForm() {
    CombineLatestStream.combine3(
        _displayNameSubject, _phoneSubject, _passSubject,
        (displayName, phone, pass) {
      return Validation.isPassValid(pass) &&
          Validation.isPhoneValid(phone) &&
          Validation.isDisplayNameValid(displayName);
    }).listen((enable) {
      btnSink.add(enable);
    });
  }

  @override
  void dispatchEvent(BaseEvent event) {
    switch (event.runtimeType) {
      case SignInEvent:
        handleSignIn(event);
        break;
      case SignUpEvent:
        handleSignUp(event);
        break;
    }
  }

  handleSignIn(event) {
    SignInEvent e = event as SignInEvent;
    _userRepo.signIn(e.phone, e.pass).then((userData) {
      print(userData);
    }, onError: (e) {
      print(e);
    });
  }

  handleSignUp(event) {
    loadingSink.add(true);
    Future.delayed(Duration(seconds: 5), () {
      SignUpEvent e = event as SignUpEvent;
      _userRepo.signUp(e.displayName, e.phone, e.pass).then((userData) {
        processEventSink.add(SignUpSuccessEvent(userData));
        loadingSink.add(false);
        print(userData);
      }, onError: (e) {
        loadingSink.add(false);
        processEventSink.add(SignUpFailEvent(e.toString()));
        print(e);
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _displayNameSubject.close();
    _phoneSubject.close();
    _passSubject.close();
    _btnSubject.close();
  }
}
