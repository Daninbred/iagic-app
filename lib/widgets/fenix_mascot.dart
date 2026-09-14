import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// Mascota de Copywriter — asset real (assets/images/fenix_mascot.svg),
/// sustituye al FenixMascotPlaceholder.
class FenixMascot extends StatelessWidget {
  const FenixMascot({super.key, this.size = 64});
  final double size;

  @override
  Widget build(BuildContext context) {
    // El SVG original mide 68x87 — mantenemos esa proporción al escalar.
    return SvgPicture.asset(
      'assets/images/fenix_mascot.svg',
      width: size,
      height: size * (87 / 68),
    );
  }
}
