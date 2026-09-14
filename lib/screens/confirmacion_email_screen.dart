import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../services/auth_service.dart';

/// Confirmación enviada — se muestra tras el registro por email.
/// NO bloquea el avance (decisión ya fijada): el usuario puede seguir
/// al onboarding sin haber confirmado todavía.
class ConfirmacionEmailScreen extends StatefulWidget {
  const ConfirmacionEmailScreen({super.key, required this.email, required this.onContinuar});

  final String email;
  final VoidCallback onContinuar;

  @override
  State<ConfirmacionEmailScreen> createState() => _ConfirmacionEmailScreenState();
}

class _ConfirmacionEmailScreenState extends State<ConfirmacionEmailScreen> {
  final _authService = AuthService();
  bool _reenviando = false;
  String? _mensaje;

  Future<void> _reenviar() async {
    setState(() {
      _reenviando = true;
      _mensaje = null;
    });
    try {
      await _authService.resendConfirmationEmail(widget.email);
      setState(() => _mensaje = 'Correo reenviado.');
    } catch (e) {
      setState(() => _mensaje = 'No se pudo reenviar, inténtalo de nuevo.');
    } finally {
      setState(() => _reenviando = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: AppGradients.authBackground),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
            child: Column(
              children: [
                Text(
                  'IAGIC',
                  style: AppTextStyles.tituloMediano.copyWith(
                    fontWeight: FontWeight.w400,
                    letterSpacing: 2.5,
                    color: const Color(0xFF4A3AAE),
                  ),
                ),
                const Spacer(),
                Container(
                  width: 72,
                  height: 72,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: AppGradients.primary,
                  ),
                  child: const Icon(Icons.mail_outline, color: Colors.white, size: 32),
                ),
                const SizedBox(height: 28),
                Text(
                  'Te hemos enviado un email, revisa tu bandeja de entrada',
                  textAlign: TextAlign.center,
                  style: AppTextStyles.cuerpo,
                ),
                const SizedBox(height: 6),
                Text(
                  widget.email,
                  textAlign: TextAlign.center,
                  style: AppTextStyles.secundario.copyWith(fontWeight: FontWeight.w500),
                ),
                const Spacer(),
                if (_mensaje != null) ...[
                  Text(_mensaje!, style: AppTextStyles.caption),
                  const SizedBox(height: 8),
                ],
                GestureDetector(
                  onTap: _reenviando ? null : _reenviar,
                  child: Text(
                    _reenviando ? 'Reenviando…' : 'No he recibido ningún correo',
                    style: TextStyle(
                      fontSize: 13,
                      color: AppColors.linkSoft,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                _GradientBorderButtonSmall(text: 'Continuar', onTap: widget.onContinuar),
                const SizedBox(height: 12),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _GradientBorderButtonSmall extends StatelessWidget {
  const _GradientBorderButtonSmall({required this.text, required this.onTap});
  final String text;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 52,
        decoration: BoxDecoration(gradient: AppGradients.primary, borderRadius: BorderRadius.circular(26)),
        child: Container(
          margin: const EdgeInsets.all(2),
          alignment: Alignment.center,
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(24)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(text, style: AppTextStyles.cuerpo.copyWith(fontSize: 14, fontWeight: FontWeight.w500)),
              const SizedBox(width: 8),
              const Icon(Icons.arrow_forward, size: 18, color: AppColors.textPrimary),
            ],
          ),
        ),
      ),
    );
  }
}
