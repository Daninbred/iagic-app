import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/fenix_mascot.dart';
import '../widgets/onboarding_shared.dart';
import 'onboarding_copy_paso3_screen.dart';
import 'onboarding_copy_ayuda_screen.dart';

/// Onboarding Copywriter — Paso 2/3: tono de comunicación.
/// Los 3 valores forman el objeto tono_marca de perfil_negocio.
class OnboardingCopyPaso2Screen extends StatefulWidget {
  const OnboardingCopyPaso2Screen({super.key});

  @override
  State<OnboardingCopyPaso2Screen> createState() => _OnboardingCopyPaso2ScreenState();
}

class _OnboardingCopyPaso2ScreenState extends State<OnboardingCopyPaso2Screen> {
  // 0.0 = extremo izquierdo, 1.0 = extremo derecho. Arrancan centrados.
  double _pausadoPromocional = 0.5;
  double _serioAlegre = 0.5;
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
              const OnboardingHeader(titulo: 'Copywriter', paso: 2, total: 3),
              const SizedBox(height: 20),
              const OnboardingPrompt(
                mascota: FenixMascot(size: 44),
                mensaje: 'Indícame cómo quieres que sea el tono de tu comunicación',
              ),
              const SizedBox(height: 24),
              _ToneSlider(
                value: _pausadoPromocional,
                onChanged: (v) => setState(() => _pausadoPromocional = v),
                izquierda: 'Pausado',
                derecha: 'Promocional',
              ),
              const SizedBox(height: 20),
              _ToneSlider(
                value: _serioAlegre,
                onChanged: (v) => setState(() => _serioAlegre = v),
                izquierda: 'Serio',
                derecha: 'Alegre',
              ),
              const SizedBox(height: 20),
              _ToneSlider(
                value: _formalCercano,
                onChanged: (v) => setState(() => _formalCercano = v),
                izquierda: 'Formal',
                derecha: 'Cercano',
              ),
              const Spacer(),
              GestureDetector(
                onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const OnboardingCopyAyudaScreen())),
                child: Text.rich(
                  TextSpan(
                    text: '¿Tienes dudas? ',
                    style: AppTextStyles.caption,
                    children: [
                      TextSpan(text: 'Aquí tienes nuestra guía para configurar tus copys', style: TextStyle(color: AppColors.linkSoft, decoration: TextDecoration.underline, fontSize: 12)),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              GestureDetector(
                onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => OnboardingCopyPaso3Screen(
                  tono: ToneValues(pausadoPromocional: _pausadoPromocional, serioAlegre: _serioAlegre, formalCercano: _formalCercano),
                ))),
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

/// Valores de tono recogidos en este paso — viajan al paso 3 y de ahí
/// a donde se escriba perfil_negocio.tono_marca (pendiente en n8n).
class ToneValues {
  const ToneValues({required this.pausadoPromocional, required this.serioAlegre, required this.formalCercano});
  final double pausadoPromocional;
  final double serioAlegre;
  final double formalCercano;
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
