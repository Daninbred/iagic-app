import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/zael_mascot.dart';

/// Resultados — última pantalla del onboarding de Business Developer.
/// Usa Zael (mascota nueva), no la ilustración antigua del Figma original.
/// Tras "Continuar" se pasa al onboarding de Copywriter (Fénix).
class OnboardingResultadosScreen extends StatefulWidget {
  const OnboardingResultadosScreen({super.key, required this.onContinuar});
  final VoidCallback onContinuar;

  @override
  State<OnboardingResultadosScreen> createState() => _OnboardingResultadosScreenState();
}

class _OnboardingResultadosScreenState extends State<OnboardingResultadosScreen> {
  // "Despegue" abierto por defecto, como en tu Figma — el resto colapsado.
  int? _abierto = 0;

  final List<_Seccion> _secciones = const [
    _Seccion(
      titulo: 'Despegue',
      contenido:
          'Valida tu idea creando una landing page en redes sociales con diseños atractivos y un descuento para los primeros suscriptores. Esto te permitirá medir el interés real y construir una base de datos de clientes potenciales. ¡Empieza hoy mismo a crear esa página!',
    ),
    _Seccion(titulo: 'Análisis de mercado', contenido: 'Contenido pendiente de conectar con la respuesta real de Zael vía n8n.'),
    _Seccion(titulo: 'Buyer Persona', contenido: 'Contenido pendiente de conectar con la respuesta real de Zael vía n8n.'),
    _Seccion(titulo: 'Acción Inmediata', contenido: 'Contenido pendiente de conectar con la respuesta real de Zael vía n8n.'),
  ];

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
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const ZaelMascot(size: 44),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(14),
                        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 8, offset: const Offset(0, 3))],
                      ),
                      child: Text(
                        '¡Aquí tienes tus resultados!, ten en cuenta que luego podrás modificarlos y afinar más si te interesa.',
                        style: AppTextStyles.cuerpo.copyWith(fontSize: 14),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Expanded(
                child: ListView.separated(
                  itemCount: _secciones.length,
                  separatorBuilder: (_, __) => const Divider(height: 1, color: AppColors.border),
                  itemBuilder: (context, i) {
                    final seccion = _secciones[i];
                    final abierta = _abierto == i;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: () => setState(() => _abierto = abierta ? null : i),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            child: Row(
                              children: [
                                AnimatedRotation(
                                  turns: abierta ? 0.5 : 0,
                                  duration: const Duration(milliseconds: 200),
                                  child: const Icon(Icons.keyboard_arrow_up, size: 18, color: AppColors.gradientStart),
                                ),
                                const SizedBox(width: 8),
                                Text(seccion.titulo, style: AppTextStyles.tituloMediano.copyWith(fontSize: 15)),
                              ],
                            ),
                          ),
                        ),
                        AnimatedCrossFade(
                          duration: const Duration(milliseconds: 200),
                          crossFadeState: abierta ? CrossFadeState.showFirst : CrossFadeState.showSecond,
                          firstChild: Padding(
                            padding: const EdgeInsets.only(bottom: 14),
                            child: Text(seccion.contenido, style: AppTextStyles.cuerpo.copyWith(fontSize: 13, height: 1.5)),
                          ),
                          secondChild: const SizedBox.shrink(),
                        ),
                      ],
                    );
                  },
                ),
              ),
              const SizedBox(height: 12),
              GestureDetector(
                onTap: widget.onContinuar,
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

class _Seccion {
  const _Seccion({required this.titulo, required this.contenido});
  final String titulo;
  final String contenido;
}
