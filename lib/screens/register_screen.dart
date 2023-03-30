import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final formKey = GlobalKey<FormState>();
  bool isSecure = true;
  IconData? suffix = Icons.visibility;
  bool isSecure2 = true;
  IconData? suffix2 = Icons.visibility;
  var emailController = TextEditingController();
  var firstNameController = TextEditingController();
  var lastNameController = TextEditingController();
  var passController = TextEditingController();
  var rePassController = TextEditingController();

  var statusMessage = 'Enter your information to sign up to Weather App';
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
            padding: const EdgeInsets.only(top: 100.0),
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
                            const Text("Register",
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
                          controller: firstNameController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'First Name is required';
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
                            label: Text('First Name'),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          style: const TextStyle(color: Colors.white),
                          controller: lastNameController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Last Name is required';
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
                            label: Text('Last Name'),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          style: const TextStyle(color: Colors.white),
                          controller: emailController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Email is required';
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
                        TextFormField(
                          controller: rePassController,
                          style: const TextStyle(color: Colors.white),
                          obscureText: isSecure2,

                          //?Icon(Icons.visibility_off_sharp):Icon(Icons.visibility)
                          validator: (value) {
                            if (passController.text != rePassController.text) {
                              return 'Passwords don\'t match';
                            }
                            if (value!.isEmpty) {
                              return 'Confirm password is required';
                            }
                            if (value.length <= 6) {
                              return 'Confirm password is too short';
                            }
                          },

                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    isSecure2 = !isSecure2;
                                    suffix2 = isSecure2
                                        ? Icons.visibility
                                        : Icons.visibility_off_sharp;
                                  });
                                },
                                icon: Icon(
                                  suffix2,
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
                            label: const Text('Confirm Passowrd'),
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
    var response = await http.post(
      Uri.parse('http://10.174.241.20:8000/register'),
      headers: <String, String>{'Content-Type': 'application/json'},
      body: jsonEncode(<String, String>{
        'email': emailController.text,
        'first_name': firstNameController.text,
        'last_name': lastNameController.text,
        'password': passController.text,
        'password2': rePassController.text
      }),
    );

    if (response.statusCode == 201) {
      Navigator.pushNamed(context, 'login');
    } else {
      var data = json.decode(response.body);
      if (data['email'] != null) {
        if (data['email'][0] == 'This field must be unique.') {
          setState(() {
            statusMessage = 'Email already in use. Enter another email.';
            statusColor = Colors.red;
          });
        }
      } else if (data['password'] != null) {
        setState(() {
          statusMessage =
              'Enter a more complex password with at least 8 characters.';
          statusColor = Colors.red;
        });
      } else {
        setState(() {
          statusMessage = 'Something went wrong. Try again.';
          statusColor = Colors.red;
        });
      }
    }
  }
}
