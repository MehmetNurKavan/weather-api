import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:havadurumu/models/weather.dart';
import 'package:havadurumu/service/api_service.dart';
import 'package:havadurumu/utils/colors.dart';

class MyHome extends StatefulWidget {
  const MyHome({Key? key}) : super(key: key);

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  String city = "";
  List<Weather> weatherList = [];
  final TextEditingController _cityController = TextEditingController(text: "mardin");

  @override
  void initState() {
    getWeatherData('mardin');
    super.initState();
  }

    @override
  void dispose() {
    _cityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (weatherList.isEmpty) {
      return const Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 25.0),
              Text("Yükleniliyor...")
            ],
          ),
        ),
      );
    } else {
      return Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: buildBackGroundColorGradient(weatherList[0].status),
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: buildAppBarWidget(),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 20.0,
              ),
              Row( mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width*0.7,
                    child: TextField(
                      style: const TextStyle(color: Colors.white),
                      controller: _cityController,
                      decoration: InputDecoration(
                        icon: const Icon(CupertinoIcons.location_solid,color: Colors.white),
                            hintText: city.toUpperCase(),
                        hintStyle: const TextStyle(color: Colors.white,)
                            ),
                      onChanged: (value) {
                        setState(() {
                          city=value;
                        });
                      },
                    ),
                  ),
                  ElevatedButton(
                    style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(Colors.transparent),
                      textStyle:  MaterialStatePropertyAll(TextStyle(color: Colors.white)),
                    ),
                    onPressed: () {
                setState(() {
                  getWeatherData(city);
                });
              }, child: const Text("ara")),
                ],
              ),
              Image.network(weatherList[0].icon,
                  width: MediaQuery.of(context).size.width / 3),
              const SizedBox(
                height: 5.0,
              ),
              Text(
                "${double.parse(weatherList[0].degree).round().toString()}°C",
                style: TextStyle(
                  fontSize: 70.0,
                  fontWeight: FontWeight.w300,
                  color: buildTextColor(weatherList[0].status),
                ),
              ),
              Text(
                weatherList[0].description,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.w300,
                  color: buildTextColor(weatherList[0].status),
                ),
              ),
              const SizedBox(
                height: 30.0,
              ),
              Expanded(
                child: ListView.separated(
                  itemCount: weatherList.length - 1,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            buildWeatherListText(weatherList[index + 1].day),
                            style: const TextStyle(
                              fontSize: 20.0,
                            ),
                          ),
                          Image.network(
                            weatherList[index + 1].icon,
                            height: 50,
                          ),
                          Row(
                            children: [
                              Text(
                                "${double.parse(weatherList[index + 1].min).round()}°",
                                style: const TextStyle(
                                  fontSize: 22.0,
                                ),
                              ),
                              const SizedBox(
                                width: 10.0,
                              ),
                              Text(
                                "${double.parse(weatherList[index + 1].max).round()}°",
                                style: const TextStyle(
                                  fontSize: 22.0,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return const Divider(
                      color: Colors.transparent,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      );
    }
  }

  List<Color> buildBackGroundColorGradient(String weather) {
    if (weather.toLowerCase() == "snow") {
      return [niceWhite, niceDarkBlue];
    } else if (weather.toLowerCase() == "rain") {
      return [niceVeryDarkBlue, niceDarkBlue];
    } else {
      return [niceBlue, niceDarkBlue];
    }
  }

  Color buildTextColor(String weather) {
    if (weather.toLowerCase() == "snow") {
      return niceTextDarkBlue;
    } else if (weather.toLowerCase() == "rain") {
      return Colors.white;
    } else {
      return Colors.white;
    }
  }

  void getWeatherData(String cityData) {
    ApiService.getWeatherDataByCity(cityData).then((data) {
      Map resultBody = json.decode(data.body);
      if (resultBody['success'] == true) {
        setState(() {
          city = resultBody['city'];
          Iterable result = resultBody['result'];
          weatherList =
              result.map((watherData) => Weather(watherData)).toList();
        });
      }
    });
  }

  AppBar buildAppBarWidget() {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            weatherList[0].day,
            style: TextStyle(
              fontSize: 14.0,
              color: buildTextColor(weatherList[0].status),
            ),
          ),
          Text(
              city.toUpperCase(),
              style: TextStyle(
                fontSize: 24.0,
                color: buildTextColor(weatherList[0].status),
              ),
            ),
            Text(
            weatherList[0].date,
            style: TextStyle(
              fontSize: 14.0,
              color: buildTextColor(weatherList[0].status),
            ),
          ),
        ],
      ),
    );
  }

  String buildWeatherListText(String day) {
    switch (day.toLowerCase()) {
      case "pazartesi":
        return "Pazartesi";
      case "salı":
        return "Salı";
      case "çarşamba":
        return "Çarşamba";
      case "perşembe":
        return "Perşembe";
      case "cuma":
        return "Cuma";
      case "cumartesi":
        return "Cumartesi";
      case "pazar":
        return "Pazar";
      default:
        return "?";
    }
  }
}