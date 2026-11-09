import 'package:flutter/material.dart';
import 'package:playgroundmobile/injection.dart';
import 'package:playgroundmobile/pages/login.dart';
import 'package:playgroundmobile/pages/splash.dart';
import 'package:playgroundmobile/pages/tabs.dart';
import 'package:playgroundmobile/services/api_service.dart';
import 'package:playgroundmobile/services/secure_store_service.dart';

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
    return MaterialApp(
      theme: theme, 
      initialRoute: '/',
      routes:  {
        '/':(_) => const SplashPage(),
        '/home': (_)   => const Tabs(),
        '/login':(_) =>  const LoginPage()
      },
      debugShowCheckedModeBanner: false,
      );
  }
}
