import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app/view_model/weather_app_view_model.dart';

class WeatherDetail extends ConsumerWidget {
  const WeatherDetail({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final weatherState = ref.watch(weatherViewModelProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('天気詳細')),
      body: weatherState.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('エラー: $err')),
        data: (weatherData) {
          if (weatherData == null) {
            return const Center(child: Text('データがありません'));
          }
          // データが表示できる状態

          String weatherImage = 'mark_question.png';
          switch (weatherData.weather) {
            case 'Clear':
              weatherImage = 'assets/mark_tenki_hare.png';
              break;
            case 'Clouds':
              weatherImage = 'assets/mark_tenki_kumori.png';
              break;
            case 'Rain':
              weatherImage = 'assets/mark_tenki_umbrella.png';
              break;
            case 'Snow':
              weatherImage = 'assets/tenki_snow.png';
              break;
            case 'Snow':
              weatherImage = 'assets/tenki_snow.png';
              break;
            default:
              weatherImage = 'assets/mark_question.png';
          }

          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                    child: Text(
                    '${weatherData.areaName}',
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 24),
                  )),
                Center(
                  child: Container(
                      width: 150,child: Image.asset(weatherImage)),
                ),
                Text('天気: ${weatherData.weatherDescription}'),
                Text('温度: ${weatherData.temperature.toStringAsFixed(1)}℃'),
                Text('湿度: ${weatherData.humidity}%'),
                // ... 他の天気情報
              ],
            ),
          );
        },
      ),
    );
  }
}
