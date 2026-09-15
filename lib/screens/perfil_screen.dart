import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/app_bottom_nav_bar.dart';
import '../services/auth_service.dart';
import 'notificaciones_screen.dart';
import 'editar_negocio_screen.dart';
import 'terminos_screen.dart';
import 'recuperar_password_screen.dart';

/// Perfil / Ajustes — diseñada a partir de los componentes ya
/// establecidos, no hay Figma propio todavía. Secciones: Mi negocio,
/// Cuenta, Legal, Borrar cuenta (con tratamiento visual de "peligro").
class PerfilScreen extends StatefulWidget {
  const PerfilScreen({super.key, required this.nombreNegocio, required this.email});
  final String nombreNegocio;
  final String email;

  @override
  State<PerfilScreen> createState() => _PerfilScreenState();
}

class _PerfilScreenState extends State<PerfilScreen> {
  AppTab _tab = AppTab.perfil;
  final _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 18, 20, 8),
              child: Row(
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: const BoxDecoration(color: Color(0xFFF3E8FE), shape: BoxShape.circle),
                    child: const Icon(Icons.person, size: 22, color: AppColors.gradientStart),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.nombreNegocio, style: AppTextStyles.tituloMediano.copyWith(fontSize: 15)),
                      Text(widget.email, style: AppTextStyles.secundario.copyWith(fontSize: 12)),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 16),
                children: [
                  _seccion('Mi negocio', [
                    _fila('Editar información del negocio', onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => EditarNegocioScreen(nombreNegocio: widget.nombreNegocio)))),
                  ]),
                  const SizedBox(height: 20),
                  _seccion('Cuenta', [
                    _fila('Cambiar contraseña', onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const RecuperarPasswordScreen()))),
                    _fila('Cerrar sesión', icono: Icons.logout, onTap: () async {
                      await _authService.signOut();
                    }),
                  ]),
                  const SizedBox(height: 20),
                  _seccion('Legal', [
                    _fila('Términos y política de privacidad', onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const TerminosScreen()))),
                  ]),
                  const SizedBox(height: 20),
                  Container(
                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14), border: Border.all(color: const Color(0xFFFADADD)), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 6, offset: const Offset(0, 2))]),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(14),
                      onTap: () => _confirmarBorrarCuenta(context),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                        child: Text('Borrar cuenta', style: TextStyle(fontSize: 13, color: Color(0xFFDC2626))),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            AppBottomNavBar(
              current: _tab,
              onTap: (t) {
                if (t == AppTab.agentes) {
                  Navigator.of(context).pop();
                } else if (t == AppTab.notificaciones) {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => const NotificacionesScreen()));
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  void _confirmarBorrarCuenta(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('¿Borrar tu cuenta?'),
        content: const Text('Esta acción no se puede deshacer. Se eliminarán todos tus datos.'),
        actions: [
          TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text('Cancelar')),
          TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text('Borrar', style: TextStyle(color: Color(0xFFDC2626)))),
        ],
      ),
    );
  }

  Widget _seccion(String titulo, List<Widget> filas) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 6),
          child: Text(titulo.toUpperCase(), style: AppTextStyles.caption.copyWith(fontWeight: FontWeight.w600, letterSpacing: 0.5)),
        ),
        Container(
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 6, offset: const Offset(0, 2))]),
          child: Column(children: filas),
        ),
      ],
    );
  }

  Widget _fila(String texto, {IconData? icono, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 16),
        child: Row(
          children: [
            Expanded(child: Text(texto, style: AppTextStyles.cuerpo.copyWith(fontSize: 13))),
            Icon(icono ?? Icons.chevron_right, size: 16, color: AppColors.textSecondary),
          ],
        ),
      ),
    );
  }
}
