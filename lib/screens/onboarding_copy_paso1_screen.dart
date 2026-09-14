import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/fenix_mascot.dart';
import '../widgets/onboarding_shared.dart';
import 'onboarding_copy_paso2_screen.dart';

/// Onboarding Copywriter — Paso 1/3: intro de Fénix.
/// Lee perfil_negocio (ya escrito por Business Developer) — no vuelve a
/// preguntar nombre de empresa ni sector.
class OnboardingCopyPaso1Screen extends StatelessWidget {
  const OnboardingCopyPaso1Screen({super.key});

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
              const OnboardingHeader(titulo: 'Copywriter', paso: 1, total: 3),
              const SizedBox(height: 20),
              const OnboardingPrompt(
                mascota: FenixMascot(size: 44),
                mensaje: '¡Me presento!; mi nombre es Fénix y voy a ser tu copywriter a partir de ahora; yo me encargaré de redactar los textos de tu empresa',
              ),
              const Spacer(),
              const Center(child: FenixMascot(size: 120)),
              const Spacer(),
              GestureDetector(
                onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const OnboardingCopyPaso2Screen())),
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
