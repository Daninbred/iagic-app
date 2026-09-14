import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/nyx_mascot.dart';
import '../widgets/onboarding_shared.dart';
import 'onboarding_web_paso2_screen.dart';

/// Onboarding Web Developer — Paso 1: intro de Nyx.
class OnboardingWebPaso1Screen extends StatelessWidget {
  const OnboardingWebPaso1Screen({super.key});

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
              const OnboardingHeader(titulo: 'Webmaster', paso: 1, total: 3),
              const SizedBox(height: 20),
              const OnboardingPrompt(
                mascota: NyxMascot(size: 44),
                mensaje: 'Hola, mi nombre es Nyx, yo me voy a encargar de diseñar tu página web.',
              ),
              const Spacer(),
              const Center(child: NyxMascot(size: 120)),
              const Spacer(),
              GestureDetector(
                onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const OnboardingWebPaso2Screen())),
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
            ],
          ),
        ),
      ),
    );
  }
}
