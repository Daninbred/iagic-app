import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// Mascota de Web Developer — asset real (assets/images/nyx_mascot.svg),
/// sustituye a NyxMascotPlaceholder.
class NyxMascot extends StatelessWidget {
  const NyxMascot({super.key, this.size = 64});
  final double size;

  @override
  Widget build(BuildContext context) {
    // El SVG original mide 85x110 — mantenemos esa proporción al escalar.
    return SvgPicture.asset(
      'assets/images/nyx_mascot.svg',
      width: size,
      height: size * (110 / 85),
    );
  }
}
