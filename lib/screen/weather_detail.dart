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
                // ... 他の天気情報
              ],
            ),
          );
        },
      ),
    );
  }
}
