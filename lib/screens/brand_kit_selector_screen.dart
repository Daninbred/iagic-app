import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class BrandKit {
  const BrandKit({
    required this.id,
    required this.nombre,
    required this.colores,
    required this.tipografiaTitulo,
    required this.tipografiaCuerpo,
  });
  final String id;
  final String nombre;
  final List<Color> colores;
  final String tipografiaTitulo;
  final String tipografiaCuerpo;
}

// Catálogo cerrado — coincide exactamente con el documento de Brand Kit
// del hilo de Agentes IA. No inventar valores nuevos aquí.
const _catalogo = [
  BrandKit(id: 'clasico_calido_01', nombre: 'Clásico y cálido', colores: [Color(0xFF7C2D12), Color(0xFFB45309), Color(0xFFFDF6EC)], tipografiaTitulo: 'Playfair Display', tipografiaCuerpo: 'Lato'),
  BrandKit(id: 'moderno_minimal_01', nombre: 'Moderno y minimal', colores: [Color(0xFF111827), Color(0xFF2563EB), Color(0xFFFFFFFF)], tipografiaTitulo: 'Space Grotesk', tipografiaCuerpo: 'Inter'),
  BrandKit(id: 'artesanal_natural_01', nombre: 'Artesanal y natural', colores: [Color(0xFF4A5D23), Color(0xFFA47148), Color(0xFFF5F1E8)], tipografiaTitulo: 'Fraunces', tipografiaCuerpo: 'Karla'),
  BrandKit(id: 'vibrante_juvenil_01', nombre: 'Vibrante y juvenil', colores: [Color(0xFFEF476F), Color(0xFFFFD166), Color(0xFF06D6A0)], tipografiaTitulo: 'Fredoka', tipografiaCuerpo: 'Poppins'),
];

/// Selector de Brand Kit — paso del onboarding de Web Developer que
/// faltaba construir. El agente sugiere 2-3 de las 4 opciones
/// (brand_kit_sugerido); aquí mostramos las 4 con las sugeridas
/// marcadas, y el usuario elige tocando una.
class BrandKitSelectorScreen extends StatefulWidget {
  const BrandKitSelectorScreen({super.key, required this.onContinuar, this.sugeridos = const ['moderno_minimal_01', 'vibrante_juvenil_01']});
  final void Function(String brandKitId) onContinuar;
  final List<String> sugeridos;

  @override
  State<BrandKitSelectorScreen> createState() => _BrandKitSelectorScreenState();
}

class _BrandKitSelectorScreenState extends State<BrandKitSelectorScreen> {
  String? _seleccionado;

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
              Text('Elige el estilo de tu web', style: AppTextStyles.tituloMediano.copyWith(fontSize: 17)),
              const SizedBox(height: 6),
              Text('Nyx sugiere estos según tu negocio, pero puedes elegir cualquiera.', style: AppTextStyles.secundario.copyWith(fontSize: 13)),
              const SizedBox(height: 16),
              Expanded(
                child: ListView.builder(
                  itemCount: _catalogo.length,
                  itemBuilder: (context, i) {
                    final kit = _catalogo[i];
                    final sugerido = widget.sugeridos.contains(kit.id);
                    final seleccionado = kit.id == _seleccionado;
                    return GestureDetector(
                      onTap: () => setState(() => _seleccionado = kit.id),
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(color: seleccionado ? AppColors.gradientStart : AppColors.border, width: seleccionado ? 1.5 : 1),
                          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 6, offset: const Offset(0, 2))],
                        ),
                        child: Row(
                          children: [
                            Icon(seleccionado ? Icons.radio_button_checked : Icons.radio_button_off, size: 20, color: seleccionado ? AppColors.gradientStart : AppColors.textSecondary),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(kit.nombre, style: AppTextStyles.cuerpo.copyWith(fontSize: 14, fontWeight: FontWeight.w600)),
                                      if (sugerido) ...[
                                        const SizedBox(width: 6),
                                        Container(
                                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                          decoration: BoxDecoration(color: const Color(0xFFF3E8FE), borderRadius: BorderRadius.circular(6)),
                                          child: Text('Sugerido', style: TextStyle(fontSize: 10, color: AppColors.gradientStart, fontWeight: FontWeight.w600)),
                                        ),
                                      ],
                                    ],
                                  ),
                                  const SizedBox(height: 2),
                                  Text('${kit.tipografiaTitulo} / ${kit.tipografiaCuerpo}', style: AppTextStyles.caption),
                                ],
                              ),
                            ),
                            Row(children: kit.colores.map((c) => Container(width: 16, height: 16, margin: const EdgeInsets.only(left: 3), decoration: BoxDecoration(color: c, shape: BoxShape.circle, border: Border.all(color: AppColors.border)))).toList()),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 8),
              Opacity(
                opacity: _seleccionado != null ? 1 : 0.4,
                child: GestureDetector(
                  onTap: _seleccionado != null ? () => widget.onContinuar(_seleccionado!) : null,
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
