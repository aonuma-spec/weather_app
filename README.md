# weather_app
Flutterで作成した天気アプリ。\
Weather APIからデータを取得し、画面に表示します。

## スクリーンショット
![アプリのスクリーンショット1](https://github.com/aonuma-spec/weather_app/blob/README_Images/readme_images/view_screen1.png)
![アプリのスクリーンショット2](https://github.com/aonuma-spec/weather_app/blob/README_Images/readme_images/view_screen2.png)

## 使用技術
- Android Studio
- Flutter

## 利用パッケージ
- flutter_dotenv
- flutter_riverpod

## 環境変数
- WEATHER_API_KEY: Weather APIより取得したAPIキーの値を設定

## ディレクトリ構成
lib  
|_main.dart  
|_data  
&nbsp;&nbsp;&nbsp;|_weather_repository.dart  
|_model  
&nbsp;&nbsp;&nbsp;|_temp_comparison_data.dart  
&nbsp;&nbsp;&nbsp;|_weather_data.dart  
|_screen  
&nbsp;&nbsp;&nbsp;|_weather_app.dart  
&nbsp;&nbsp;&nbsp;|_weather_detail.dart  
|_state  
&nbsp;&nbsp;&nbsp;|_weather_app_state.dart  
|_view_model  
&nbsp;&nbsp;&nbsp;|_weather_app_view_model.dart  
