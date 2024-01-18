class WeatherModel {
  Location? location;
  Current? current;
  Forecast? forecast;

  WeatherModel({this.location, this.current, this.forecast});

  WeatherModel.fromJson(Map<String, dynamic> json) {
    location =
        json['location'] != null ? Location.fromJson(json['location']) : null;
    current =
        json['current'] != null ? Current.fromJson(json['current']) : null;
    forecast =
        json['forecast'] != null ? Forecast.fromJson(json['forecast']) : null;
  }
}

class Location {
  String? name;

  Location({
    this.name,
  });

  Location.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }
}

class Current {
  double? tempC;
  double? tempF;
  int? isDay;
  Condition? condition;
  double? windKph;
  double? pressureIn;
  int? humidity;
  int? cloud;

  Current({
    this.tempC,
    this.tempF,
    this.isDay,
    this.condition,
    this.windKph,
    this.pressureIn,
    this.humidity,
    this.cloud,
  });

  Current.fromJson(Map<String, dynamic> json) {
    tempC = json['temp_c'];
    tempF = json['temp_f'];
    isDay = json['is_day'];
    condition = json['condition'] != null
        ? Condition.fromJson(json['condition'])
        : null;
    windKph = json['wind_kph'];
    pressureIn = json['pressure_in'];
    humidity = json['humidity'];
    cloud = json['cloud'];
  }
}

class Condition {
  String? text;
  String? icon;

  Condition({this.text, this.icon});

  Condition.fromJson(Map<String, dynamic> json) {
    text = json['text'];
    icon = json['icon'];
  }
}

class Forecast {
  List<Forecastday>? forecastday;

  Forecast({this.forecastday});

  Forecast.fromJson(Map<String, dynamic> json) {
    if (json['forecastday'] != null) {
      forecastday = <Forecastday>[];
      json['forecastday'].forEach((v) {
        forecastday!.add(Forecastday.fromJson(v));
      });
    }
  }
}

class Forecastday {
  String? date;

  Day? day;

  List<Hour>? hour;

  Forecastday({this.date, this.day, this.hour});

  Forecastday.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    day = json['day'] != null ? Day.fromJson(json['day']) : null;
    if (json['hour'] != null) {
      hour = <Hour>[];
      json['hour'].forEach((v) {
        hour!.add(Hour.fromJson(v));
      });
    }
  }
}

class Day {
  double? avgtempC;
  double? avgtempF;
  double? maxwindKph;
  double? totalprecipIn;
  double? avghumidity;
  int? dailyWillItRain;
  int? dailyChanceOfRain;
  int? dailyWillItSnow;
  int? dailyChanceOfSnow;
  Condition? condition;

  Day({
    this.avgtempC,
    this.avgtempF,
    this.maxwindKph,
    this.totalprecipIn,
    this.avghumidity,
    this.dailyWillItRain,
    this.dailyChanceOfRain,
    this.dailyWillItSnow,
    this.dailyChanceOfSnow,
    this.condition,
  });

  Day.fromJson(Map<String, dynamic> json) {
    avgtempC = json['avgtemp_c'];
    avgtempF = json['avgtemp_f'];
    maxwindKph = json['maxwind_kph'];
    totalprecipIn = json['totalprecip_in'];
    avghumidity = json['avghumidity'];
    dailyWillItRain = json['daily_will_it_rain'];
    dailyChanceOfRain = json['daily_chance_of_rain'];
    dailyWillItSnow = json['daily_will_it_snow'];
    dailyChanceOfSnow = json['daily_chance_of_snow'];
    condition = json['condition'] != null
        ? Condition.fromJson(json['condition'])
        : null;
  }
}

class Hour {
  String? time;
  double? tempC;
  double? tempF;
  int? isDay;
  Condition? condition;
  double? windKph;
  double? pressureIn;
  int? humidity;
  int? willItRain;
  int? chanceOfRain;
  int? willItSnow;
  int? chanceOfSnow;

  Hour({
    this.time,
    this.tempC,
    this.tempF,
    this.isDay,
    this.condition,
    this.windKph,
    this.pressureIn,
    this.humidity,
    this.willItRain,
    this.chanceOfRain,
    this.willItSnow,
    this.chanceOfSnow,
  });

  Hour.fromJson(Map<String, dynamic> json) {
    time = json['time'];
    tempC = json['temp_c'];
    tempF = json['temp_f'];
    isDay = json['is_day'];
    condition = json['condition'] != null
        ? Condition.fromJson(json['condition'])
        : null;
    windKph = json['wind_kph'];
    pressureIn = json['pressure_in'];
    humidity = json['humidity'];
    willItRain = json['will_it_rain'];
    chanceOfRain = json['chance_of_rain'];
    willItSnow = json['will_it_snow'];
    chanceOfSnow = json['chance_of_snow'];
  }
}
