// ignore_for_file: prefer_const_constructors, unnecessary_new, depend_on_referenced_packages, use_key_in_widget_constructors

import 'package:bookstore_mobile/widget/scale_animation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../base/base_bloc.dart';

class LoadingTask extends StatelessWidget {
  final Widget child;
  final BaseBloc bloc;

  const LoadingTask({required this.child, required this.bloc});

  @override
  Widget build(BuildContext context) {
    return StreamProvider<bool>.value(
      value: bloc.loadingStream,
      initialData: false,
      child: Stack(
        children: <Widget>[
          child,
          Consumer<bool>(
              builder: (context, isLoading, child) => Center(
                    child: isLoading
                        ? ScaleAnimation(
                            child: Container(
                              width: 100,
                              height: 100,
                              decoration: new BoxDecoration(
                                color: Colors.black45,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(20),
                                ),
                              ),
                              child: SpinKitCircle(
                                color: Colors.white,
                              ),
                            ),
                          )
                        : Container(),
                  )),
        ],
      ),
    );
  }
}
