class WeatherResponse {
  String main, description;
  double tempmax;
  double tempmin;
  dynamic pressure;
  dynamic windSpeed;
  dynamic humidity;
  dynamic clouds;

  WeatherResponse({
    this.clouds,
    this.humidity,
    this.pressure,
    this.windSpeed,
    this.main, this.description, this.tempmax, this.tempmin});

  factory WeatherResponse.fromJSON(Map<String, dynamic> json) {
    return WeatherResponse(
       humidity: json['main']['humidity'] ,
      pressure: json['main']['pressure'] ,
      tempmax: json['main']['temp_max'] - 273,
      tempmin: json['main']['temp_min'] - 273,
      windSpeed: json['wind']['speed'],
      clouds: json['clouds']['all'],
    );
  }
    static List<WeatherResponse> fromForecastJson(Map<String, dynamic> json) {
    final weathers = List<WeatherResponse>();
    for (final item in json['list']) {
      weathers.add(WeatherResponse(
       humidity: json['main']['humidity'] ,
      pressure: json['main']['pressure'] ,
      tempmax: json['main']['temp_max'] - 273,
      tempmin: json['main']['temp_min'] - 273,
      windSpeed: json['wind']['speed'],
      clouds: json['clouds']['all'],
      ),
      );
    }
    return weathers;
  }
}
