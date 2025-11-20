import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app/screen/weather_detail.dart';

// import 'package:weather_app/view_model/weather_app_view_model.dart';
import 'package:weather_app/view_model/weather_app_view_model.dart'
    show weatherViewModelProvider, weatherAppProvider;

/**
 * トップページ
 */
class WeatherApp extends ConsumerWidget {
  const WeatherApp({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      // タイトル
      appBar: AppBar(
        title: Text('天気アプリ', style: TextStyle(color: Colors.white)),
        backgroundColor: Color.fromARGB(255, 70, 100, 100),
      ),
      // 画面
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[const PlaceForm(), const CitySubmit()],
        ),
      ),
    );
  }
}

/**
 * 地域選択欄
 */
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
          Container(
            child: Image.asset('assets/job_otenki_oneesan.png'),
            width: 180,
          ),
          SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text('地域を選択してください', style: TextStyle(fontSize: 20)),
          ),
          SizedBox(height: 10),

          // ドロップダウンで地域を選択する
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

/**
 * 地域送信機能
 * 地域ごとの天気詳細ページへ移動
 */
class CitySubmit extends ConsumerWidget {
  const CitySubmit({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 選択中地域の監視
    final selectedCity = ref.watch(weatherAppProvider).selectedCityValue;
    final weatherViewModel = ref.read(weatherViewModelProvider.notifier);

    // 送信ボタン
    // ボタン押下時に、選択した地域で天気取得API実行を行い詳細画面に表示する
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
