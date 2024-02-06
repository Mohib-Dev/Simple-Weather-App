import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:simple_weather_app/core/error/exception.dart';
import 'package:simple_weather_app/core/error/failure.dart';
import 'package:simple_weather_app/features/weather/data/models/weather_model.dart';
import 'package:simple_weather_app/features/weather/data/repositories/weather_repository_impl.dart';
import 'package:simple_weather_app/features/weather/domain/entities/weather.dart';

import '../../helper/helper_test.mocks.dart';

void main() {
  late MockWeatherRemoteDataSource mockWeatherRemoteDataSource;
  late WeatherRepositoryImpl weatherRepositoryImpl;

  setUp(() {
    mockWeatherRemoteDataSource = MockWeatherRemoteDataSource();
    weatherRepositoryImpl = WeatherRepositoryImpl(
        weatherRemoteDataSource: mockWeatherRemoteDataSource);
  });

  const testWeatherModel = WeatherModel(
    cityName: 'New York',
    main: 'Clouds',
    description: 'few clouds',
    iconCode: '02d',
    temperature: 302.28,
    pressure: 1009,
    humidity: 70,
  );

  const testWeatherEntity = WeatherEntity(
    cityName: 'New York',
    main: 'Clouds',
    description: 'few clouds',
    iconCode: '02d',
    temperature: 302.28,
    pressure: 1009,
    humidity: 70,
  );

  const testCityName = 'New York';

  group("should return current weather", () {
    test("When the call is successful , it returns current weather", () async {
      // arrange
      when(mockWeatherRemoteDataSource.getCurrentWeather(testCityName))
          .thenAnswer((_) async => testWeatherModel);

      //act
      final result =
          await weatherRepositoryImpl.getCurrentWeather(testCityName);
      //assert
      expect(result, equals(const Right(testWeatherEntity)));
    });

    test(
        "should throw server exception when the call to data source is not successfull",
        () async {
      // arrange
      when(mockWeatherRemoteDataSource.getCurrentWeather(testCityName))
          .thenThrow(ServerException());

      // act
      final result =
          await weatherRepositoryImpl.getCurrentWeather(testCityName);

      // assert
      expect(
          result, equals(const Left(ServerFailure("An error has occurred"))));
    });

    test(
        "should throw socket exception when the device has no internet connection",
        () async {
      // arrange
      when(mockWeatherRemoteDataSource.getCurrentWeather(testCityName))
          .thenThrow(const SocketException("Failed to connect to the Network"));

      // act
      final result =
          await weatherRepositoryImpl.getCurrentWeather(testCityName);

      // assert
      expect(
          result,
          equals(const Left(
              ConnectionFailure("Failed to connect to the Network"))));
    });
  });
}
