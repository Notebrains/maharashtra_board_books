import 'package:flutter/material.dart';
import 'package:flutter_animator/flutter_animator.dart';

class Splash extends StatelessWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ZoomIn(
        child: Center(
          child: Image.asset('assets/icons/pngs/app_logo.png',
            fit: BoxFit.contain,
            width: 200,
            height: 200,
          ),
        ),
      ),
    );
  }
}

class Init {
  Init._();
  static final instance = Init._();

  Future initialize() async {
    // This is where you can initialize the resources needed by your app while
    // the splash screen is displayed.  Remove the following example because
    // delaying the user experience is a bad design practice!
    await Future.delayed(const Duration(seconds: 2));
  }
}