import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app/model/temp_comparison_data.dart';
import 'package:weather_app/model/weather_data.dart';
import 'package:weather_app/view_model/weather_app_view_model.dart';

class WeatherDetail extends ConsumerWidget {
  const WeatherDetail({super.key});

  String minDiff(WeatherData currentData, double minTemperature) {
    final double? currentTemp = currentData.temperature;
    final double? minTemp = minTemperature;

    if (currentTemp == null || minTemp == null) {
      return '不明';
    }

    final difference = currentTemp - minTemp;
    final absoluteDifference = difference.abs().toStringAsFixed(1);

    return '${absoluteDifference}';
  }

  String maxDiff(WeatherData currentData, double maxTemperature) {
    final double? currentTemp = currentData.temperature;
    final double? maxTemp = maxTemperature;

    if (currentTemp == null || maxTemp == null) {
      return '不明';
    }

    final difference = currentTemp - maxTemp;
    final absoluteDifference = difference.abs().toStringAsFixed(1);

    return '${absoluteDifference}';
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final weatherState = ref.watch(weatherViewModelProvider);
    final comparisonState = ref.watch(compareViewModelProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('天気詳細', style: TextStyle(color: Colors.white)),
        backgroundColor: Color.fromARGB(255, 70, 100, 100),
      ),
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
            default:
              weatherImage = 'assets/mark_question.png';
          }

          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ColoredBox(
                  color: Color.fromARGB(255, 70, 100, 100),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        '${weatherData.areaName}',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 24,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Container(
                    width: 150,
                    child: Image.asset(weatherImage),
                  ),
                ),
                SizedBox(height: 30),
                Row(
                  children: [
                    Container(
                      color: Color.fromARGB(255, 70, 100, 100),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          '天気',
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Text(
                        style: TextStyle(fontSize: 16),
                        '${weatherData.weatherDescription}',
                        textAlign: TextAlign.right,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),

                Row(
                  children: [
                    Container(
                      color: Color.fromARGB(255, 70, 100, 100),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          '温度',
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Text(
                        style: TextStyle(fontSize: 16),
                        '${weatherData.temperature} 度',
                        textAlign: TextAlign.right,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Container(
                      color: Color.fromARGB(255, 70, 100, 100),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          '湿度',
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Text(
                        style: TextStyle(fontSize: 16),
                        '${weatherData.humidity} %',
                        textAlign: TextAlign.right,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30),
                comparisonState.when(
                  loading: () => const Center(
                    child: CircularProgressIndicator(value: null),
                  ),
                  error: (err, stack) => Center(child: Text('気温取得エラー: $err')),
                  data: (comparisonData) {
                    if (comparisonData == null) {
                      return const Center(child: Text('比較データがありません'));
                    }

                    final min = comparisonData.minTempLocation;
                    final max = comparisonData.maxTempLocation;
                    final minDifferenceText = minDiff(weatherData, min.temperature);
                    final maxDifferenceText = maxDiff(weatherData, max.temperature);

                    return
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: Column(
                          children: [
                            Text('${weatherData.areaName}と各地の気温差について',style: TextStyle(fontSize: 20),),
                            SizedBox(height: 30),
                            Text('日本で平均気温が低い「${min.areaName}（現在${min.temperature}度）」より${minDifferenceText}度暖かいです'),
                            SizedBox(height: 10),
                            Text('日本で平均気温が高い「${max.areaName}（現在${max.temperature}度）」より${maxDifferenceText}度寒いです。')],
                        ),
                      );

                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
