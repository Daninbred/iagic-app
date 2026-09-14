import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/nyx_mascot.dart';
import '../widgets/onboarding_shared.dart';
import 'onboarding_web_loading_screen.dart';
import 'onboarding_web_ayuda_screen.dart';

/// Onboarding Web Developer — Paso 2: propósito de la página web.
/// Los 3 valores viajan al agente para orientar la generación real.
class OnboardingWebPaso2Screen extends StatefulWidget {
  const OnboardingWebPaso2Screen({super.key});

  @override
  State<OnboardingWebPaso2Screen> createState() => _OnboardingWebPaso2ScreenState();
}

class _OnboardingWebPaso2ScreenState extends State<OnboardingWebPaso2Screen> {
  double _venderCrearMarca = 0.5;
  double _visualExplicativo = 0.5;
  double _formalCercano = 0.5;

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
              const OnboardingHeader(titulo: 'Webmaster', paso: 2, total: 3),
              const SizedBox(height: 20),
              const OnboardingPrompt(
                mascota: NyxMascot(size: 44),
                mensaje: 'Indícame cuál es el propósito de tu página web',
              ),
              const SizedBox(height: 24),
              _ToneSlider(value: _venderCrearMarca, onChanged: (v) => setState(() => _venderCrearMarca = v), izquierda: 'Vender', derecha: 'Crear marca'),
              const SizedBox(height: 20),
              _ToneSlider(value: _visualExplicativo, onChanged: (v) => setState(() => _visualExplicativo = v), izquierda: 'Más visual', derecha: 'Más explicativo'),
              const SizedBox(height: 20),
              _ToneSlider(value: _formalCercano, onChanged: (v) => setState(() => _formalCercano = v), izquierda: 'Formal', derecha: 'Cercano'),
              const Spacer(),
              GestureDetector(
                onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const OnboardingWebAyudaScreen())),
                child: Text.rich(
                  TextSpan(
                    text: '¿Tienes dudas? ',
                    style: AppTextStyles.caption,
                    children: [
                      TextSpan(text: 'Aquí tienes nuestra guía para configurar tu web', style: TextStyle(color: AppColors.linkSoft, decoration: TextDecoration.underline, fontSize: 12)),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              GestureDetector(
                onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const OnboardingWebLoadingScreen())),
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

class _ToneSlider extends StatelessWidget {
  const _ToneSlider({required this.value, required this.onChanged, required this.izquierda, required this.derecha});
  final double value;
  final ValueChanged<double> onChanged;
  final String izquierda;
  final String derecha;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SliderTheme(
          data: SliderThemeData(
            trackHeight: 4,
            activeTrackColor: AppColors.gradientEnd,
            inactiveTrackColor: AppColors.progressTrack,
            thumbColor: AppColors.gradientStart,
            thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 9),
            overlayShape: const RoundSliderOverlayShape(overlayRadius: 16),
          ),
          child: Slider(value: value, onChanged: onChanged),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(izquierda, style: AppTextStyles.secundario.copyWith(fontSize: 13)),
              Text(derecha, style: AppTextStyles.secundario.copyWith(fontSize: 13)),
            ],
          ),
        ),
      ],
    );
  }
}
