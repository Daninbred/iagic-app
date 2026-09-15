import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

/// Una fila de métrica de calidad (Completitud, Profundidad, etc.)
/// Usa el degradado de progreso (morado→coral), igual que la barra
/// de progreso del onboarding.
class MetricBar extends StatelessWidget {
  const MetricBar({super.key, required this.label, required this.valor});
  final String label;
  final double valor; // 0.0 a 1.0

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          SizedBox(width: 90, child: Text(label, style: AppTextStyles.cuerpo.copyWith(fontSize: 13))),
          const SizedBox(width: 10),
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return Stack(
                  children: [
                    Container(height: 6, decoration: BoxDecoration(color: AppColors.progressTrack, borderRadius: BorderRadius.circular(3))),
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 400),
                      height: 6,
                      width: constraints.maxWidth * valor.clamp(0.0, 1.0),
                      decoration: BoxDecoration(gradient: AppGradients.progress, borderRadius: BorderRadius.circular(3)),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
