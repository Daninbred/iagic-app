import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

/// Guía de ayuda contextual — contenido estático, no editable por el
/// usuario. Solo existe para Business Developer en MVP (decisión ya
/// fijada por scope).
class OnboardingAyudaScreen extends StatelessWidget {
  const OnboardingAyudaScreen({super.key});

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
                      Text('Cómo describir tu empresa\nde forma efectiva', style: AppTextStyles.tituloGrande),
                      const SizedBox(height: 20),
                      _h2('Por qué es importante ser conciso y claro'),
                      _p('Un asistente inteligente trabaja mejor cuando le das información esencial de manera organizada. Una buena descripción de tu empresa le permite entender rápidamente quién eres y qué haces, ayudándole a representarte fielmente.'),
                      _p('El arte de la descripción efectiva. La fórmula básica:'),
                      _formula('"[Nombre] somos [qué hacemos] para [cliente ideal]. Nos diferenciamos por [ventaja única] y valoramos [valores clave]."'),
                      const SizedBox(height: 16),
                      _h2('Elementos clave en orden de importancia'),
                      _h3('1. Identidad esencial'),
                      _bullets(['Nombre completo de la empresa', 'Sector o actividad específica (no genérica)', 'Problema principal que resuelves']),
                      _ejemplo(true, 'TechVerde Soluciones, desarrollamos sistemas de energía solar que reducen facturas energéticas'),
                      _ejemplo(false, 'Somos una empresa de tecnología que provee soluciones'),
                      _h3('2. Propuesta de valor condensada'),
                      _bullets(['Beneficio principal que ofreces', 'Método único de resolver su problema']),
                      _ejemplo(true, 'Ahorramos a familias hasta 40% en facturas mediante sistemas solares personalizados con monitoreo inteligente'),
                      _ejemplo(false, 'Ofrecemos muchos beneficios y soluciones personalizadas a nuestros clientes'),
                      _h3('3. Factor diferenciador'),
                      _bullets(['Una característica distintiva (no varias)', 'Tu ventaja sobre competidores']),
                      _ejemplo(true, 'A diferencia de otros instaladores, nuestro equipo incluye 5 ingenieros certificados y garantizamos rendimiento por 10 años'),
                      _ejemplo(false, 'Somos mejores que la competencia en muchos aspectos'),
                      _h3('4. Público objetivo específico'),
                      _bullets(['Perfil demográfico o empresarial concreto', 'Necesidad o deseo específico que tienen']),
                      _ejemplo(true, 'Servimos a propietarios de viviendas unifamiliares preocupados por su huella ecológica y costos energéticos crecientes'),
                      _ejemplo(false, 'Nuestros clientes son todo tipo de personas y empresas'),
                      _h3('5. Personalidad y valores'),
                      _bullets(['Tono de comunicación (2-3 adjetivos)', 'Valores principales (máximo 3)']),
                      _ejemplo(true, 'Comunicamos de forma cercana y técnicamente precisa, priorizando transparencia, innovación y compromiso ambiental'),
                      _ejemplo(false, 'Somos profesionales que valoramos muchas cosas importantes'),
                      const SizedBox(height: 16),
                      _h2('Ejemplos de descripciones completas efectivas'),
                      _h3('Empresa de tecnología'),
                      _p('"En TechVerde desarrollamos sistemas de energía solar que reducen facturas energéticas hasta un 40%. Nuestro software de monitoreo en tiempo real nos distingue, permitiendo optimizar consumo diariamente. Servimos a propietarios de viviendas unifamiliares preocupados por costos y sostenibilidad. Comunicamos de forma clara y honesta, priorizando transparencia e innovación."'),
                      _h3('Restaurante'),
                      _p('"La Huerta Orgánica ofrece gastronomía vegetariana con ingredientes 100% locales y orgánicos. Nos diferenciamos por nuestro menú de temporada que cambia semanalmente según cosechas propias. Atendemos a profesionales urbanos conscientes de su salud y el medioambiente. Nuestro trato es cercano y educativo, con valores de sostenibilidad y bienestar comunitario."'),
                      _h3('Consultoría'),
                      _p('"DataStrategy ayudamos a pequeñas empresas a tomar decisiones basadas en datos sin necesidad de departamentos técnicos. Nuestro método exclusivo traduce análisis complejos a recomendaciones accionables en 24 horas. Trabajamos con comercios minoristas que necesitan competir con grandes cadenas. Comunicamos sin jerga técnica, valorando practicidad y resultados medibles."'),
                      const SizedBox(height: 16),
                      _h2('Consejos para maximizar el impacto'),
                      _numbered([
                        'Prioriza información — Lo más importante primero',
                        'Usa lenguaje concreto — Números y hechos específicos en lugar de generalidades',
                        'Elimina adjetivos innecesarios — Cada palabra debe aportar valor',
                        'Evita jerga técnica — A menos que sea esencial para tu identidad',
                        'Incluye un ejemplo real — Un caso de cliente o situación típica',
                      ]),
                      const SizedBox(height: 16),
                      _h2('Plantilla definitiva'),
                      _formula('[Nombre] somos [actividad específica] que [beneficio principal] mediante [método/producto único]. Nos distinguimos de [diferenciador clave] frente a [competencia/alternativas]. Servimos a [cliente ideal] que buscan [necesidad específica]. Nuestra comunicación es [tono] y [tono], centrados en [valor 1], [valor 2] y [valor 3].'),
                      const SizedBox(height: 16),
                      _h2('Recuerda:'),
                      _p('La mejor descripción es la que transmite lo esencial de tu empresa con precisión, sin información superflua. Concéntrate en lo que realmente importa a tus clientes y lo que te hace único en el mercado.'),
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

  Widget _h2(String t) => Padding(
        padding: const EdgeInsets.only(top: 8, bottom: 8),
        child: Text(t, style: AppTextStyles.tituloMediano.copyWith(color: AppColors.gradientStart)),
      );

  Widget _h3(String t) => Padding(
        padding: const EdgeInsets.only(top: 12, bottom: 6),
        child: Text(t, style: AppTextStyles.cuerpo.copyWith(fontWeight: FontWeight.w600)),
      );

  Widget _p(String t) => Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Text(t, style: AppTextStyles.cuerpo.copyWith(fontSize: 13, height: 1.5)),
      );

  Widget _formula(String t) => Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(color: const Color(0xFFF3E8FE), borderRadius: BorderRadius.circular(10)),
        child: Text(t, style: AppTextStyles.cuerpo.copyWith(fontSize: 13, fontStyle: FontStyle.italic, color: AppColors.gradientStart)),
      );

  Widget _bullets(List<String> items) => Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: items
              .map((t) => Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: Text('•  $t', style: AppTextStyles.cuerpo.copyWith(fontSize: 13)),
                  ))
              .toList(),
        ),
      );

  Widget _numbered(List<String> items) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: items
            .asMap()
            .entries
            .map((e) => Padding(
                  padding: const EdgeInsets.only(bottom: 6),
                  child: Text('${e.key + 1}. ${e.value}', style: AppTextStyles.cuerpo.copyWith(fontSize: 13)),
                ))
            .toList(),
      );

  Widget _ejemplo(bool bueno, String texto) => Padding(
        padding: const EdgeInsets.only(bottom: 6),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(bueno ? Icons.check_circle : Icons.cancel, size: 15, color: bueno ? AppColors.success : AppColors.error),
            const SizedBox(width: 6),
            Expanded(child: Text('"$texto"', style: AppTextStyles.cuerpo.copyWith(fontSize: 12, fontStyle: FontStyle.italic))),
          ],
        ),
      );
}
