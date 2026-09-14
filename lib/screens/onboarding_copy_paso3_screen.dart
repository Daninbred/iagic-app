import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/fenix_mascot.dart';
import '../widgets/onboarding_shared.dart';
import 'onboarding_copy_paso2_screen.dart' show OnboardingCopyPaso2Screen, ToneValues;
import 'onboarding_copy_loading_screen.dart';
import 'onboarding_copy_ayuda_screen.dart';

/// Onboarding Copywriter — Paso 3/3: diferenciación frente a la competencia.
class OnboardingCopyPaso3Screen extends StatefulWidget {
  const OnboardingCopyPaso3Screen({super.key, required this.tono});
  final ToneValues tono;

  @override
  State<OnboardingCopyPaso3Screen> createState() => _OnboardingCopyPaso3ScreenState();
}

class _OnboardingCopyPaso3ScreenState extends State<OnboardingCopyPaso3Screen> {
  final _controller = TextEditingController();

  bool get _canContinue => _controller.text.isNotEmpty;

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
              const OnboardingHeader(titulo: 'Copywriter', paso: 3, total: 3),
              const SizedBox(height: 20),
              const OnboardingPrompt(
                mascota: FenixMascot(size: 44),
                mensaje: 'Ahora indícame brevemente que crees que te diferencia de tu competencia',
              ),
              const SizedBox(height: 16),
              Container(
                decoration: BoxDecoration(color: Colors.white, border: Border.all(color: AppColors.border), borderRadius: BorderRadius.circular(14)),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                child: TextField(
                  controller: _controller,
                  maxLines: 5,
                  onChanged: (_) => setState(() {}),
                  style: AppTextStyles.cuerpo.copyWith(fontSize: 14),
                  decoration: const InputDecoration(border: InputBorder.none, hintText: ''),
                ),
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
              Opacity(
                opacity: _canContinue ? 1 : 0.4,
                child: GestureDetector(
                  onTap: _canContinue
                      ? () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const OnboardingCopyLoadingScreen()))
                      : null,
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
