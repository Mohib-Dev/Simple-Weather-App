import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:simple_weather_app/features/weather/data/models/weather_model.dart';
import 'package:simple_weather_app/features/weather/domain/entities/weather.dart';

import '../../helper/json_reader.dart';

Future<void> main() async {
  const testWeatherModel = WeatherModel(
    cityName: 'New York',
    main: 'Clear',
    description: 'clear sky',
    iconCode: '01n',
    temperature: 292.87,
    pressure: 1012,
    humidity: 70,
  );

  test("It should return a Weather Entity", () {
    //assert
    expect(testWeatherModel, isA<WeatherEntity>());
  });

  test("It should  return a valid model from JSON", () async {
    // arrange
    final Map<String, dynamic> jsonMap =
        json.decode(readJson("helper/dummy_data/dummy_weather_response.json"));

    // act
    final result = WeatherModel.fromJson(jsonMap);

    // assert
    expect(result, equals(testWeatherModel));
  });

  test("It should return a json map containing proper data", () {
    // act
    final result = testWeatherModel.toJson();

    // assert

    final expectedJsonMap = {
      'weather': [
        {
          'main': 'Clear',
          'description': 'clear sky',
          'icon': '01n',
        }
      ],
      'main': {
        'temp': 292.87,
        'pressure': 1012,
        'humidity': 70,
      },
      'name': 'New York',
    };

    expect(result, equals(expectedJsonMap));
  });
}
