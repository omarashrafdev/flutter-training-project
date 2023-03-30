import 'package:creativa_flutter/model/user_model.dart';
import 'package:creativa_flutter/screens/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../controller/user_controller.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  var nameController = TextEditingController();
  var emailController = TextEditingController();

  void _loadData() async {
    final prefs = await SharedPreferences.getInstance();

    final name = prefs.getString('name') ?? "";
    final email = prefs.getString('email') ?? "";

    setState(() {
      nameController.text = name;
      emailController.text = email;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.only(top: 100),
            alignment: Alignment.center,
            child: CircleAvatar(
              child: Image.network(
                  'https://thumbs.dreamstime.com/b/person-gray-photo-placeholder-man-t-shirt-white-background-147541161.jpg'),
              radius: 60,
            ),
          ),
          SizedBox(
            height: 40,
          ),
          TextFormField(
            controller: nameController,
            keyboardType: TextInputType.name,
            decoration: const InputDecoration(
              labelStyle: TextStyle(color: Colors.teal),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.teal)),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.green)),
              labelText: "Name",
              prefixIcon: Icon(
                Icons.person,
              ),
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          TextFormField(
            controller: emailController,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              labelStyle: TextStyle(color: Colors.teal),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.teal)),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.green)),
              labelText: "Email",
              prefixIcon: Icon(
                Icons.email,
              ),
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.blueAccent,
              borderRadius: BorderRadius.circular(10),
            ),
            child: TextButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                    (route) => false);
              },
              child: const Text(
                'SignOut',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
