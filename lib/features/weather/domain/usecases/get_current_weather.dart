import 'package:dartz/dartz.dart';
import 'package:simple_weather_app/core/error/failure.dart';
import 'package:simple_weather_app/features/weather/domain/entities/weather.dart';
import 'package:simple_weather_app/features/weather/domain/repositories/weather_repository.dart';

class GetCurrentWeather {
  final WeatherRepository weatherRepository;

  GetCurrentWeather({required this.weatherRepository});

  Future<Either<Failure, WeatherEntity>> getCurrentWeather(String cityName) {
    return weatherRepository.getCurrentWeather(cityName);
  }
}
