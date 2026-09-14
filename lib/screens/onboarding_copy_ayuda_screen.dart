import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

/// Guía de ayuda de Copywriter — explica qué mide cada slider de tono.
/// AVISO: solo tengo el contenido completo del slider 1 (Pausado↔Promocional)
/// de tu captura — el ejemplo de "Promocional" se cortó, y los sliders 2
/// (Serio↔Alegre) y 3 (Formal↔Cercano) están pendientes de que me pases
/// su texto. No invento copy de marketing por mi cuenta — eso es contenido
/// real, no estructura de pantalla.
class OnboardingCopyAyudaScreen extends StatelessWidget {
  const OnboardingCopyAyudaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              GestureDetector(
                onTap: () => Navigator.of(context).pop(),
                child: Row(
                  children: [
                    const Icon(Icons.arrow_back, size: 18, color: AppColors.gradientStart),
                    const SizedBox(width: 6),
                    Text('Volver', style: AppTextStyles.secundario.copyWith(color: AppColors.gradientStart, fontWeight: FontWeight.w500)),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Ajusta el tono de\ntus textos', style: AppTextStyles.tituloGrande.copyWith(color: AppColors.gradientStart)),
                      const SizedBox(height: 16),
                      Text('Configura cómo quieres sonar', style: AppTextStyles.tituloMediano),
                      const SizedBox(height: 10),
                      _p('Este paso es clave para que el agente escriba como si fueras tú. Aquí vas a encontrar 3 deslizadores que te permiten afinar el estilo de los textos.'),
                      const SizedBox(height: 20),
                      _SliderExplainer(
                        numero: 1,
                        titulo: 'Pausado ⟷ Promocional',
                        queM: 'El ritmo y la intención comercial del texto.',
                        izqTitulo: 'Pausado (izquierda)',
                        izqTexto: 'El texto se toma su tiempo. Explica con calma, sin urgencias. Ideal para marcas que buscan educar, informar o generar confianza sin presión.',
                        izqEjemplo: '"Descubre cómo esta solución puede ayudarte paso a paso."',
                        derTitulo: 'Promocional (derecha)',
                        derTexto: 'Va al grano. Llamadas a la acción, mucho gancho. Ideal para lanzamientos o anuncios.',
                        derEjemplo: null,
                      ),
                      const SizedBox(height: 24),
                      _PendienteSlider(numero: 2, titulo: 'Serio ⟷ Alegre'),
                      const SizedBox(height: 24),
                      _PendienteSlider(numero: 3, titulo: 'Formal ⟷ Cercano'),
                      const SizedBox(height: 24),
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

  Widget _p(String t) => Text(t, style: AppTextStyles.cuerpo.copyWith(fontSize: 13, height: 1.5));
}

class _SliderExplainer extends StatelessWidget {
  const _SliderExplainer({
    required this.numero,
    required this.titulo,
    required this.queM,
    required this.izqTitulo,
    required this.izqTexto,
    required this.izqEjemplo,
    required this.derTitulo,
    required this.derTexto,
    required this.derEjemplo,
  });

  final int numero;
  final String titulo;
  final String queM;
  final String izqTitulo;
  final String izqTexto;
  final String? izqEjemplo;
  final String derTitulo;
  final String derTexto;
  final String? derEjemplo;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('$numero. $titulo', style: AppTextStyles.tituloMediano.copyWith(fontSize: 16)),
        const SizedBox(height: 10),
        Text('¿Qué mide este slider?', style: AppTextStyles.cuerpo.copyWith(fontWeight: FontWeight.w600, fontSize: 13)),
        const SizedBox(height: 6),
        Text(queM, style: AppTextStyles.cuerpo.copyWith(fontSize: 13, height: 1.5)),
        const SizedBox(height: 12),
        _lado(izqTitulo, izqTexto, izqEjemplo),
        const SizedBox(height: 12),
        _lado(derTitulo, derTexto, derEjemplo),
      ],
    );
  }

  Widget _lado(String titulo, String texto, String? ejemplo) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('•  $titulo', style: AppTextStyles.cuerpo.copyWith(fontSize: 13, fontWeight: FontWeight.w600)),
        Padding(
          padding: const EdgeInsets.only(left: 14, top: 2),
          child: Text(texto, style: AppTextStyles.cuerpo.copyWith(fontSize: 13, height: 1.5)),
        ),
        if (ejemplo != null)
          Padding(
            padding: const EdgeInsets.only(left: 14, top: 6),
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(color: const Color(0xFFF3E8FE), borderRadius: BorderRadius.circular(8)),
              child: Text('Ejemplo: $ejemplo', style: AppTextStyles.cuerpo.copyWith(fontSize: 12, fontStyle: FontStyle.italic, color: AppColors.gradientStart)),
            ),
          )
        else
          Padding(
            padding: const EdgeInsets.only(left: 14, top: 6),
            child: Text('Ejemplo pendiente de recibir', style: AppTextStyles.caption.copyWith(fontStyle: FontStyle.italic)),
          ),
      ],
    );
  }
}

class _PendienteSlider extends StatelessWidget {
  const _PendienteSlider({required this.numero, required this.titulo});
  final int numero;
  final String titulo;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(color: const Color(0xFFF9FAFB), borderRadius: BorderRadius.circular(10), border: Border.all(color: AppColors.border)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('$numero. $titulo', style: AppTextStyles.tituloMediano.copyWith(fontSize: 16, color: AppColors.textSecondary)),
          const SizedBox(height: 6),
          Text('Contenido pendiente de que me pases el texto de este slider.', style: AppTextStyles.caption.copyWith(fontStyle: FontStyle.italic)),
        ],
      ),
    );
  }
}
