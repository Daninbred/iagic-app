import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/onboarding_shared.dart';
import '../widgets/zael_mascot.dart';

/// Onboarding BD — Paso 2/8: Sobre ti (nombre, email, texto libre).
/// Estos datos escriben en perfil_negocio (nombre_usuario, email).
class OnboardingSobreTiScreen extends StatefulWidget {
  const OnboardingSobreTiScreen({super.key, required this.onContinuar});
  final void Function(String nombre, String email, String sobreTi) onContinuar;

  @override
  State<OnboardingSobreTiScreen> createState() => _OnboardingSobreTiScreenState();
}

class _OnboardingSobreTiScreenState extends State<OnboardingSobreTiScreen> {
  final _nombreController = TextEditingController();
  final _emailController = TextEditingController();
  final _sobreTiController = TextEditingController();

  bool get _canContinue => _nombreController.text.isNotEmpty && _emailController.text.isNotEmpty;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const OnboardingHeader(titulo: 'Sobre tí', paso: 2, total: 8),
              const SizedBox(height: 20),
              const OnboardingPrompt(mascota: ZaelMascot(size: 44), mensaje: 'Primero Háblanos de tí'),
              const SizedBox(height: 20),
              _Field(controller: _nombreController, hint: 'Nombre', onChanged: (_) => setState(() {})),
              const SizedBox(height: 12),
              _Field(controller: _emailController, hint: 'Email', onChanged: (_) => setState(() {})),
              const SizedBox(height: 12),
              _Field(
                controller: _sobreTiController,
                hint: 'Cuéntanos un poco de tí (Máx 350 caracteres)',
                maxLength: 350,
                multiline: true,
                onChanged: (_) => setState(() {}),
              ),
              const Spacer(),
              _ContinuarButton(
                enabled: _canContinue,
                onTap: () => widget.onContinuar(
                  _nombreController.text.trim(),
                  _emailController.text.trim(),
                  _sobreTiController.text.trim(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Field extends StatelessWidget {
  const _Field({
    required this.controller,
    required this.hint,
    required this.onChanged,
    this.multiline = false,
    this.maxLength,
  });

  final TextEditingController controller;
  final String hint;
  final ValueChanged<String> onChanged;
  final bool multiline;
  final int? maxLength;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: AppColors.border),
        borderRadius: BorderRadius.circular(14),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        maxLines: multiline ? 4 : 1,
        maxLength: maxLength,
        style: AppTextStyles.cuerpo.copyWith(fontSize: 14),
        decoration: InputDecoration(
          border: InputBorder.none,
          counterText: '',
          hintText: hint,
          hintStyle: AppTextStyles.secundario.copyWith(fontSize: 14),
        ),
      ),
    );
  }
}

class _ContinuarButton extends StatelessWidget {
  const _ContinuarButton({required this.onTap, this.enabled = true});
  final VoidCallback onTap;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: enabled ? 1 : 0.4,
      child: GestureDetector(
        onTap: enabled ? onTap : null,
        child: Container(
          height: 52,
          decoration: BoxDecoration(gradient: AppGradients.primary, borderRadius: BorderRadius.circular(26)),
          child: Container(
            margin: const EdgeInsets.all(2),
            alignment: Alignment.center,
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(24)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Continuar', style: AppTextStyles.cuerpo.copyWith(fontSize: 14, fontWeight: FontWeight.w500)),
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
