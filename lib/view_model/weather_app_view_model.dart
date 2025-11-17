import 'package:flutter_riverpod/legacy.dart';
import 'package:weather_app/state/weather_app_state.dart';

class WeatherAppStateNotifier extends StateNotifier<WeatherAppState> {
  WeatherAppStateNotifier() : super(const WeatherAppState());

  void increment() {
    state = state.copyWith(state.counter + 1);
  }
}