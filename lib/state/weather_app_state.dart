class WeatherAppState {
  const WeatherAppState({
    /** 地域一覧 */
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

  /** 地域 */
  final Map<String, String> cities;

  /** 選択中の地域 */
  final String selectedCityValue;

  /** 選択中の地域更新 */
  WeatherAppState copyWith({String? selectedCityValue}) {
    return WeatherAppState(
      selectedCityValue: selectedCityValue ?? this.selectedCityValue,
    );
  }
}
