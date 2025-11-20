import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app/model/temp_comparison_data.dart';
import 'package:weather_app/model/weather_data.dart';
import 'package:weather_app/view_model/weather_app_view_model.dart';

/**
 * 天気詳細ページ
 */
class WeatherDetail extends ConsumerWidget {
  const WeatherDetail({super.key});

  /** 平均気温が低い地域との気温差を出力する */
  String minDiff(WeatherData currentData, double minTemperature) {
    final double? currentTemp = currentData.temperature;
    final double? minTemp = minTemperature;

    if (currentTemp == null || minTemp == null) {
      return '不明';
    }

    final difference = currentTemp - minTemp;

    // 気温差の表示が絶対値になるように修正
    final absoluteDifference = difference.abs().toStringAsFixed(1);

    return '${absoluteDifference}';
  }

  /** 平均気温が高い地域との気温差を出力する */
  String maxDiff(WeatherData currentData, double maxTemperature) {
    final double? currentTemp = currentData.temperature;
    final double? maxTemp = maxTemperature;

    if (currentTemp == null || maxTemp == null) {
      return '不明';
    }

    final difference = currentTemp - maxTemp;

    // 気温差の表示が絶対値になるように修正
    final absoluteDifference = difference.abs().toStringAsFixed(1);

    return '${absoluteDifference}';
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final weatherState = ref.watch(weatherViewModelProvider);
    final comparisonState = ref.watch(compareViewModelProvider);

    return Scaffold(
      // タイトル
      appBar: AppBar(
        title: Text('天気詳細', style: TextStyle(color: Colors.white)),
        backgroundColor: Color.fromARGB(255, 70, 100, 100),
      ),
      // 画面
      body: weatherState.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('エラー: $err')),
        data: (weatherData) {
          if (weatherData == null) {
            return const Center(child: Text('データがありません'));
          }
          // 天候ごとに画像を表示する
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
                // 地域を表示
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
                // 天気を表示
                weatherInfo(
                  infoTitle: '天気',
                  infoData: weatherData.weatherDescription,
                ),
                SizedBox(height: 10),

                // 温度を表示
                weatherInfo(
                    infoTitle: '温度',
                    infoData: weatherData.temperature.toString(),
                ),
                SizedBox(height: 10),

                // 湿度を表示
                weatherInfo(
                    infoTitle: '湿度',
                    infoData: weatherData.humidity.toString(),
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

                    // 平均気温比較用の地域情報
                    final min = comparisonData.minTempLocation;
                    final max = comparisonData.maxTempLocation;

                    // 平均気温比較結果の気温差
                    final minDifferenceText = minDiff(
                      weatherData,
                      min.temperature,
                    );
                    final maxDifferenceText = maxDiff(
                      weatherData,
                      max.temperature,
                    );

                    // 選択中の地域と各地との気温差を表示
                    return Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: Column(
                        children: [
                          Text(
                            '${weatherData.areaName}と各地の気温差について',
                            style: TextStyle(fontSize: 20),
                          ),
                          SizedBox(height: 30),
                          Text(
                            '日本で平均気温が低い「${min.areaName}（現在${min.temperature}度）」より${minDifferenceText}度暖かいです',
                          ),
                          SizedBox(height: 10),
                          Text(
                            '日本で平均気温が高い「${max.areaName}（現在${max.temperature}度）」より${maxDifferenceText}度寒いです。',
                          ),
                        ],
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

/**
 * 天候詳細情報表示
 */
class weatherInfo extends StatelessWidget {
  final String infoTitle;
  final String infoData;

  const weatherInfo({
    Key? key,
    required this.infoTitle,
    required this.infoData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          color: Color.fromARGB(255, 70, 100, 100),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              '${infoTitle}',
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Text(
            style: TextStyle(fontSize: 16),
            '${infoData}',
            textAlign: TextAlign.right,
          ),
        ),
      ],
    );
  }
}
