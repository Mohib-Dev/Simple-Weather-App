class Urls {
  static const String baseUrl = 'https://api.openweathermap.org/data/2.5';
  static const String apiKey = 'f61426ea4b0eb788402bbc35d7fd2779';
  static String currentWeatherByName(String city) =>
      '$baseUrl/weather?q=$city&appid=$apiKey';
  static String weatherIcon(String iconCode) =>
      'http://openweathermap.org/img/wn/$iconCode@2x.png';
}
