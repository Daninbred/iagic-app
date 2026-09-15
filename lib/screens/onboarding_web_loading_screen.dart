import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'onboarding_web_final_screen.dart';
import 'web_publicada_screen.dart';

/// Loader de Web Developer — patrón distinto a los otros dos agentes:
/// tiene botón "Continuar" propio, porque la generación de la web puede
/// tardar minutos de verdad y NO debe bloquear al usuario. El usuario
/// puede avanzar mientras la web se sigue generando en segundo plano.
class OnboardingWebLoadingScreen extends StatefulWidget {
  const OnboardingWebLoadingScreen({super.key});

  @override
  State<OnboardingWebLoadingScreen> createState() => _OnboardingWebLoadingScreenState();
}

class _OnboardingWebLoadingScreenState extends State<OnboardingWebLoadingScreen> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 1200))..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

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
              Text(
                'Estamos generando tu web, esto puede llevar unos minutos, mientras tanto puedes continuar…',
                textAlign: TextAlign.center,
                style: AppTextStyles.cuerpo.copyWith(fontSize: 14, color: AppColors.textSecondary),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: 40,
                height: 40,
                child: AnimatedBuilder(
                  animation: _controller,
                  builder: (context, _) => CustomPaint(painter: _DotsSpinnerPainter(_controller.value)),
                ),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (_) => WebPublicadaScreen(
                    // AVISO: URL de ejemplo — la real depende de que n8n
                    // guarde landing_url tras publicar en Netlify (pendiente).
                    url: 'https://tuempresa.netlify.app',
                    onContinuar: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const OnboardingWebFinalScreen())),
                  ),
                )),
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
      final dotCenter = Offset(center.dx + radius * math.cos(angle), center.dy + radius * math.sin(angle));
      final distance = ((i / dotCount) - progress) % 1.0;
      final opacity = (0.15 + 0.85 * (1 - distance)).clamp(0.15, 1.0);
      canvas.drawCircle(dotCenter, 3, Paint()..color = AppColors.gradientStart.withOpacity(opacity));
    }
  }

  @override
  bool shouldRepaint(covariant _DotsSpinnerPainter oldDelegate) => oldDelegate.progress != progress;
}
