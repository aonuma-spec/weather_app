import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app/screen/weather_detail.dart';

// import 'package:weather_app/view_model/weather_app_view_model.dart';
import 'package:weather_app/view_model/weather_app_view_model.dart'
    show weatherViewModelProvider, weatherAppProvider;

class WeatherApp extends ConsumerWidget {
  const WeatherApp({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: Text('天気アプリ')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[const PlaceForm(), const CitySubmit()],
        ),
      ),
    );
  }
}

class PlaceForm extends ConsumerWidget {
  const PlaceForm({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appState = ref.watch(weatherAppProvider);
    final appStateNotifier = ref.read(weatherAppProvider.notifier);

    List<DropdownMenuItem<String>> dropdownItems = appState.cities.entries.map((
      entry,
    ) {
      return DropdownMenuItem(value: entry.key, child: Text(entry.value));
    }).toList();

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          Text('地域を選択してください'),
          DropdownButton<String>(
            value: appState.selectedCityValue,
            items: dropdownItems,
            onChanged: (String? newValue) {
              if (newValue != null) {
                appStateNotifier.updateSelectedCit(newValue);
              }
            },
          ),
        ],
      ),
    );
  }
}

class CitySubmit extends ConsumerWidget {
  const CitySubmit({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedCity = ref.watch(weatherAppProvider).selectedCityValue;
    final weatherViewModel = ref.read(weatherViewModelProvider.notifier);

    return ElevatedButton(
      onPressed: () async {
        await weatherViewModel.loadWeather(selectedCity);

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return WeatherDetail();
            },
          ),
        );
      },
      child: Text('送信する'),
    );
  }
}
