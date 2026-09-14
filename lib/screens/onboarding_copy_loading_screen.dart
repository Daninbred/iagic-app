import 'dart:async';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'onboarding_copy_resultados_screen.dart';

/// Loader de Copywriter — más simple que el de Business Developer
/// (sin anillo ni mascota), tal como en tu Figma: solo texto + spinner
/// de puntos.
class OnboardingCopyLoadingScreen extends StatefulWidget {
  const OnboardingCopyLoadingScreen({super.key});

  @override
  State<OnboardingCopyLoadingScreen> createState() => _OnboardingCopyLoadingScreenState();
}

class _OnboardingCopyLoadingScreenState extends State<OnboardingCopyLoadingScreen> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  Timer? _finalTimer;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 1200))..repeat();
    // AVISO: duración simulada (3s) — en real, termina cuando Fénix
    // responda de verdad vía n8n, no con un temporizador fijo.
    _finalTimer = Timer(const Duration(seconds: 3), () {
      if (!mounted) return;
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) => OnboardingCopyResultadosScreen(
            onContinuar: () {
              // Avanza a Home (o al onboarding de Web Developer/Nyx) —
              // se conecta cuando construyamos esas pantallas.
            },
          ),
        ),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _finalTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Creando tus copys…', style: AppTextStyles.cuerpo.copyWith(fontSize: 14, color: AppColors.textSecondary)),
            const SizedBox(height: 20),
            SizedBox(
              width: 40,
              height: 40,
              child: AnimatedBuilder(
                animation: _controller,
                builder: (context, _) => CustomPaint(painter: _DotsSpinnerPainter(_controller.value)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DotsSpinnerPainter extends CustomPainter {
  _DotsSpinnerPainter(this.progress);
  final double progress;

  static const int dotCount = 8;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 4;
    for (int i = 0; i < dotCount; i++) {
      final angle = (i / dotCount) * 2 * math.pi;
      final dotCenter = Offset(
        center.dx + radius * math.cos(angle),
        center.dy + radius * math.sin(angle),
      );
      final distance = ((i / dotCount) - progress) % 1.0;
      final opacity = (0.15 + 0.85 * (1 - distance)).clamp(0.15, 1.0);
      canvas.drawCircle(dotCenter, 3, Paint()..color = AppColors.gradientStart.withOpacity(opacity));
    }
  }

  @override
  bool shouldRepaint(covariant _DotsSpinnerPainter oldDelegate) => oldDelegate.progress != progress;
}
