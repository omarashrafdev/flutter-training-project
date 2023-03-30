import 'package:creativa_flutter/screens/home_screen.dart';
import 'package:creativa_flutter/screens/login_screen.dart';
import 'package:creativa_flutter/screens/register_screen.dart';
import 'package:creativa_flutter/search_screen.dart';
import 'package:creativa_flutter/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

import 'component/custom_navigation.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/home': (context) => HomeScreen(),
        'splash': (context) => SplashScreen(),
        'login': (context) => LoginScreen(),
        'navigation': (context) => NavigationScreen(),
        'search': (context) => SearchScreen(),
        'register': (context) => RegisterScreen()
      },
      initialRoute: 'splash',
      //home: LoginScreen(),
    );
  }
}
