import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:simple_weather_app/features/weather/data/data_sources/weather_remote_data_source.dart';
import 'package:simple_weather_app/features/weather/data/repositories/weather_repository_impl.dart';
import 'package:simple_weather_app/features/weather/domain/repositories/weather_repository.dart';
import 'package:simple_weather_app/features/weather/domain/usecases/get_current_weather.dart';
import 'package:simple_weather_app/features/weather/presentation/bloc/weather_bloc.dart';

final locator = GetIt.instance;

void setupLocator() {
  // bloc
  locator.registerFactory(() => WeatherBloc(locator()));

  // usecase
  locator.registerLazySingleton(
      () => GetCurrentWeather(weatherRepository: locator()));
  // repository
  locator.registerLazySingleton<WeatherRepository>(
    () => WeatherRepositoryImpl(weatherRemoteDataSource: locator()),
  );

  // data source
  locator.registerLazySingleton<WeatherRemoteDataSource>(
    () => WeatherRemoteDataSourceImplementation(
      client: locator(),
    ),
  );

  // external
  locator.registerLazySingleton(() => http.Client());
}
