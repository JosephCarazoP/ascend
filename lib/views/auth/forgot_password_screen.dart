import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controllers/auth_controller.dart';
import '../shared/auth_screen_shell.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  bool _isLoading = false;
  String? _message;
  bool _isError = false;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
      _message = null;
      _isError = false;
    });

    try {
      await context.read<AuthController>().resetPassword(_emailController.text);

      if (!mounted) {
        return;
      }

      setState(() {
        _message = 'Te enviamos un correo para restablecer tu contraseña.';
      });
    } catch (_) {
      if (!mounted) {
        return;
      }

      setState(() {
        _message = 'No se pudo enviar el correo de recuperación.';
        _isError = true;
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
    final colorScheme = Theme.of(context).colorScheme;

    return AuthScreenShell(
      appBarTitle: 'Recuperar contraseña',
      icon: Icons.key_outlined,
      title: 'Recuperar acceso',
      subtitle: 'Te enviaremos un enlace de restablecimiento.',
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
              validator: (value) {
                final email = value?.trim() ?? '';

                if (email.isEmpty || !email.contains('@')) {
                  return 'Ingresa un correo válido.';
                }

                return null;
              },
            ),
            if (_message != null) ...[
              const SizedBox(height: 12),
              Text(
                _message!,
                style: TextStyle(
                  color: _isError ? colorScheme.error : colorScheme.secondary,
                ),
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
                  : const Text('Enviar correo'),
            ),
            const SizedBox(height: 8),
            TextButton(
              onPressed: _isLoading
                  ? null
                  : () => Navigator.of(context).pushNamed('/login'),
              child: const Text('Volver a iniciar sesión'),
            ),
          ],
        ),
      ),
    );
  }
}
