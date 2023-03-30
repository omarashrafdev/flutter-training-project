import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../controller/user_controller.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key, this.city, this.data});

  String? city;
  Map<String, dynamic>? data;

  @override
  State<HomeScreen> createState() => _HomeScreenState(data, city);
}

class _HomeScreenState extends State<HomeScreen> {
  Map<String, dynamic>? data;
  String? city;
  var userController = Get.put(UserController());

  _HomeScreenState(this.data, this.city);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //print(userController.city);
    print('hello');
    getData(city: city!);
  }

  Widget build(BuildContext context) {
    // var data=userController.data;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text('Weather'),
        //Text("Weather"),
        leading: Icon(Icons.menu),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: data != null
          ? Stack(
              children: [
                const Image(
                  image: AssetImage('assets/images/bb.jpg'),
                  height: 900,
                  fit: BoxFit.cover,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 200.0, right: 20, left: 20, bottom: 0),
                  child: Container(
                    height: 230,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(.8),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "${data!['name']}",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 25),
                        ),
                        Text("Last update: ${data!['date']}",
                            style: Theme.of(context)
                                .textTheme
                                .caption
                                ?.copyWith(fontSize: 15)),
                        SizedBox(
                          height: 30,
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: 20,
                            ),
                            Column(
                              children: [
                                Container(
                                  width: 120,
                                  child: Text(
                                    "${data!["weatherState"]}",
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "${data!["weatherDegree"]}°C",
                                  style: TextStyle(
                                    fontSize: 40,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              width: 70,
                            ),
                            Image.network(
                              'http:${data!["weatherIcon"]}',
                              height: 100,
                              width: 100,
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 470.0, left: 20),
                        child: Container(
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(.7),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "Degree in F",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Text("${data!["weatherDegreeF"]}",
                                  style: Theme.of(context)
                                      .textTheme
                                      .caption
                                      ?.copyWith(fontSize: 20)),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 470.0, left: 20),
                        child: Container(
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(.7),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "Cloud",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Text("${data!["cloud"]}",
                                  style: Theme.of(context)
                                      .textTheme
                                      .caption
                                      ?.copyWith(fontSize: 20)),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 470.0, left: 20),
                        child: Container(
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(.7),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "Humidity",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Text("${data!["humidity"]}",
                                  style: Theme.of(context)
                                      .textTheme
                                      .caption
                                      ?.copyWith(fontSize: 20)),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 470.0, left: 20),
                        child: Container(
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(.7),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "windSpeed",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Text("${data!["windSpeedKPH"]} KpH",
                                  style: Theme.of(context)
                                      .textTheme
                                      .caption
                                      ?.copyWith(fontSize: 20)),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 470.0, left: 20),
                        child: Container(
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(.7),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "windSpeed",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Text("${data!["windSpeedMPH"]} MpH",
                                  style: Theme.of(context)
                                      .textTheme
                                      .caption
                                      ?.copyWith(fontSize: 20)),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )
          : Stack(
              children: [
                const Image(
                  image: AssetImage('assets/images/bb.jpg'),
                  height: 900,
                  fit: BoxFit.cover,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 200.0, right: 20, left: 20, bottom: 0),
                  child: Container(
                    height: 230,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(.8),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            "Loading.....",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 25),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
    );
  }

  getData({required String city}) async {
    //String city = 'cairo';
    Uri url = Uri.parse(
        "http://api.weatherapi.com/v1/current.json?key=0024b98f24294aa38ff165814230902&q=$city&aqi=no");
    var response = await http.get(url);
    print('ahmed2');
    var dataWeather = jsonDecode(response.body);
    print(response.statusCode);
    print("object");
    setState(() {
      data = {
        "name": dataWeather["location"]['name'],
        "date": dataWeather["location"]["localtime"],
        "weatherState": dataWeather["current"]["condition"]["text"],
        "weatherIcon": dataWeather["current"]["condition"]["icon"],
        "weatherDegree": dataWeather["current"]["temp_c"],
        "windSpeedKPH": dataWeather["current"]["wind_kph"],
        "windSpeedMPH": dataWeather["current"]["wind_mph"],
        "cloud": dataWeather["current"]["cloud"],
        "humidity": dataWeather["current"]["humidity"],
        "weatherDegreeF": dataWeather["current"]["temp_f"],
      };
    });
  }
}
