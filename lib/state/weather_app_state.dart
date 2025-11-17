

class WeatherAppState {
  const WeatherAppState({this.counter = 0});
  final int counter;

  WeatherAppState copyWith(int counter) => WeatherAppState(counter:counter);
}

