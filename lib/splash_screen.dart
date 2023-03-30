
import 'package:creativa_flutter/screens/home_screen.dart';
import 'package:creativa_flutter/screens/login_screen.dart';
import 'package:easy_splash_screen/easy_splash_screen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: EasySplashScreen(
        logo: Image.asset('assets/images/gg.png',),
        backgroundColor:Colors.cyan ,
        durationInSeconds:3 ,
        logoWidth: 70,
        showLoader: false,
        navigator: LoginScreen(),
      ),

    );
  }
}