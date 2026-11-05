import 'package:flutter/material.dart';
import 'package:playgroundmobile/injection.dart';
import 'package:playgroundmobile/stores/auth/auth_store.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final _authStore = getIt<AuthStore>();

  @override
  void initState() {
    super.initState();
    _checkAuth();
  }

  Future<void> _checkAuth() async {
    await _authStore.checkSession();

    if (!mounted) return;

    if (_authStore.isAuthenticated) {
      Navigator.pushNamedAndRemoveUntil(
        context,
        '/home',
        (_) => false,
      );
      (
        context, 
      '/home',

      );
    } else {
      Navigator.pushReplacementNamed(context, '/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}