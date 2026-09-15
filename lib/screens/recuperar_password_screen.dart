import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../services/auth_service.dart';

/// Recuperar contraseña — a la que lleva el link de Login.
class RecuperarPasswordScreen extends StatefulWidget {
  const RecuperarPasswordScreen({super.key});

  @override
  State<RecuperarPasswordScreen> createState() => _RecuperarPasswordScreenState();
}

class _RecuperarPasswordScreenState extends State<RecuperarPasswordScreen> {
  final _controller = TextEditingController();
  bool _loading = false;
  bool _enviado = false;
  String? _error;

  Future<void> _enviar() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      await AuthService().resetPasswordForEmail(_controller.text.trim());
      setState(() => _enviado = true);
    } catch (e) {
      setState(() => _error = 'No se pudo enviar el correo. Comprueba el email.');
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
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: const Icon(Icons.arrow_back, size: 20, color: AppColors.textPrimary),
                ),
                const SizedBox(height: 24),
                Text('Recuperar contraseña', style: AppTextStyles.tituloGrande.copyWith(fontSize: 20)),
                const SizedBox(height: 10),
                Text('Te enviaremos un enlace a tu email para crear una nueva contraseña.', style: AppTextStyles.cuerpo.copyWith(fontSize: 13, color: AppColors.textSecondary)),
                const SizedBox(height: 24),
                if (_enviado) ...[
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14)),
                    child: Text('Listo — revisa tu bandeja de entrada en ${_controller.text.trim()}.', style: AppTextStyles.cuerpo.copyWith(fontSize: 13)),
                  ),
                ] else ...[
                  Container(
                    decoration: BoxDecoration(color: Colors.white, border: Border.all(color: AppColors.border), borderRadius: BorderRadius.circular(14)),
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: TextField(
                      controller: _controller,
                      keyboardType: TextInputType.emailAddress,
                      style: AppTextStyles.cuerpo.copyWith(fontSize: 14),
                      decoration: InputDecoration(border: InputBorder.none, hintText: 'Email', hintStyle: AppTextStyles.secundario.copyWith(fontSize: 14)),
                    ),
                  ),
                  if (_error != null) ...[
                    const SizedBox(height: 8),
                    Text(_error!, style: AppTextStyles.caption.copyWith(color: AppColors.error)),
                  ],
                  const SizedBox(height: 20),
                  Opacity(
                    opacity: _loading ? 0.6 : 1,
                    child: GestureDetector(
                      onTap: _loading ? null : _enviar,
                      child: Container(
                        height: 52,
                        decoration: BoxDecoration(gradient: AppGradients.primary, borderRadius: BorderRadius.circular(26)),
                        child: Container(
                          margin: const EdgeInsets.all(2),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(24)),
                          child: _loading
                              ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2.4, color: AppColors.gradientStart))
                              : Text('Enviar instrucciones', style: AppTextStyles.cuerpo.copyWith(fontSize: 14, fontWeight: FontWeight.w500)),
                        ),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
