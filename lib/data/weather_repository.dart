import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/model/weather_data.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

// API情報
const ApiUrl = 'https://api.openweathermap.org/data/2.5/weather?appid=';
final ApiKey = dotenv.get('WEATHER_API_KEY');
const ApiParam = '&lang=ja&units=metric&q=';
String query = '';

/**
 * 天気情報取得APIデータ取得
 */
class WeatherRepository {
  Future<WeatherData> loadWeather(String query) async {

    final response = await http.get(
      Uri.parse(ApiUrl + ApiKey + ApiParam + query),
    );

    // API失敗
    if (response.statusCode != 200) {
      throw Exception('Faild to load Weather data');
    }

    // API成功
    final body = json.decode(response.body) as Map<String, dynamic>;
    // final main = (body['main'] ?? {}) as Map<String, dynamic>;
    return WeatherData.fromJson(body);
  }
}

/**
 * リポジトリのインスタンスを提供するプロバイダ
 */
final weatherRepositoryProvider = Provider<WeatherRepository>((ref) {
  return WeatherRepository();
});
