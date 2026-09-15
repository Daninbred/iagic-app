import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../services/auth_service.dart';
import 'recuperar_password_screen.dart';

/// Login — a la que lleva el link "Ya tengo cuenta" desde Registro.
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key, required this.onLoginExitoso});

  final VoidCallback onLoginExitoso;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _authService = AuthService();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscure = true;
  bool _loading = false;
  String? _error;

  Future<void> _login() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      await _authService.signInWithEmail(
        email: _emailController.text.trim(),
        password: _passwordController.text,
      );
      widget.onLoginExitoso();
    } catch (e) {
      setState(() => _error = 'Email o contraseña incorrectos');
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: AppGradients.authBackground),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'IAGIC',
                  textAlign: TextAlign.center,
                  style: AppTextStyles.tituloMediano.copyWith(
                    fontWeight: FontWeight.w400,
                    letterSpacing: 2.5,
                    color: const Color(0xFF4A3AAE),
                  ),
                ),
                const SizedBox(height: 40),
                _AuthField(controller: _emailController, hint: 'Email'),
                const SizedBox(height: 12),
                _AuthField(
                  controller: _passwordController,
                  hint: 'Contraseña',
                  obscure: _obscure,
                  onToggleObscure: () => setState(() => _obscure = !_obscure),
                ),
                if (_error != null) ...[
                  const SizedBox(height: 10),
                  Text(_error!, style: AppTextStyles.caption.copyWith(color: AppColors.error)),
                ],
                const SizedBox(height: 10),
                Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const RecuperarPasswordScreen())),
                    child: Text(
                      '¿Olvidaste tu contraseña?',
                      style: TextStyle(fontSize: 12, color: AppColors.linkSoft, decoration: TextDecoration.underline),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Opacity(
                  opacity: _loading ? 0.6 : 1,
                  child: GestureDetector(
                    onTap: _loading ? null : _login,
                    child: Container(
                      height: 52,
                      decoration: BoxDecoration(color: AppColors.gradientStart, borderRadius: BorderRadius.circular(26)),
                      alignment: Alignment.center,
                      child: _loading
                          ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                            )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('Login', style: AppTextStyles.cuerpo.copyWith(fontSize: 14, color: Colors.white, fontWeight: FontWeight.w500)),
                                const SizedBox(width: 8),
                                const Icon(Icons.arrow_forward, size: 18, color: Colors.white),
                              ],
                            ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _AuthField extends StatelessWidget {
  const _AuthField({required this.controller, required this.hint, this.obscure = false, this.onToggleObscure});
  final TextEditingController controller;
  final String hint;
  final bool obscure;
  final VoidCallback? onToggleObscure;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.white, border: Border.all(color: AppColors.border), borderRadius: BorderRadius.circular(14)),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              obscureText: obscure,
              style: AppTextStyles.cuerpo.copyWith(fontSize: 14),
              decoration: InputDecoration(border: InputBorder.none, hintText: hint, hintStyle: AppTextStyles.secundario.copyWith(fontSize: 14)),
            ),
          ),
          if (onToggleObscure != null)
            GestureDetector(
              onTap: onToggleObscure,
              child: Icon(obscure ? Icons.visibility_off_outlined : Icons.visibility_outlined, size: 18, color: AppColors.textSecondary),
            ),
        ],
      ),
    );
  }
}
