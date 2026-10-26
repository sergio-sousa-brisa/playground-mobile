import 'package:flutter/material.dart';
import 'package:playgroundmobile/injection.dart';
import 'package:playgroundmobile/pages/tabs.dart';

final theme = ThemeData(
  colorScheme: ColorScheme.fromSeed(
    seedColor: const Color.fromARGB(255, 16, 66, 77),
    brightness: Brightness.dark,
  ),
);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupDependencies();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(theme: theme, home: const Tabs());
  }
}
