/**
 * 天気取得APIレスポンスモデル
 */
class WeatherData {
  final String areaName;             // 地域名
  final String weather;              // 天気
  final String weatherDescription;   // 天気説明
  final double temperature;          // 気温
  final int humidity;                // 湿度
  final double temperatureMax;       // 最高気温
  final double temperatureMin;       // 最低気温

  WeatherData({
    required this.areaName,
    required this.weather,
    required this.weatherDescription,
    required this.temperature,
    required this.humidity,
    required this.temperatureMax,
    required this.temperatureMin,
  });

  factory WeatherData.fromJson(Map<String,  dynamic> json) {
    final main = (json['main'] ?? {}) as Map<String,  dynamic>;
    final List<dynamic> weatherList = json['weather'] ?? [];
    final String description = weatherList.isNotEmpty ? (weatherList[0]['description'] as String? ?? '不明') : '不明';
    final String weather = weatherList.isNotEmpty ? (weatherList[0]['main'] as String? ?? '不明') : '不明';

    return WeatherData(
        areaName: json['name'] ?? '',
        weather: weather,
        weatherDescription: description,
        temperature: (main['temp'] ?? 0.0) as double,
        humidity: (main['humidity'] ?? 0) as int,
        temperatureMax: (main['temperatureMax'] ?? 0.0) as double,
        temperatureMin: (main['temperatureMin'] ?? 0.0) as double,
    );
  }
}