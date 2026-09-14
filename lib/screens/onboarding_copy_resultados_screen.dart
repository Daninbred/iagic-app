import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/fenix_mascot.dart';

/// Resultados de Copywriter — análoga a la de Business Developer, pero
/// con Fénix y solo 2 secciones (Frase de Marca / Párrafo de marca).
/// AVISO: el contenido de ejemplo ("Geek Street"...) es un mock —
/// la generación real viene del agente Fénix vía n8n.
class OnboardingCopyResultadosScreen extends StatefulWidget {
  const OnboardingCopyResultadosScreen({super.key, required this.onContinuar});
  final VoidCallback onContinuar;

  @override
  State<OnboardingCopyResultadosScreen> createState() => _OnboardingCopyResultadosScreenState();
}

class _OnboardingCopyResultadosScreenState extends State<OnboardingCopyResultadosScreen> {
  // Ambas secciones abiertas por defecto, a diferencia de BD (donde solo
  // la primera lo estaba) — así se ve en tu Figma.
  final Set<int> _abiertas = {0, 1};

  final List<_Seccion> _secciones = const [
    _Seccion(titulo: 'Frase de Marca', contenido: 'Viste tu pasión, marca tu estilo'),
    _Seccion(
      titulo: 'Párrafo de marca:',
      contenido:
          'En Geek Street fusionamos la pasión por la cultura geek con el estilo urbano más actual. Nacimos de la idea de que ser friki no está reñido con vestir con personalidad y actitud. Nuestras prendas están diseñadas para quienes viven intensamente sus fandoms, desde el gaming hasta el anime, sin renunciar a la comodidad y las tendencias urbanas. Cada pieza cuenta una historia, cada diseño refleja...',
    ),
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
                  const FenixMascot(size: 44),
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
                    final abierta = _abiertas.contains(i);
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: () => setState(() => abierta ? _abiertas.remove(i) : _abiertas.add(i)),
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
