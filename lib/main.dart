import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:weather_app/screen/weather_app.dart';
import 'package:weather_app/state/weather_app_state.dart';
import 'package:weather_app/view_model/weather_app_view_model.dart';

Future<void> main() async {
  await dotenv.load(fileName: '.env'); //ここを追加
  runApp(const ProviderScope(
      child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const WeatherApp(title: 'Flutter Demo Home Page'),
    );
  }
}

final weatherAppProvider = StateNotifierProvider<
    WeatherAppStateNotifier,
    WeatherAppState>(
        (ref) => WeatherAppStateNotifier()
);
