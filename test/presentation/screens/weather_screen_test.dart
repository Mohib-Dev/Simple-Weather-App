import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:simple_weather_app/features/weather/presentation/bloc/weather_bloc.dart';
import 'package:simple_weather_app/features/weather/presentation/bloc/weather_events.dart';
import 'package:simple_weather_app/features/weather/presentation/bloc/weather_states.dart';
import 'package:simple_weather_app/features/weather/presentation/screens/weather_screen.dart';

class MockWeatherBloc extends MockBloc<WeatherEvent, WeatherState>
    implements WeatherBloc {}

void main() {
  late MockWeatherBloc mockWeatherBloc;

  setUp(() {
    mockWeatherBloc = MockWeatherBloc();
  });

  Widget makeTestableWidget(Widget body) {
    return BlocProvider<WeatherBloc>(
      create: (context) => mockWeatherBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets(
    'text field should trigger state to change from empty to loading',
    (widgetTester) async {
      //arrange
      when(() => mockWeatherBloc.state).thenReturn(WeatherEmpty());

      //act
      await widgetTester.pumpWidget(makeTestableWidget(const WeatherScreen()));
      var textField = find.byType(TextField);
      expect(textField, findsOneWidget);
      await widgetTester.enterText(textField, 'New York');
      await widgetTester.pump();
      expect(find.text('New York'), findsOneWidget);
    },
  );

  testWidgets(
    'should show progress indicator when state is loading',
    (widgetTester) async {
      //arrange
      when(() => mockWeatherBloc.state).thenReturn(WeatherLoading());

      //act
      await widgetTester.pumpWidget(makeTestableWidget(const WeatherScreen()));

      //assert
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    },
  );
}
