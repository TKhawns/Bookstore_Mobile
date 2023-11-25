// ignore_for_file: prefer_const_constructors, unnecessary_import, depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class VoucherList extends StatelessWidget {
  const VoucherList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Your vouchers",
          style: GoogleFonts.inter(
            fontWeight: FontWeight.w500,
            fontSize: 21,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.only(left: 20, right: 20),
        alignment: Alignment.center,
        child: Text(
          "Bạn không có voucher nào !",
          style: GoogleFonts.inter(
            fontWeight: FontWeight.w500,
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}
