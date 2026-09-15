import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/zael_mascot.dart';
import '../widgets/fenix_mascot.dart';
import '../widgets/nyx_mascot.dart';
import '../widgets/app_bottom_nav_bar.dart';
import 'agent_detail_screen.dart';
import 'chat_screen.dart';
import '../models/chat_message.dart';
import 'notificaciones_screen.dart';
import 'perfil_screen.dart';

class _AgenteData {
  const _AgenteData({required this.mascota, required this.nombre, required this.ultimaAccion, required this.fecha, required this.abrirDetalle, this.sinLeer = false});
  final Widget mascota;
  final String nombre;
  final String ultimaAccion;
  final String fecha;
  final bool sinLeer;
  final void Function(BuildContext context) abrirDetalle;
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.nombreNegocio});
  final String nombreNegocio;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  AppTab _tab = AppTab.agentes;

  // AVISO: datos de ejemplo — en real vienen de `conversations` /
  // `interacciones` en Supabase (última acción, fecha, sinLeer, métricas).
  late final List<_AgenteData> _agentes = [
    _AgenteData(
      mascota: const ZaelMascot(size: 46),
      nombre: 'Zael',
      ultimaAccion: 'Generó informe semanal',
      fecha: 'Hace 2 horas',
      sinLeer: true,
      abrirDetalle: (context) => Navigator.of(context).push(MaterialPageRoute(
        builder: (_) => AgentDetailScreen(
          mascota: const ZaelMascot(size: 90),
          nombreAgente: 'Zael',
          rol: 'Estratega',
          metricas: const [
            MetricaData(label: 'Completitud', valor: 0.65),
            MetricaData(label: 'Profundidad', valor: 0.85),
            MetricaData(label: 'Captación', valor: 0.55),
            MetricaData(label: 'Resolución', valor: 0.75),
            MetricaData(label: 'Consistencia', valor: 0.35),
            MetricaData(label: 'Usabilidad', valor: 0.65),
          ],
          secciones: const [
            SeccionInforme(
              titulo: 'Despegue',
              contenido: 'Valida tu idea creando una landing page en redes sociales con diseños atractivos y un descuento para los primeros suscriptores. Esto te permitirá medir el interés real y construir una base de datos de clientes potenciales. ¡Empieza hoy mismo a crear esa página!',
            ),
            SeccionInforme(titulo: 'Análisis de mercado', contenido: 'Contenido pendiente de conectar con la respuesta real de Zael vía n8n.'),
            SeccionInforme(titulo: 'Buyer Persona', contenido: 'Contenido pendiente de conectar con la respuesta real de Zael vía n8n.'),
            SeccionInforme(titulo: 'Acción Inmediata', contenido: 'Contenido pendiente de conectar con la respuesta real de Zael vía n8n.'),
          ],
          onAbrirChat: () => Navigator.of(context).push(MaterialPageRoute(
            builder: (_) => ChatScreen(
              mascota: const ZaelMascot(size: 40),
              nombreAgente: 'Zael',
              rol: 'Estratega',
              mensajesIniciales: [
                AgentMessage(
                  titulo: 'Análisis de tu propuesta',
                  resumen: 'Tu diferenciador está claro, pero conviene afinar el público objetivo.',
                  bloques: const ['Define un rango de edad concreto', 'Añade una zona geográfica'],
                  ctaTexto: 'Afinar Público',
                  onCtaTap: () {}, // acción real (afinar_publico) pendiente de n8n
                  preguntaSeguimiento: '¿Quieres que lo hagamos ahora?',
                ),
              ],
              onEnviarMensaje: (texto) {}, // llamada real a motor-agente-chat pendiente de n8n
            ),
          )),
        ),
      )),
    ),
    _AgenteData(
      mascota: const FenixMascot(size: 46),
      nombre: 'Fénix',
      ultimaAccion: 'Tiene un nuevo titular',
      fecha: '22-07-25 09:20',
      // AVISO: métricas y secciones de ejemplo — no tengo captura de esta
      // pantalla para Fénix todavía, solo para Zael. Mismo patrón, datos
      // de relleno hasta que la envíes.
      abrirDetalle: (context) => Navigator.of(context).push(MaterialPageRoute(
        builder: (_) => AgentDetailScreen(
          mascota: const FenixMascot(size: 90),
          nombreAgente: 'Fénix',
          rol: 'Copywriter',
          metricas: const [
            MetricaData(label: 'Completitud', valor: 0.5),
            MetricaData(label: 'Profundidad', valor: 0.5),
            MetricaData(label: 'Captación', valor: 0.5),
            MetricaData(label: 'Resolución', valor: 0.5),
            MetricaData(label: 'Consistencia', valor: 0.5),
            MetricaData(label: 'Usabilidad', valor: 0.5),
          ],
          secciones: const [
            SeccionInforme(titulo: 'Frase de Marca', contenido: 'Viste tu pasión, marca tu estilo'),
            SeccionInforme(titulo: 'Párrafo de marca', contenido: 'Contenido pendiente de conectar con la respuesta real de Fénix vía n8n.'),
          ],
          onAbrirChat: () {},
        ),
      )),
    ),
    _AgenteData(
      mascota: const NyxMascot(size: 46),
      nombre: 'Nyx',
      ultimaAccion: 'Tiene lista una nueva versión',
      fecha: '22-07-25 07:20',
      // AVISO: igual que Fénix, datos de relleno hasta tener tu captura real.
      abrirDetalle: (context) => Navigator.of(context).push(MaterialPageRoute(
        builder: (_) => AgentDetailScreen(
          mascota: const NyxMascot(size: 90),
          nombreAgente: 'Nyx',
          rol: 'Webmaster',
          metricas: const [
            MetricaData(label: 'Completitud', valor: 0.5),
            MetricaData(label: 'Profundidad', valor: 0.5),
            MetricaData(label: 'Captación', valor: 0.5),
            MetricaData(label: 'Resolución', valor: 0.5),
            MetricaData(label: 'Consistencia', valor: 0.5),
            MetricaData(label: 'Usabilidad', valor: 0.5),
          ],
          secciones: const [
            SeccionInforme(titulo: 'Estructura de tu web', contenido: 'Contenido pendiente de conectar con la respuesta real de Nyx vía n8n.'),
          ],
          onAbrirChat: () {},
        ),
      )),
    ),
  ];

  bool get _hayNotificacionesSinLeer => _agentes.any((a) => a.sinLeer);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
              child: Row(
                children: [
                  const Icon(Icons.keyboard_arrow_down, size: 20, color: AppColors.textPrimary),
                  const SizedBox(width: 4),
                  GestureDetector(
                    // Lleva a "Mi negocio" en Perfil — destino asumido,
                    // pendiente de confirmar.
                    onTap: () {},
                    child: Text(
                      widget.nombreNegocio,
                      style: AppTextStyles.tituloMediano.copyWith(decoration: TextDecoration.underline, decorationColor: AppColors.gradientStart),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
                itemCount: _agentes.length,
                itemBuilder: (context, i) => GestureDetector(
                  onTap: () => _agentes[i].abrirDetalle(context),
                  child: _AgenteCard(data: _agentes[i]),
                ),
              ),
            ),
            AppBottomNavBar(
              current: _tab,
              tieneNotificacionesSinLeer: _hayNotificacionesSinLeer,
              onTap: (t) {
                if (t == AppTab.notificaciones) {
                  Navigator.of(context).push(MaterialPageRoute(builder: (_) => const NotificacionesScreen()));
                } else if (t == AppTab.perfil) {
                  Navigator.of(context).push(MaterialPageRoute(builder: (_) => PerfilScreen(nombreNegocio: widget.nombreNegocio, email: 'daniel@geekstreet.com')));
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _AgenteCard extends StatelessWidget {
  const _AgenteCard({required this.data});
  final _AgenteData data;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 8, offset: const Offset(0, 3))],
      ),
      child: Row(
        children: [
          data.mascota,
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(data.nombre, style: AppTextStyles.secundario.copyWith(fontSize: 13)),
                const SizedBox(height: 2),
                Text(data.ultimaAccion, style: AppTextStyles.tituloMediano.copyWith(fontSize: 15)),
                const SizedBox(height: 2),
                Text(data.fecha, style: AppTextStyles.caption),
              ],
            ),
          ),
          if (data.sinLeer)
            Container(width: 8, height: 8, decoration: const BoxDecoration(color: AppColors.gradientStart, shape: BoxShape.circle))
          else
            const Icon(Icons.chevron_right, size: 18, color: AppColors.textSecondary),
        ],
      ),
    );
  }
}
