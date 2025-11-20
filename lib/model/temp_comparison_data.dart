import 'package:weather_app/model/weather_data.dart';

/**
 * 各地との気温差モデル
 */
class TempComparisonData {
  final WeatherData minTempLocation; //平均気温が低い地域情報
  final WeatherData maxTempLocation; //平均気温が高い地域情報

  TempComparisonData({
    required this.minTempLocation,
    required this.maxTempLocation,
  });
}