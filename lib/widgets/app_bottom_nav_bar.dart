import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

enum AppTab { agentes, notificaciones, perfil }

/// Tab bar inferior — se repite en Home, Notificaciones y Perfil.
class AppBottomNavBar extends StatelessWidget {
  const AppBottomNavBar({super.key, required this.current, required this.onTap, this.tieneNotificacionesSinLeer = false});
  final AppTab current;
  final ValueChanged<AppTab> onTap;
  final bool tieneNotificacionesSinLeer;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: const BoxDecoration(border: Border(top: BorderSide(color: AppColors.border, width: 0.5))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _item(Icons.storefront_outlined, AppTab.agentes),
          _item(Icons.notifications_outlined, AppTab.notificaciones, badge: tieneNotificacionesSinLeer),
          _item(Icons.person_outline, AppTab.perfil),
        ],
      ),
    );
  }

  Widget _item(IconData icon, AppTab tab, {bool badge = false}) {
    final active = tab == current;
    return GestureDetector(
      onTap: () => onTap(tab),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: 40,
            height: 36,
            decoration: BoxDecoration(
              color: active ? const Color(0xFFF3E8FE) : Colors.transparent,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, size: 22, color: active ? AppColors.gradientStart : AppColors.textSecondary),
          ),
          if (badge)
            Positioned(
              top: 4,
              right: 6,
              child: Container(width: 7, height: 7, decoration: const BoxDecoration(color: AppColors.progressGradientEnd, shape: BoxShape.circle)),
            ),
        ],
      ),
    );
  }
}
