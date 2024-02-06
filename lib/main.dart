import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_weather_app/features/weather/presentation/bloc/weather_bloc.dart';
import 'package:simple_weather_app/features/weather/presentation/screens/weather_screen.dart';
import 'package:simple_weather_app/injection_container.dart';

void main() {
  setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider(create: (_) => locator<WeatherBloc>())],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Clean Architecture Weather App',
        home: WeatherScreen(),
      ),
    );
  }
}
