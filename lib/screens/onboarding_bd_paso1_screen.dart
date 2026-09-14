import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/zael_mascot.dart';
import '../widgets/onboarding_shared.dart';

/// Onboarding BD — Paso 1/8: Bienvenida general a la app.
class OnboardingBienvenidaScreen extends StatelessWidget {
  const OnboardingBienvenidaScreen({super.key, required this.onContinuar});
  final VoidCallback onContinuar;

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
              const OnboardingHeader(titulo: 'Bienvenida', paso: 1, total: 8),
              const SizedBox(height: 20),
              OnboardingPrompt(
                mascota: const ZaelMascot(size: 44),
                mensaje: '¡Hola! y bienvenido a iagic, te vamos a ayudar a configurar tu nueva empresa desde 0, en unos sencillos pasos, ¡la vas a tener lista en tiempo récord!',
              ),
              const Spacer(),
              const Center(child: ZaelMascot(size: 120)),
              const Spacer(),
              _ContinuarButton(onTap: onContinuar),
            ],
          ),
        ),
      ),
    );
  }
}

class _ContinuarButton extends StatelessWidget {
  const _ContinuarButton({required this.onTap});
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
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
    );
  }
}
