import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

/// Guía de ayuda de Web Developer — explica los 3 sliders del paso 2
/// y cómo conectar un dominio propio una vez la web está publicada.
class OnboardingWebAyudaScreen extends StatelessWidget {
  const OnboardingWebAyudaScreen({super.key});

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
                      Text('Guía clara para\nconfigurar tu web', style: AppTextStyles.tituloGrande.copyWith(color: AppColors.gradientStart)),
                      const SizedBox(height: 16),
                      _p('Antes de que el agente empiece a diseñar tu web, vas a elegir su "personalidad" y enfoque. Para hacerlo, solo tienes que mover tres sliders. Cada uno define cómo será el estilo de tu web y cómo se comunica con tus visitantes.'),
                      _p('Aquí te explico cada uno para que sepas qué estás configurando:'),
                      const SizedBox(height: 16),

                      _sliderBlock(
                        emoji: '🎯',
                        numero: 1,
                        titulo: 'De "Vender" a "Crear marca"',
                        intro: 'Este slider define el objetivo principal de tu web.',
                        izqEmoji: '🔻', izqTitulo: 'Más cerca de "Vender"',
                        izqTexto: 'La web irá al grano. Llamadas a la acción claras, botones visibles, foco en convencer y cerrar ventas.',
                        derEmoji: '🔺', derTitulo: 'Más cerca de "Crear marca"',
                        derTexto: 'La web contará mejor tu historia. Enfatiza los valores, el universo de la marca, y crea conexión emocional.',
                      ),
                      const SizedBox(height: 20),
                      _sliderBlock(
                        emoji: '👁️',
                        numero: 2,
                        titulo: 'De "Más visual" a "Más explicativo"',
                        intro: 'Este slider ajusta el equilibrio entre imágenes y texto.',
                        izqEmoji: '🔻', izqTitulo: 'Más visual',
                        izqTexto: 'Diseños más impactantes, poco texto, foco en lo estético. Ideal para productos visuales, portafolios o experiencias.',
                        derEmoji: '🔺', derTitulo: 'Más explicativo',
                        derTexto: 'El diseño da espacio al contenido. Más texto, descripciones claras, storytelling, beneficios explicados paso a paso.',
                      ),
                      const SizedBox(height: 20),
                      _sliderBlock(
                        emoji: '💬',
                        numero: 3,
                        titulo: 'De "Formal" a "Cercano"',
                        intro: 'Este slider define el tono de voz y cómo se expresa tu marca en la web.',
                        izqEmoji: '🔻', izqTitulo: 'Formal',
                        izqTexto: 'Lenguaje profesional, serio, orientado a empresas, instituciones o entornos corporativos.',
                        derEmoji: '🔺', derTitulo: 'Cercano',
                        derTexto: 'Lenguaje informal, tú a tú, más relajado. Perfecto para startups, creadores, marcas jóvenes o personales.',
                      ),

                      const SizedBox(height: 20),
                      Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(color: const Color(0xFFF3E8FE), borderRadius: BorderRadius.circular(12)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('🎁 Ejemplo real con sliders configurados:', style: AppTextStyles.cuerpo.copyWith(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.gradientStart)),
                            const SizedBox(height: 8),
                            Text('•  Crear marca (75%)\n•  Más visual (45%)\n•  Cercano (85%)', style: AppTextStyles.cuerpo.copyWith(fontSize: 13, height: 1.6)),
                            const SizedBox(height: 8),
                            Text(
                              '👉 El agente creará una web con personalidad propia, muy centrada en transmitir valores y estilo, con un diseño muy visual pero que también explica lo necesario, y que habla con un tono humano, informal y directo.',
                              style: AppTextStyles.cuerpo.copyWith(fontSize: 13, height: 1.5, fontStyle: FontStyle.italic),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 28),
                      Text('¿Y una vez la web está lista?', style: AppTextStyles.tituloMediano.copyWith(color: AppColors.gradientStart)),
                      const SizedBox(height: 10),
                      _p('Tu web se publica sola en cuanto Nyx termina — no tienes que subir nada a ningún servidor a mano. Lo único opcional es esto:'),
                      const SizedBox(height: 12),
                      Text('Conectar tu propio dominio (opcional)', style: AppTextStyles.cuerpo.copyWith(fontWeight: FontWeight.w600, fontSize: 13)),
                      const SizedBox(height: 4),
                      _p('Por defecto tu web vive en una dirección gratuita tipo "tuempresa.netlify.app". Si prefieres algo como "tuempresa.com", sigue esto:'),
                      const SizedBox(height: 10),
                      _numbered([
                        'Compra un dominio en cualquier proveedor (Namecheap, GoDaddy, o el que prefieras) — normalmente cuesta entre 10 y 15€ al año.',
                        'Dentro de la app, en la pantalla de tu web publicada, toca "Conectar dominio propio".',
                        'Te van a aparecer unos códigos técnicos (se llaman registros DNS). No hace falta entenderlos, solo copiarlos.',
                        'Entra en el panel de tu proveedor de dominio, busca la sección "DNS" o "Gestión de dominio", y pega ahí esos códigos donde te lo pida.',
                        'Espera unas horas (a veces hasta 24h) — es el tiempo que tarda internet en "aprenderse" el cambio, no puedes acelerarlo.',
                        'Cuando esté listo, tu web se verá en tu dominio propio automáticamente, con conexión segura (https) incluida sin coste extra.',
                      ]),
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

  Widget _p(String t) => Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Text(t, style: AppTextStyles.cuerpo.copyWith(fontSize: 13, height: 1.5)),
      );

  Widget _numbered(List<String> items) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: items
            .asMap()
            .entries
            .map((e) => Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text('${e.key + 1}. ${e.value}', style: AppTextStyles.cuerpo.copyWith(fontSize: 13, height: 1.5)),
                ))
            .toList(),
      );

  Widget _sliderBlock({
    required String emoji,
    required int numero,
    required String titulo,
    required String intro,
    required String izqEmoji,
    required String izqTitulo,
    required String izqTexto,
    required String derEmoji,
    required String derTitulo,
    required String derTexto,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('$emoji $numero. $titulo', style: AppTextStyles.tituloMediano.copyWith(fontSize: 15)),
        const SizedBox(height: 6),
        Text(intro, style: AppTextStyles.cuerpo.copyWith(fontSize: 13, height: 1.5)),
        const SizedBox(height: 10),
        _lado(izqEmoji, izqTitulo, izqTexto),
        const SizedBox(height: 8),
        _lado(derEmoji, derTitulo, derTexto),
      ],
    );
  }

  Widget _lado(String emoji, String titulo, String texto) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('$emoji  ', style: const TextStyle(fontSize: 13)),
        Expanded(
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(text: '$titulo  →  ', style: AppTextStyles.cuerpo.copyWith(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
                TextSpan(text: texto, style: AppTextStyles.cuerpo.copyWith(fontSize: 13, height: 1.5)),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
