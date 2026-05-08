import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controllers/auth_controller.dart';
import '../../services/auth_service.dart';
import '../shared/auth_screen_shell.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _isLoading = false;
  String? _error;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      await context.read<AuthController>().register(
        _emailController.text,
        _passwordController.text,
      );

      if (!mounted) {
        return;
      }

      Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
    } catch (_) {
      if (!mounted) {
        return;
      }

      if (context.read<AuthService>().currentUser != null) {
        Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
        return;
      }

      setState(() {
        _error = 'No se pudo crear la cuenta.';
      });
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AuthScreenShell(
      appBarTitle: 'Registro',
      icon: Icons.person_add_alt_outlined,
      title: 'Crear cuenta',
      subtitle: 'Tu perfil iniciará como usuario Basic.',
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                labelText: 'Correo',
                prefixIcon: Icon(Icons.mail_outline),
                border: OutlineInputBorder(),
              ),
              validator: _requiredEmail,
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Contraseña',
                prefixIcon: Icon(Icons.lock_outline),
                border: OutlineInputBorder(),
              ),
              validator: _requiredPassword,
            ),
            if (_error != null) ...[
              const SizedBox(height: 12),
              Text(
                _error!,
                style: TextStyle(color: Theme.of(context).colorScheme.error),
              ),
            ],
            const SizedBox(height: 20),
            FilledButton(
              onPressed: _isLoading ? null : _submit,
              child: _isLoading
                  ? const SizedBox.square(
                      dimension: 18,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Text('Registrarme'),
            ),
            const SizedBox(height: 8),
            TextButton(
              onPressed: _isLoading
                  ? null
                  : () => Navigator.of(context).pushNamed('/login'),
              child: const Text('Ya tengo cuenta'),
            ),
          ],
        ),
      ),
    );
  }

  String? _requiredEmail(String? value) {
    final email = value?.trim() ?? '';

    if (email.isEmpty || !email.contains('@')) {
      return 'Ingresa un correo válido.';
    }

    return null;
  }

  String? _requiredPassword(String? value) {
    if ((value ?? '').length < 6) {
      return 'La contraseña debe tener al menos 6 caracteres.';
    }

    return null;
  }
}
