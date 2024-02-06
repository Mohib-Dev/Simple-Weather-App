import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:simple_weather_app/core/error/exception.dart';
import 'package:simple_weather_app/core/error/failure.dart';
import 'package:simple_weather_app/features/weather/data/data_sources/weather_remote_data_source.dart';
import 'package:simple_weather_app/features/weather/domain/entities/weather.dart';
import 'package:simple_weather_app/features/weather/domain/repositories/weather_repository.dart';

class WeatherRepositoryImpl extends WeatherRepository {
  final WeatherRemoteDataSource weatherRemoteDataSource;

  WeatherRepositoryImpl({required this.weatherRemoteDataSource});

  @override
  Future<Either<Failure, WeatherEntity>> getCurrentWeather(
      String cityName) async {
    try {
      final result = await weatherRemoteDataSource.getCurrentWeather(cityName);
      return Right(result.toEntity());
    } on ServerException {
      return const Left(ServerFailure("An error has occurred"));
    } on SocketException {
      return const Left(ConnectionFailure("Failed to connect to the Network"));
    }
  }
}
