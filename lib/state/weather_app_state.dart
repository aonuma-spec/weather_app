class WeatherAppState {
  const WeatherAppState({
    this.cities = const {
      "tokyo": "東京",
      "sapporo": "札幌",
      "niigata": "新潟",
      "osaka": "大阪",
    },
    this.selectedCityValue = "tokyo",
  });

  final Map<String, String> cities;
  final String selectedCityValue;

  WeatherAppState copyWith({
    String? selectedCityValue,
  }) {
    return WeatherAppState(
        selectedCityValue: selectedCityValue ?? this.selectedCityValue
    );
  }
}
