import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:simple_weather_app/core/constants/constants.dart';
import 'package:simple_weather_app/core/error/exception.dart';
import 'package:simple_weather_app/features/weather/data/models/weather_model.dart';

abstract class WeatherRemoteDataSource {
  Future<WeatherModel> getCurrentWeather(String cityName);
}

class WeatherRemoteDataSourceImplementation extends WeatherRemoteDataSource {
  final http.Client client;

  WeatherRemoteDataSourceImplementation({required this.client});

  @override
  Future<WeatherModel> getCurrentWeather(String cityName) async {
    final response =
        await client.get(Uri.parse(Urls.currentWeatherByName(cityName)));

    if (response.statusCode == 200) {
      return WeatherModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }
}
