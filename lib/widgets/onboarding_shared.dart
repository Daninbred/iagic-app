import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'zael_mascot.dart';

/// Barra de progreso del onboarding — degradado morado→coral (token
/// "progreso/estado", distinto del degradado de los botones).
class OnboardingProgressBar extends StatelessWidget {
  const OnboardingProgressBar({super.key, required this.paso, required this.total});
  final int paso;
  final int total;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final progreso = paso / total;
        return Stack(
          children: [
            Container(
              height: 4,
              width: constraints.maxWidth,
              decoration: BoxDecoration(
                color: AppColors.progressTrack,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              height: 4,
              width: constraints.maxWidth * progreso,
              decoration: BoxDecoration(
                gradient: AppGradients.progress,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ],
        );
      },
    );
  }
}

/// Fila mascota + burbuja de diálogo — patrón repetido en el onboarding
/// de cualquier agente. Recibe la mascota desde fuera para ser reutilizable
/// (Zael, Fénix, Nyx...).
class OnboardingPrompt extends StatelessWidget {
  const OnboardingPrompt({super.key, required this.mensaje, required this.mascota});
  final String mensaje;
  final Widget mascota;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        mascota,
        const SizedBox(width: 10),
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
              boxShadow: [
                BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 8, offset: const Offset(0, 3)),
              ],
            ),
            child: Text(mensaje, style: AppTextStyles.cuerpo.copyWith(fontSize: 14)),
          ),
        ),
      ],
    );
  }
}

/// Etiqueta "Sobre tu empresa - Paso 3 de 8" que corona cada pantalla.
class OnboardingHeader extends StatelessWidget {
  const OnboardingHeader({super.key, required this.titulo, required this.paso, required this.total});
  final String titulo;
  final int paso;
  final int total;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        OnboardingProgressBar(paso: paso, total: total),
        const SizedBox(height: 10),
        Text(
          '$titulo - Paso $paso de $total',
          style: AppTextStyles.secundario.copyWith(color: const Color(0xFF4A3AAE), fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}
