import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// Mascota de Business Developer — se reutiliza en las 8 pantallas del
/// onboarding y en el hub "Detalle de Agente" del Home.
/// Asset real, no dibujado a mano: assets/images/zael_mascot.svg
class ZaelMascot extends StatelessWidget {
  const ZaelMascot({super.key, this.size = 64});
  final double size;

  @override
  Widget build(BuildContext context) {
    // El SVG original mide 66x93 (más alto que ancho) — mantenemos esa
    // proporción para que no se deforme al escalarlo.
    return SvgPicture.asset(
      'assets/images/zael_mascot.svg',
      width: size,
      height: size * (93 / 66),
    );
  }
}
