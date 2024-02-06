import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:simple_weather_app/core/error/failure.dart';
import 'package:simple_weather_app/features/weather/domain/entities/weather.dart';
import 'package:simple_weather_app/features/weather/presentation/bloc/weather_bloc.dart';
import 'package:simple_weather_app/features/weather/presentation/bloc/weather_events.dart';
import 'package:simple_weather_app/features/weather/presentation/bloc/weather_states.dart';

import '../../helper/helper_test.mocks.dart';

void main() {
  late MockGetCurrentWeather mockGetCurrentWeather;
  late WeatherBloc weatherBloc;

  setUp(() {
    mockGetCurrentWeather = MockGetCurrentWeather();
    weatherBloc = WeatherBloc(mockGetCurrentWeather);
  });

  const testWeather = WeatherEntity(
    cityName: 'New York',
    main: 'Clouds',
    description: 'few clouds',
    iconCode: '02d',
    temperature: 302.28,
    pressure: 1009,
    humidity: 70,
  );

  const testCityName = 'New York';

  test('initial state should be empty', () {
    expect(weatherBloc.state, WeatherEmpty());
  });

  blocTest<WeatherBloc, WeatherState>(
      'should emit [WeatherLoading, WeatherLoaded] when data is loaded successfully',
      build: () {
        when(mockGetCurrentWeather.getCurrentWeather(testCityName))
            .thenAnswer((_) async => const Right(testWeather));
        return weatherBloc;
      },
      act: (bloc) => bloc.add(const OnCityChanged(testCityName)),
      wait: const Duration(milliseconds: 500),
      expect: () => [WeatherLoading(), const WeatherLoaded(testWeather)]);

  blocTest<WeatherBloc, WeatherState>(
      'should emit [WeatherLoading, WeatherLoadFailure] when get data is unsuccessful',
      build: () {
        when(mockGetCurrentWeather.getCurrentWeather(testCityName)).thenAnswer(
            (_) async => const Left(ServerFailure('Server failure')));
        return weatherBloc;
      },
      act: (bloc) => bloc.add(const OnCityChanged(testCityName)),
      wait: const Duration(milliseconds: 500),
      expect: () => [
            WeatherLoading(),
            const WeatherLoadFailue('Server failure'),
          ]);
}
