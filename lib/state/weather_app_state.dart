class WeatherAppState {
  const WeatherAppState({
    this.cities = const {
      "tokyo": "東京",
      "sapporo": "札幌",
      "sendai": "仙台",
      "niigata": "新潟",
      "tochigi": "栃木",
      "osaka": "大阪",
      "kagoshima": "鹿児島",
      "Okinawa,jp": "沖縄",
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
