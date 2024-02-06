import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:simple_weather_app/features/weather/domain/usecases/get_current_weather.dart';
import 'package:simple_weather_app/features/weather/presentation/bloc/weather_events.dart';
import 'package:simple_weather_app/features/weather/presentation/bloc/weather_states.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final GetCurrentWeather _getCurrentWeatherUseCase;
  WeatherBloc(this._getCurrentWeatherUseCase) : super(WeatherEmpty()) {
    on<OnCityChanged>(
      (event, emit) async {
        emit(WeatherLoading());
        final result =
            await _getCurrentWeatherUseCase.getCurrentWeather(event.cityName);
        result.fold(
          (failure) {
            emit(WeatherLoadFailue(failure.message));
          },
          (data) {
            emit(WeatherLoaded(data));
          },
        );
      },
      transformer: debounce(const Duration(milliseconds: 500)),
    );
  }
}

EventTransformer<T> debounce<T>(Duration duration) {
  return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
}
