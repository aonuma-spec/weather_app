
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app/main.dart';

class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(title),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children:
              const<Widget> [CountUp(), ButtonAction()],
          ),
        ),
      ),
    );
  }
}

class CountUp extends ConsumerWidget {
  const CountUp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    print("widgetBをビルド");
    final int counter = ref.watch(weatherAppProvider).counter;

    return Text(
      '${counter}',
      style: Theme.of(context).textTheme.headlineMedium,
    );
  }
}

class ButtonAction extends ConsumerWidget {
  const ButtonAction({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final Function increment = ref.read(myHomePageProvider.notifier).increment; // この行は削除（またはコメントアウト）

    final increment = ref.read(weatherAppProvider.notifier).increment;

    return ElevatedButton(
      onPressed: increment,
      child: const Icon(Icons.add),
    );
  }
}