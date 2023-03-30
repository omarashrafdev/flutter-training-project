import 'package:flare_flutter/flare_actor.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'package:creativa_flutter/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'controller/user_controller.dart';

class SearchScreen extends StatefulWidget {
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String? cityName;
  Map<String, dynamic>? data;
  var searchController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  var userController = Get.put(UserController());

  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: const Text('Weather App'),
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Image(
              image: AssetImage('assets/images/cc.jpg'),
              height: 900,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 100.0),
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Center(
                      child: Padding(
                        padding: EdgeInsets.only(top: 30.0),
                        child: Container(
                          width: 300,
                          height: 300,
                          child: const FlareActor(
                            'assets/images/WorldSpin.flr',
                            fit: BoxFit.contain,
                            animation: 'roll',
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: TextFormField(
                        controller: searchController,
                        keyboardType: TextInputType.text,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "please enter Name city ";
                          }
                        },
                        onChanged: (value) {
                          cityName = value;
                        },
                        decoration: InputDecoration(
                            label: const Text(
                              'Search',
                            ),
                            hintText: 'enter a city',
                            hintStyle:
                                TextStyle(color: Colors.white.withOpacity(.6)),
                            border: const OutlineInputBorder()),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Container(
                          decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(15)),
                          width: double.infinity,
                          child: TextButton(
                              onPressed: () async {
                                if (formKey.currentState!.validate()) {
                                  userController.getCity(searchController.text);
                                  setState(() {
                                    Get.showSnackbar(GetSnackBar(
                                      backgroundColor: Colors.green,
                                      duration: Duration(seconds: 3),
                                      title: "warning",
                                      message: "navigate success",
                                    ));
                                  });
                                  Get.to(() => HomeScreen(
                                        data: data,
                                        city: cityName,
                                      ));

                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => HomeScreen(
                                              data: data,
                                              city: cityName,
                                            )),
                                  );
                                  searchController.clear();
                                } else {
                                  setState(() {
                                    Get.showSnackbar(GetSnackBar(
                                      backgroundColor: Colors.red,
                                      duration: Duration(seconds: 3),
                                      title: "warning",
                                      message: "navigate error",
                                    ));
                                  });
                                }
                              },
                              child: const Text(
                                'Search',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ))),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
