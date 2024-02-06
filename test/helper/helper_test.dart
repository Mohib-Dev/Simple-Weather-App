import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:simple_weather_app/features/weather/data/data_sources/weather_remote_data_source.dart';
import 'package:simple_weather_app/features/weather/domain/repositories/weather_repository.dart';
import 'package:simple_weather_app/features/weather/domain/usecases/get_current_weather.dart';

@GenerateMocks(
  [
    WeatherRepository,
    WeatherRemoteDataSource,
    GetCurrentWeather,
  ],
  customMocks: [MockSpec<http.Client>(as: #MockHttpClient)],
)
void main() {}
