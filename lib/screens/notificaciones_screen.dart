import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/zael_mascot.dart';
import '../widgets/fenix_mascot.dart';
import '../widgets/nyx_mascot.dart';
import '../widgets/app_bottom_nav_bar.dart';
import 'home_screen.dart';
import 'perfil_screen.dart';

/// Notificaciones — diseñada a partir de los componentes ya establecidos
/// (tarjeta con sombra, mascotas reales, tab bar), no hay Figma propio
/// todavía. Centro único para los 3 agentes (decisión ya fijada).
class NotificacionItem {
  const NotificacionItem({required this.mascota, required this.texto, required this.fecha, this.sinLeer = false});
  final Widget mascota;
  final String texto;
  final String fecha;
  final bool sinLeer;
}

class NotificacionesScreen extends StatefulWidget {
  const NotificacionesScreen({super.key});

  @override
  State<NotificacionesScreen> createState() => _NotificacionesScreenState();
}

class _NotificacionesScreenState extends State<NotificacionesScreen> {
  AppTab _tab = AppTab.notificaciones;

  // AVISO: datos de ejemplo — en real vienen de `interacciones` en Supabase.
  final List<NotificacionItem> _notificaciones = const [
    NotificacionItem(mascota: ZaelMascot(size: 38), texto: 'Zael generó tu informe semanal', fecha: 'Hace 2 horas', sinLeer: true),
    NotificacionItem(mascota: FenixMascot(size: 38), texto: 'Fénix tiene una pregunta para ti', fecha: 'Ayer, 09:20'),
    NotificacionItem(mascota: NyxMascot(size: 38), texto: 'Nyx tiene lista una nueva versión de tu web', fecha: '22 jul, 07:20'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 18, 20, 8),
              child: Align(alignment: Alignment.centerLeft, child: Text('Notificaciones', style: AppTextStyles.tituloMediano.copyWith(fontSize: 17))),
            ),
            Expanded(
              child: _notificaciones.isEmpty
                  ? Center(child: Text('Todavía no tienes novedades', style: AppTextStyles.secundario))
                  : ListView.builder(
                      padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
                      itemCount: _notificaciones.length,
                      itemBuilder: (context, i) {
                        final n = _notificaciones[i];
                        return Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(14),
                            boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 8, offset: const Offset(0, 3))],
                          ),
                          child: Row(
                            children: [
                              n.mascota,
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(n.texto, style: AppTextStyles.cuerpo.copyWith(fontSize: 13)),
                                    const SizedBox(height: 2),
                                    Text(n.fecha, style: AppTextStyles.caption),
                                  ],
                                ),
                              ),
                              if (n.sinLeer)
                                Container(width: 8, height: 8, decoration: const BoxDecoration(color: AppColors.progressGradientEnd, shape: BoxShape.circle)),
                            ],
                          ),
                        );
                      },
                    ),
            ),
            AppBottomNavBar(
              current: _tab,
              onTap: (t) {
                if (t == AppTab.agentes) {
                  Navigator.of(context).pop();
                } else if (t == AppTab.perfil) {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => const PerfilScreen(nombreNegocio: 'Luz de Cera', email: 'daniel@geekstreet.com')));
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
