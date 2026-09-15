import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

/// Web publicada — pieza que faltaba entre el loader y la pantalla
/// final de Zael. Muestra el link real de Netlify con "Ver mi web" y
/// "Copiar link". Se inserta ANTES del "Enhorabuena" de Zael, no lo
/// sustituye — una muestra el resultado concreto, la otra cierra
/// emocionalmente el onboarding completo.
class WebPublicadaScreen extends StatelessWidget {
  const WebPublicadaScreen({super.key, required this.url, required this.onContinuar});
  final String url;
  final VoidCallback onContinuar;

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
                width: 72,
                height: 72,
                decoration: const BoxDecoration(shape: BoxShape.circle, gradient: AppGradients.primary),
                child: const Icon(Icons.public, color: Colors.white, size: 32),
              ),
              const SizedBox(height: 20),
              Text('¡Tu web ya está publicada!', style: AppTextStyles.tituloMediano.copyWith(fontSize: 17), textAlign: TextAlign.center),
              const SizedBox(height: 20),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 8, offset: const Offset(0, 3))]),
                child: Text(url, textAlign: TextAlign.center, style: AppTextStyles.cuerpo.copyWith(fontSize: 13, color: AppColors.gradientEnd)),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {},
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(color: Colors.white, border: Border.all(color: AppColors.border), borderRadius: BorderRadius.circular(22)),
                        child: Text('Copiar link', textAlign: TextAlign.center, style: AppTextStyles.cuerpo.copyWith(fontSize: 13)),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {},
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(gradient: AppGradients.primary, borderRadius: BorderRadius.circular(22)),
                        child: Text('Ver mi web', textAlign: TextAlign.center, style: AppTextStyles.cuerpo.copyWith(fontSize: 13, color: Colors.white, fontWeight: FontWeight.w500)),
                      ),
                    ),
                  ),
                ],
              ),
              const Spacer(),
              GestureDetector(
                onTap: onContinuar,
                child: Container(
                  height: 52,
                  width: double.infinity,
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
