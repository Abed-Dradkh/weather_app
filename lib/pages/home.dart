import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/services/api_service.dart';
import 'package:weather_app/services/colors.dart';
import 'package:weather_app/services/size_config.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<WeatherApi>(
        builder: (_, data, __) {
          return Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: gradiantColors,
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
              ),
            ),
            child: FutureBuilder(
              future: data.getData('Irbid'),
              builder: (_, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '${data.locationData?.name}',
                      style: TextStyle(
                        fontFamily: 'Rubik',
                        fontSize: MediaQuery.of(context).size.width * 0.15,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      '${data.weatherData?.condition?.text}',
                      style: TextStyle(
                        fontFamily: 'Diphylleia',
                        fontSize: MediaQuery.of(context).size.width * 0.07,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      '${data.weatherData?.tempC?.round()}°',
                      style: TextStyle(
                        fontFamily: 'Ubuntu',
                        fontSize: MediaQuery.of(context).size.width * 0.07,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      height: getProportionateScreenHeight(20),
                    ),
                    Container(
                      height: getProportionateScreenHeight(200),
                      width: getProportionateScreenWidth(200),
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.contain,
                          image: AssetImage(
                            data.weatherData?.isDay == 0
                                ? 'assets/images/night.png'
                                : 'assets/images/morning.png',
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: getProportionateScreenHeight(50),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        buildDetails(context,
                            '${data.weatherData?.windKph?.round()}', 0),
                        buildDetails(
                            context, '${data.weatherData?.humidity}', 1),
                        buildDetails(context,
                            '${data.weatherData?.pressureIn?.round()}', 2),
                      ],
                    ),
                    SizedBox(
                      height: getProportionateScreenHeight(25),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: getProportionateScreenWidth(20),
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Today',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  buildNext3Days(
                                    context,
                                    data.weatherDetails ?? [],
                                  );
                                },
                                highlightColor: Colors.transparent,
                                splashColor: Colors.transparent,
                                child: Row(
                                  children: [
                                    const Text(
                                      'Next 3 Days',
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                    Icon(
                                      Icons.arrow_forward_ios_rounded,
                                      size: getProportionateScreenHeight(14),
                                      color: Colors.white,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: getProportionateScreenHeight(15),
                    ),
                    SizedBox(
                      height: getProportionateScreenHeight(130),
                      child: ListView.separated(
                        itemCount: 12,
                        physics: const BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (_, index) {
                          final hourData = data.hourDays?[index * 2];
                          return Container(
                            width: getProportionateScreenWidth(70),
                            padding: EdgeInsets.symmetric(
                              vertical: getProportionateScreenHeight(7),
                            ),
                            margin: EdgeInsets.only(
                              top: getProportionateScreenHeight(10),
                              bottom: getProportionateScreenHeight(10),
                              left: index == 0
                                  ? getProportionateScreenWidth(20)
                                  : 0,
                              right: index == 6
                                  ? getProportionateScreenWidth(20)
                                  : 0,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(25),
                              boxShadow: [
                                BoxShadow(
                                  color: weatherDetails.withOpacity(0.5),
                                  blurRadius: 10,
                                  spreadRadius: 2,
                                ),
                              ],
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  extractTime('${hourData?.time}'),
                                  style: TextStyle(
                                    fontSize: getProportionateScreenWidth(12),
                                  ),
                                ),
                                SizedBox(
                                  height: getProportionateScreenHeight(50),
                                  child: Image.network(
                                    'https:${hourData?.condition?.icon}',
                                  ),
                                ),
                                Text(
                                  '${hourData?.tempC?.round()}°',
                                  style: TextStyle(
                                    fontSize: getProportionateScreenWidth(12),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                        separatorBuilder: (_, __) {
                          return SizedBox(
                            width: getProportionateScreenWidth(25),
                          );
                        },
                      ),
                    ),
                  ],
                );
              },
            ),
          );
        },
      ),
    );
  }

  Future<dynamic> buildNext3Days(BuildContext context, List<Forecastday> info) {
    return showModalBottomSheet(
      context: context,
      builder: (_) {
        return Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.width * .0125,
              width: MediaQuery.of(context).size.width * .25,
              margin: EdgeInsets.symmetric(
                vertical: MediaQuery.of(context).size.height * .01,
              ),
              decoration: BoxDecoration(
                color: const Color(0xff4e7ce1),
                borderRadius: BorderRadius.circular(25),
              ),
            ),
            Flexible(
              child: ListView.separated(
                itemCount: 3,
                itemBuilder: (_, index) {
                  return Card(
                    elevation: 5,
                    child: ListTile(
                      leading: Image.network(
                          'https:${info[index].day?.condition?.icon}'),
                      title: Text(
                        convertDate('${info[index].date}'),
                      ),
                      subtitle: Text(
                        '${info[index].day?.condition?.text}',
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            '${info[index].day?.avgtempC?.round()}°C',
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * .025,
                          ),
                          Text(
                            '${info[index].day?.avghumidity?.round()}%H',
                          ),
                        ],
                      ),
                    ),
                  );
                },
                separatorBuilder: (_, __) {
                  return SizedBox(
                    height: MediaQuery.of(context).size.height * .025,
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}

String extractTime(String stringTime) {
  DateTime date = DateTime.parse(stringTime);
  String formattedTime = DateFormat('h:mm a').format(date);

  return formattedTime;
}

Widget buildDetails(BuildContext context, String value, int index) {
  List<String> icons = ['cloudy', 'wind', 'humidity'];
  return Column(
    children: [
      Container(
        height: getProportionateScreenHeight(80),
        width: getProportionateScreenWidth(75),
        padding: EdgeInsets.all(
          getProportionateScreenHeight(18),
        ),
        decoration: BoxDecoration(
          color: weatherDetails,
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(
              color: weatherDetails.withOpacity(0.5),
              blurRadius: 10,
              spreadRadius: 3,
            ),
          ],
        ),
        child: Image.asset(
          'assets/images/${icons[index]}.png',
        ),
      ),
      SizedBox(
        height: getProportionateScreenHeight(5),
      ),
      Text(
        index == 1 ? '${value}km/h' : '$value%',
        style: TextStyle(
          fontFamily: 'Ubuntu',
          fontSize: MediaQuery.of(context).size.width * 0.035,
          color: Colors.white,
        ),
      ),
    ],
  );
}

int extractDay(String stringTime) {
  DateTime date = DateTime.parse(stringTime);

  return date.day;
}

String convertDate(String stringTime) {
  DateTime date = DateTime.parse(stringTime);
  String formattedTime = DateFormat('d/M, EEE').format(date);

  return formattedTime;
}

String selectWeather(String data) {
  String basePath = 'assets/images/weather_icons/';
  switch (data) {
    case 'Sunny':
      return '${basePath}sun.png';
  }
  return '';
}
