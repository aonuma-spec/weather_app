import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:weather_app/model/weather_data.dart';
import 'package:weather_app/state/weather_app_state.dart';
import 'package:weather_app/data/weather_repository.dart';
import 'package:weather_app/state/weather_app_state.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/model/temp_comparison_data.dart';

class WeatherViewModel extends AsyncNotifier<WeatherData?> {
  @override
  Future<WeatherData?> build() async {
    return null;
  }

  Future<void> loadWeather(String query) async {

    try {
      final repository = ref.read(weatherRepositoryProvider);
      final weatherData = await repository.loadWeather(query);

      state = AsyncValue.data(weatherData);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}

final weatherViewModelProvider =
    AsyncNotifierProvider<WeatherViewModel, WeatherData?>(() {
      return WeatherViewModel();
    });

class WeatherAppStateNotifier extends StateNotifier<WeatherAppState> {
  WeatherAppStateNotifier() : super(const WeatherAppState());
  void updateSelectedCit (String newValue) {
    state = state.copyWith(selectedCityValue: newValue);
  }
}

final weatherAppProvider =
    StateNotifierProvider<WeatherAppStateNotifier, WeatherAppState>((ref) {
      return WeatherAppStateNotifier();
    });

final selectedCityProvider = StateProvider<String>((ref) => 'sendai');

// 気温比較用
const MinCityQuery = 'rikubetsu';
const MaxCityQuery = 'okinawa';

class CompareTempViewModel extends AsyncNotifier<TempComparisonData?> {
  @override
  Future<TempComparisonData?> build() async {

    final repository = ref.read(weatherRepositoryProvider);

    final MinCityTemp = repository.loadWeather(MinCityQuery);
    final MaxCityTemp = repository.loadWeather(MaxCityQuery);

    final minTempData = await MinCityTemp;
    final maxTempData = await MaxCityTemp;

    return TempComparisonData(minTempLocation: minTempData, maxTempLocation: maxTempData);
  }
}

final compareViewModelProvider = AsyncNotifierProvider<CompareTempViewModel, TempComparisonData?>(() {
  return CompareTempViewModel();
});