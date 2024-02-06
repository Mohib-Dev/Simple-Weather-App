import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:simple_weather_app/core/constants/constants.dart';
import 'package:simple_weather_app/core/error/exception.dart';
import 'package:simple_weather_app/features/weather/data/data_sources/weather_remote_data_source.dart';
import 'package:http/http.dart' as http;
import 'package:simple_weather_app/features/weather/data/models/weather_model.dart';

import '../../helper/helper_test.mocks.dart';
import '../../helper/json_reader.dart';

void main() {
  late MockHttpClient mockHttpClient;
  late WeatherRemoteDataSourceImplementation
      weatherRemoteDataSourceImplementation;

  setUp(() {
    mockHttpClient = MockHttpClient();
    weatherRemoteDataSourceImplementation =
        WeatherRemoteDataSourceImplementation(client: mockHttpClient);
  });
  const testCityName = "New York";

  test("It should return Weather Model when status code is 200", () async {
    // arrange

    when(mockHttpClient.get(Uri.parse(Urls.currentWeatherByName(testCityName))))
        .thenAnswer((_) async => http.Response(
            readJson("helper/dummy_data/dummy_weather_response.json"), 200));
    // act
    final result = await weatherRemoteDataSourceImplementation
        .getCurrentWeather(testCityName);

    // assert
    expect(result, isA<WeatherModel>());
  });

  test("It should throw exception when status code is not 200", () async {
    // arrange
    when(mockHttpClient.get(Uri.parse(Urls.currentWeatherByName(testCityName))))
        .thenAnswer((_) async => http.Response("Not Found", 404));

    // act
    final result =
        weatherRemoteDataSourceImplementation.getCurrentWeather(testCityName);

    //assert

    expect(result, throwsA(isA<ServerException>()));
  });
}
