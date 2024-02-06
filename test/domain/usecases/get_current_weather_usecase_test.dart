import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:simple_weather_app/features/weather/domain/entities/weather.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../helper/helper_test.mocks.dart';

void main() {
  late MockWeatherRepository mockWeatherRepository;

  setUp(() {
    mockWeatherRepository = MockWeatherRepository();
  });

  const testWeatherEntity = WeatherEntity(
      cityName: "New York",
      main: "Clouds",
      description: "few clouds",
      iconCode: "02d",
      temperature: 302.28,
      pressure: 1009,
      humidity: 70);

  const testCityName = "New York";

  test("should get current weather detail from the repository", () async {
    // arrange
    when(mockWeatherRepository.getCurrentWeather(testCityName))
        .thenAnswer((_) async => const Right(testWeatherEntity));

    // act
    final result = await mockWeatherRepository.getCurrentWeather(testCityName);

    // assert
    expect(result, const Right(testWeatherEntity));
  });
}
