import 'dart:convert';
import 'dart:ui';

import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:jwt_decode/jwt_decode.dart';

import '../controller/user_controller.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

var emailController = TextEditingController();
var passController = TextEditingController();

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();
  bool isSecure = true;
  IconData? suffix = Icons.visibility;
  var userController = Get.put(UserController());

  var statusMessage = 'Enter your information to login to Weather App';
  var statusColor = Colors.white;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const Image(
            image: AssetImage('assets/images/kk.jpg'),
            height: 900,
            fit: BoxFit.cover,
            width: double.infinity,
          ),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: Container(
              color: Colors.black.withOpacity(0),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            const Text("LOGIN",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                )),
                            const SizedBox(
                              height: 20,
                            ),
                            Text(
                              statusMessage,
                              style:
                                  TextStyle(color: statusColor, fontSize: 16),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          style: const TextStyle(color: Colors.white),
                          controller: emailController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Email required';
                            } else if (!value.contains("@") ||
                                !value.contains(".")) {
                              return "Invalid Email";
                            }
                          },
                          decoration: const InputDecoration(
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white)),
                            errorStyle: TextStyle(color: Colors.white),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white)),
                            border: OutlineInputBorder(),
                            labelStyle: TextStyle(color: Colors.white),
                            // border: OutlineInputBorder(),
                            label: Text('Email'),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: passController,
                          style: const TextStyle(color: Colors.white),
                          obscureText: isSecure,
                          //?Icon(Icons.visibility_off_sharp):Icon(Icons.visibility)
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Password is required';
                            }
                            if (value.length <= 6) {
                              return 'Password is too short';
                            }
                          },

                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    isSecure = !isSecure;
                                    suffix = isSecure
                                        ? Icons.visibility
                                        : Icons.visibility_off_sharp;
                                  });
                                },
                                icon: Icon(
                                  suffix,
                                  color: Colors.white,
                                )),

                            focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white)),
                            errorStyle: const TextStyle(color: Colors.white),
                            enabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white)),
                            border: const OutlineInputBorder(),
                            labelStyle: const TextStyle(color: Colors.white),
                            // border: OutlineInputBorder(),
                            label: const Text('Password'),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        ElevatedButton(
                            onPressed: () {
                              setState(() {
                                if (formKey.currentState!.validate()) {
                                  postData();
                                }
                              });
                            },
                            child: const Text('Submit')),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "New to Weather App? ",
                              style: TextStyle(color: Colors.white),
                            ),
                            TextButton(
                                onPressed: () {
                                  Navigator.of(context)
                                      .pushReplacementNamed('register');
                                },
                                child: const Text('Register')),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  postData() async {
    // obtain shared preferences
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      statusMessage = '';
    });
    var response = await http.post(
      Uri.parse('http://10.174.241.20:8000/token'),
      headers: <String, String>{'Content-Type': 'application/json'},
      body: jsonEncode(<String, String>{
        'email': emailController.text,
        'password': passController.text
      }),
    );
    if (response.statusCode == 401) {
      setState(() {
        statusMessage = 'Invalid email or password';
        statusColor = Colors.red;
      });
    } else if (response.statusCode == 200) {
      var token = jsonDecode(response.body)['access'];

      Map<String, dynamic> payload = Jwt.parseJwt(token);

      await prefs.setString('name', payload['full_name']);
      await prefs.setString('email', payload['email']);

      // ignore: use_build_context_synchronously
      Navigator.pushNamedAndRemoveUntil(context, "navigation", (r) => false);
    } else {
      setState(() {
        statusMessage = 'Something went wrong. Try again.';
        statusColor = Colors.red;
      });
    }
  }
}
