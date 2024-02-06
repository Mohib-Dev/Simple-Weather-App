import 'package:dartz/dartz.dart';
import 'package:simple_weather_app/core/error/failure.dart';
import 'package:simple_weather_app/features/weather/domain/entities/weather.dart';

abstract class WeatherRepository {
  Future<Either<Failure, WeatherEntity>> getCurrentWeather(String cityName);
}
