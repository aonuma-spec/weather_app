import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app/view_model/weather_app_view_model.dart';

class WeatherDetail extends ConsumerWidget {
  const WeatherDetail({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final weatherState = ref.watch(weatherViewModelProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('天気詳細'),
      ),
      body: weatherState.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('エラー: $err')),
        data: (weatherData) {
          if (weatherData == null) {
            return const Center(child: Text('データがありません'));
          }
          // データが表示できる状態
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('地域: ${weatherData.areaName}', style: const TextStyle(fontSize: 24)),
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