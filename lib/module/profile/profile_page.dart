// ignore_for_file: prefer_const_constructors, must_be_immutable, use_key_in_widget_constructors, depend_on_referenced_packages

import 'package:bookstore_mobile/module/profile/profile_bloc.dart';
import 'package:bookstore_mobile/module/profile/voucher.dart';
import 'package:bookstore_mobile/module/signin/signin_page.dart';
import 'package:bookstore_mobile/repo/user_repository/user_data.dart';
import 'package:bookstore_mobile/repo/user_repository/user_repo.dart';
import 'package:bookstore_mobile/repo/user_repository/user_service.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class MyProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<MyProfile>(
          create: (_) => MyProfile(),
        ),
        Provider.value(value: UserService()),
        ProxyProvider<UserService, UserRepo>(
          update: (context, userService, previous) =>
              UserRepo(userService: userService),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "My Account",
            style: TextStyle(color: Colors.white, fontSize: 25),
          ),
          backgroundColor: const Color.fromARGB(255, 0, 151, 178),
        ),
        body: ProfileWidget(),
      ),
    );
  }
}

class ProfileWidget extends StatefulWidget {
  @override
  State<ProfileWidget> createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends State<ProfileWidget> {
  UserData userData = UserData(
      displayName: "",
      token: "",
      role: "",
      id: "",
      avatar: "",
      address: "",
      phone: "");

  @override
  Widget build(BuildContext context) {
    final Object? customerId = ModalRoute.of(context)!.settings.arguments;
    return Provider<ProfileBloc>.value(
      value: ProfileBloc(userRepo: Provider.of(context)),
      child: Consumer<ProfileBloc>(builder: (context, bloc, child) {
        bloc.getUserInfo(customerId as String).listen((user) {
          userData = user;
        });
        return StreamProvider<UserData>.value(
          initialData: userData,
          value: bloc.getUserInfo(customerId),
          child: Consumer<UserData>(
            builder: (context, value, child) => SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.only(top: 25, left: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CircleAvatar(
                          radius: 35,
                          backgroundImage: NetworkImage(userData.avatar),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: EdgeInsets.only(bottom: 10),
                              child: Text(
                                userData.displayName,
                                style: GoogleFonts.inter(
                                    fontSize: 24,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black),
                              ),
                            ),
                            Text(
                              "Address: ${userData.address}",
                              style: GoogleFonts.inter(
                                  color: Colors.grey[800],
                                  fontWeight: FontWeight.w500,
                                  fontSize: 17),
                            ),
                            Text(
                              "Phone: ${userData.phone}",
                              style: GoogleFonts.inter(
                                  color: Colors.grey[800],
                                  fontSize: 17,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                        Container(
                          padding: EdgeInsets.only(right: 10),
                          child: GestureDetector(
                            onTap: () {},
                            child: Icon(
                              Icons.edit_note_rounded,
                              size: 40,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 20, left: 20),
                    child: Text(
                      "Account",
                      style: GoogleFonts.inter(
                          fontSize: 22,
                          fontWeight: FontWeight.w500,
                          color: Colors.black),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 10),
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey[50],
                        minimumSize: Size(200, 70),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.feed,
                            size: 28,
                            color: Colors.black,
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 15, right: 140),
                            child: Text(
                              "Book orders",
                              style: GoogleFonts.inter(
                                  fontSize: 21,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          Icon(
                            Icons.arrow_forward_ios_rounded,
                            size: 25,
                            color: Colors.black,
                          ),
                        ],
                      ),
                    ),
                  ),

                  // DISCOUNT Row
                  Container(
                    padding: EdgeInsets.only(top: 15),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => VoucherList()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey[50],
                        minimumSize: Size(200, 70),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.discount_rounded,
                            size: 28,
                            color: Colors.black,
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 15, right: 120),
                            child: Text(
                              "Your vouchers",
                              style: GoogleFonts.inter(
                                  fontSize: 21,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          Icon(
                            Icons.arrow_forward_ios_rounded,
                            size: 25,
                            color: Colors.black,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 15),
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey[50],
                        minimumSize: Size(200, 70),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.circle_notifications_rounded,
                            size: 28,
                            color: Colors.black,
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 15, right: 135),
                            child: Text(
                              "Notifications",
                              style: GoogleFonts.inter(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 21,
                                  color: Colors.black),
                            ),
                          ),
                          Icon(
                            Icons.arrow_forward_ios_rounded,
                            size: 25,
                            color: Colors.black,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 15),
                    child: ElevatedButton(
                      onPressed: () {
                        showAlertDialog(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey[50],
                        minimumSize: Size(200, 70),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.settings_rounded,
                            size: 28,
                            color: Colors.black,
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 15, right: 190),
                            child: Text(
                              "Log out",
                              style: GoogleFonts.inter(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 21,
                                  color: Colors.red),
                            ),
                          ),
                          Icon(
                            Icons.arrow_forward_ios_rounded,
                            size: 25,
                            color: Colors.black,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 20, left: 20),
                    child: Text(
                      "General Information",
                      style: GoogleFonts.inter(
                          fontSize: 22,
                          fontWeight: FontWeight.w500,
                          color: Colors.black),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 15),
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey[50],
                        minimumSize: Size(200, 70),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.star,
                            size: 28,
                            color: Colors.black,
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 15, right: 130),
                            child: Text(
                              "App Reviews  ",
                              style: GoogleFonts.inter(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 21,
                                  color: Colors.black),
                            ),
                          ),
                          Icon(
                            Icons.arrow_forward_ios_rounded,
                            size: 25,
                            color: Colors.black,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }

  showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text(
        "Cancel",
        style: GoogleFonts.inter(
          fontWeight: FontWeight.w500,
          fontSize: 19,
        ),
      ),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = TextButton(
      child: Text(
        "Confirm",
        style: GoogleFonts.inter(
          fontWeight: FontWeight.w500,
          fontSize: 19,
        ),
      ),
      onPressed: () {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => SignInPage()),
            ModalRoute.withName('/sign-in'));
        return;
      },
    );

    AlertDialog alert = AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(26.0))),
      title: Text(
        "Warning",
        style: GoogleFonts.inter(
          color: Colors.red,
          fontWeight: FontWeight.w500,
          fontSize: 22,
        ),
      ),
      content: SizedBox(
        width: 320,
        child: Text(
          "Would you like to continue log-out ?",
          style: GoogleFonts.inter(
            fontWeight: FontWeight.w500,
            fontSize: 20,
          ),
        ),
      ),
      actions: [
        cancelButton,
        continueButton,
      ],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
