import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/zael_mascot.dart';

/// Pantalla final del onboarding de Web Developer — y del onboarding
/// secuencial completo (BD → Copywriter → Web Developer). Usa Zael a
/// propósito, no es un error: es quien cierra todo el proceso.
class OnboardingWebFinalScreen extends StatelessWidget {
  const OnboardingWebFinalScreen({super.key, this.onIrAMiEmpresa});
  final VoidCallback? onIrAMiEmpresa;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          child: Column(
            children: [
              const Spacer(),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 8, offset: const Offset(0, 3))],
                ),
                child: Text(
                  '¡Enhorabuena!, ya tienes los básicos de tu empresa, ahora te llevaremos a tu página principal, en ella podrás ver todas tus piezas, y tendrás unas instrucciones detalladas de cómo integrarlas.',
                  textAlign: TextAlign.center,
                  style: AppTextStyles.cuerpo.copyWith(fontSize: 14),
                ),
              ),
              const SizedBox(height: 24),
              const ZaelMascot(size: 130),
              const Spacer(),
              GestureDetector(
                // Lleva a Home — pantalla pendiente de construir.
                onTap: onIrAMiEmpresa ?? () {},
                child: Container(
                  height: 52,
                  decoration: BoxDecoration(color: AppColors.gradientStart, borderRadius: BorderRadius.circular(26)),
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Ir a mi empresa', style: AppTextStyles.cuerpo.copyWith(fontSize: 14, color: Colors.white, fontWeight: FontWeight.w500)),
                      const SizedBox(width: 8),
                      const Icon(Icons.arrow_forward, size: 18, color: Colors.white),
                    ],
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
