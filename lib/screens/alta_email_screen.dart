import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import '../theme/app_theme.dart';
import '../services/auth_service.dart';
import 'confirmacion_email_screen.dart';
import 'terminos_screen.dart';

/// Alta con email — email + contraseña + confirmar + checkbox de Términos.
/// El botón "Continuar" se activa solo cuando el checkbox está marcado
/// y las contraseñas coinciden.
class AltaEmailScreen extends StatefulWidget {
  const AltaEmailScreen({super.key});

  @override
  State<AltaEmailScreen> createState() => _AltaEmailScreenState();
}

class _AltaEmailScreenState extends State<AltaEmailScreen> {
  final _authService = AuthService();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();
  bool _obscurePassword = true;
  bool _obscureConfirm = true;
  bool _acceptedTerms = false;
  bool _loading = false;
  String? _error;

  bool get _passwordsMatch => _passwordController.text == _confirmController.text;

  bool get _canContinue =>
      _emailController.text.isNotEmpty &&
      _passwordController.text.isNotEmpty &&
      _confirmController.text.isNotEmpty &&
      _passwordsMatch &&
      _acceptedTerms;

  Future<void> _continuar() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      await _authService.signUpWithEmail(
        email: _emailController.text.trim(),
        password: _passwordController.text,
      );
      if (!mounted) return;
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) => ConfirmacionEmailScreen(
            email: _emailController.text.trim(),
            onContinuar: () {
              // Avanza al onboarding de Business Developer — no bloquea
              // por confirmación de email (decisión ya fijada).
              // La ruta real se conecta cuando exista OnboardingBDScreen.
            },
          ),
        ),
      );
    } catch (e) {
      setState(() => _error = 'No se pudo completar el registro. Inténtalo de nuevo.');
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
                const SizedBox(height: 32),
                _AuthInput(
                  controller: _emailController,
                  hint: 'Email',
                  onChanged: (_) => setState(() {}),
                ),
                const SizedBox(height: 12),
                _AuthInput(
                  controller: _passwordController,
                  hint: 'Contraseña',
                  obscure: _obscurePassword,
                  onToggleObscure: () => setState(() => _obscurePassword = !_obscurePassword),
                  onChanged: (_) => setState(() {}),
                ),
                const SizedBox(height: 12),
                _AuthInput(
                  controller: _confirmController,
                  hint: 'Confirmar contraseña',
                  obscure: _obscureConfirm,
                  onToggleObscure: () => setState(() => _obscureConfirm = !_obscureConfirm),
                  onChanged: (_) => setState(() {}),
                ),
                if (_confirmController.text.isNotEmpty && !_passwordsMatch) ...[
                  const SizedBox(height: 6),
                  Text('Las contraseñas no coinciden', style: AppTextStyles.caption.copyWith(color: AppColors.error)),
                ],
                if (_error != null) ...[
                  const SizedBox(height: 6),
                  Text(_error!, style: AppTextStyles.caption.copyWith(color: AppColors.error)),
                ],
                const SizedBox(height: 20),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () => setState(() => _acceptedTerms = !_acceptedTerms),
                      child: Container(
                        width: 18,
                        height: 18,
                        margin: const EdgeInsets.only(top: 2, right: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: AppColors.gradientStart, width: 1.5),
                          color: _acceptedTerms ? AppColors.gradientStart : Colors.transparent,
                        ),
                        child: _acceptedTerms ? const Icon(Icons.check, size: 13, color: Colors.white) : null,
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () => setState(() => _acceptedTerms = !_acceptedTerms),
                        child: Text.rich(
                          TextSpan(
                            text: 'Al continuar aceptas nuestros ',
                            style: AppTextStyles.caption,
                            children: [
                              TextSpan(
                                text: 'términos del servicio y política de privacidad',
                                style: const TextStyle(color: AppColors.linkSoft, decoration: TextDecoration.underline, fontSize: 12),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const TerminosScreen())),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 28),
                _GradientBorderButton(
                  text: 'Continuar',
                  enabled: _canContinue && !_loading,
                  loading: _loading,
                  onTap: _continuar,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _AuthInput extends StatelessWidget {
  const _AuthInput({
    required this.controller,
    required this.hint,
    required this.onChanged,
    this.obscure = false,
    this.onToggleObscure,
  });

  final TextEditingController controller;
  final String hint;
  final bool obscure;
  final VoidCallback? onToggleObscure;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: AppColors.border),
        borderRadius: BorderRadius.circular(14),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              obscureText: obscure,
              onChanged: onChanged,
              style: AppTextStyles.cuerpo.copyWith(fontSize: 14),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: hint,
                hintStyle: AppTextStyles.secundario.copyWith(fontSize: 14),
              ),
            ),
          ),
          if (onToggleObscure != null)
            GestureDetector(
              onTap: onToggleObscure,
              child: Icon(
                obscure ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                size: 18,
                color: AppColors.textSecondary,
              ),
            ),
        ],
      ),
    );
  }
}

class _GradientBorderButton extends StatelessWidget {
  const _GradientBorderButton({
    required this.text,
    required this.onTap,
    this.enabled = true,
    this.loading = false,
  });

  final String text;
  final VoidCallback onTap;
  final bool enabled;
  final bool loading;

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: enabled ? 1.0 : 0.4,
      child: GestureDetector(
        onTap: enabled ? onTap : null,
        child: Container(
          height: 52,
          decoration: BoxDecoration(gradient: AppGradients.primary, borderRadius: BorderRadius.circular(26)),
          child: Container(
            margin: const EdgeInsets.all(2),
            alignment: Alignment.center,
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(24)),
            child: loading
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2.4, color: AppColors.gradientStart),
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(text, style: AppTextStyles.cuerpo.copyWith(fontSize: 14, fontWeight: FontWeight.w500)),
                      const SizedBox(width: 8),
                      const Icon(Icons.arrow_forward, size: 18, color: AppColors.textPrimary),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
