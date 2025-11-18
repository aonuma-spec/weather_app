import 'package:weather_app/model/weather_data.dart';

class TempComparisonData {
  final WeatherData minTempLocation;
  final WeatherData maxTempLocation;

  TempComparisonData({
    required this.minTempLocation,
    required this.maxTempLocation,
  });
}