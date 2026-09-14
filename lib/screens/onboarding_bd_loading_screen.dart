import 'dart:async';
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/zael_mascot.dart';

/// Loader entre el paso 3 (Sobre tu empresa) y los Resultados.
/// Anillo giratorio con el degradado primario + mascota con un pulso
/// suave + mensajes de estado que van cambiando — da sensación de
/// que el agente está trabajando de verdad, no un spinner genérico.
class OnboardingLoadingScreen extends StatefulWidget {
  const OnboardingLoadingScreen({super.key, required this.onFinalizado});
  final VoidCallback onFinalizado;

  @override
  State<OnboardingLoadingScreen> createState() => _OnboardingLoadingScreenState();
}

class _OnboardingLoadingScreenState extends State<OnboardingLoadingScreen> with SingleTickerProviderStateMixin {
  late final AnimationController _rotationController;
  late final AnimationController _pulseController;
  int _mensajeIndex = 0;
  Timer? _mensajeTimer;
  Timer? _finalTimer;

  final List<String> _mensajes = const [
    'Analizando tu negocio…',
    'Estudiando a tu competencia…',
    'Preparando tu estrategia…',
    'Casi listo…',
  ];

  @override
  void initState() {
    super.initState();
    _rotationController = AnimationController(vsync: this, duration: const Duration(seconds: 2))..repeat();
    _pulseController = AnimationController(vsync: this, duration: const Duration(milliseconds: 900))
      ..repeat(reverse: true);

    _mensajeTimer = Timer.periodic(const Duration(milliseconds: 1400), (_) {
      if (!mounted) return;
      setState(() => _mensajeIndex = (_mensajeIndex + 1) % _mensajes.length);
    });

    // AVISO: la duración total es simulada (5.6s). En real, esto debería
    // terminar cuando el agente Zael responda de verdad vía n8n, no con
    // un temporizador fijo — se conecta cuando cerremos ese flujo.
    _finalTimer = Timer(const Duration(milliseconds: 5600), widget.onFinalizado);
  }

  @override
  void dispose() {
    _rotationController.dispose();
    _pulseController.dispose();
    _mensajeTimer?.cancel();
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
            SizedBox(
              width: 140,
              height: 140,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  AnimatedBuilder(
                    animation: _rotationController,
                    builder: (context, child) {
                      return Transform.rotate(
                        angle: _rotationController.value * 6.2832,
                        child: child,
                      );
                    },
                    child: Container(
                      width: 140,
                      height: 140,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: SweepGradient(
                          colors: [
                            AppColors.gradientStart,
                            AppColors.gradientEnd,
                            Colors.transparent,
                            Colors.transparent,
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: 116,
                    height: 116,
                    decoration: const BoxDecoration(color: AppColors.background, shape: BoxShape.circle),
                  ),
                  AnimatedBuilder(
                    animation: _pulseController,
                    builder: (context, child) {
                      final scale = 1 + (_pulseController.value * 0.06);
                      return Transform.scale(scale: scale, child: child);
                    },
                    child: const ZaelMascot(size: 70),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: Text(
                _mensajes[_mensajeIndex],
                key: ValueKey(_mensajeIndex),
                style: AppTextStyles.cuerpo.copyWith(fontSize: 14, color: AppColors.textSecondary),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
