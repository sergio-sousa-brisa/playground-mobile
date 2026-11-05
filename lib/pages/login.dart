import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:playgroundmobile/injection.dart';
import 'package:playgroundmobile/stores/auth/auth_store.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _userController = TextEditingController();
  final _passwordController = TextEditingController();
  
  // Recupera a instância singleton registrada no injection.dart
  final _authStore = getIt<AuthStore>();

  bool _obscurePassword = true;

  @override
  void dispose() {
    _userController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    // Fecha o teclado virtual
    FocusScope.of(context).unfocus();

    if (_formKey.currentState?.validate() ?? false) {
      final success = await _authStore.login(
        _userController.text.trim(),
        _passwordController.text,
      );

      if (success && mounted) {
        Navigator.pushReplacementNamed(context, '/home');
      }
    }
  }

  Future<void> _handleRegister() async {
    FocusScope.of(context).unfocus();

    if (_formKey.currentState?.validate() ?? false) {
      final success = await _authStore.register(
        _userController.text.trim(),
        _passwordController.text,
      );

      if (success && mounted) {
        Navigator.restorablePushNamedAndRemoveUntil(
          context, 
          '/home',
          (route) => false,);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Icon(
                  Icons.lock_person_rounded,
                  size: 72,
                  color: Colors.blueAccent,
                ),
                const SizedBox(height: 16),
                const Text(
                  'Acesso Seguro',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 32),

                // Campo: Nome de Usuário
                TextFormField(
                  controller: _userController,
                  decoration: const InputDecoration(
                    labelText: 'Nome de usuário',
                    prefixIcon: Icon(Icons.person_outline),
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Informe o nome de usuário';
                    }
                    if (value.trim().length < 3) {
                      return 'O nome precisa ter pelo menos 3 caracteres';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Campo: Palavra-passe / Senha
                TextFormField(
                  controller: _passwordController,
                  obscureText: _obscurePassword,
                  decoration: InputDecoration(
                    labelText: 'Senha',
                    prefixIcon: const Icon(Icons.lock_outline),
                    border: const OutlineInputBorder(),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscurePassword
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      },
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Informe a sua senha';
                    }
                    if (value.length < 4) {
                      return 'A senha deve conter no mínimo 4 caracteres';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Mensagem de Erro Reativa do MobX
                Observer(
                  builder: (_) {
                    if (_authStore.errorMessage == null) {
                      return const SizedBox.shrink();
                    }
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12.0),
                      child: Text(
                        _authStore.errorMessage!,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.red,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    );
                  },
                ),

                // Botão de Login com Indicador de Loading
                Observer(
                  builder: (_) {
                    if (_authStore.isLoading) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        ElevatedButton(
                          onPressed: _handleLogin,
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 14),
                          ),
                          child: const Text(
                            'Entrar',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                        const SizedBox(height: 8),
                        TextButton(
                          onPressed: _handleRegister,
                          child: const Text('Criar nova conta neste aparelho'),
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}