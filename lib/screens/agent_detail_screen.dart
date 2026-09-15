import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/metric_bar.dart';

class MetricaData {
  const MetricaData({required this.label, required this.valor});
  final String label;
  final double valor;
}

class SeccionInforme {
  const SeccionInforme({required this.titulo, required this.contenido});
  final String titulo;
  final String contenido;
}

/// Detalle de Agente — UNA sola pantalla genérica para los 3 agentes.
/// Se instancia distinta por cada uno pasando su mascota, nombre, rol,
/// métricas e informe — no se duplica el archivo.
class AgentDetailScreen extends StatefulWidget {
  const AgentDetailScreen({
    super.key,
    required this.mascota,
    required this.nombreAgente,
    required this.rol,
    required this.metricas,
    required this.secciones,
    required this.onAbrirChat,
    this.seccionAbiertaPorDefecto = 0,
  });

  final Widget mascota;
  final String nombreAgente;
  final String rol;
  final List<MetricaData> metricas;
  final List<SeccionInforme> secciones;
  final VoidCallback onAbrirChat;
  final int seccionAbiertaPorDefecto;

  @override
  State<AgentDetailScreen> createState() => _AgentDetailScreenState();
}

class _AgentDetailScreenState extends State<AgentDetailScreen> {
  late int? _abierta = widget.seccionAbiertaPorDefecto;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: Row(
                      children: [
                        const Icon(Icons.chevron_left, size: 18, color: AppColors.gradientStart),
                        Text('volver', style: AppTextStyles.secundario.copyWith(color: AppColors.gradientStart, decoration: TextDecoration.underline)),
                      ],
                    ),
                  ),
                  const Spacer(),
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(text: widget.nombreAgente, style: AppTextStyles.cuerpo.copyWith(fontWeight: FontWeight.w700, fontSize: 14)),
                        TextSpan(text: '  |  ${widget.rol}', style: AppTextStyles.secundario.copyWith(fontSize: 13)),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  GestureDetector(
                    onTap: () {},
                    child: const Icon(Icons.help_outline, size: 20, color: AppColors.gradientStart),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Center(child: widget.mascota),
              const SizedBox(height: 20),
              ...widget.metricas.map((m) => MetricBar(label: m.label, valor: m.valor)),
              const SizedBox(height: 8),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: widget.secciones.asMap().entries.map((entry) {
                      final i = entry.key;
                      final seccion = entry.value;
                      final abierta = _abierta == i;
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Divider(height: 1, color: AppColors.border),
                          InkWell(
                            onTap: () => setState(() => _abierta = abierta ? null : i),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              child: Row(
                                children: [
                                  AnimatedRotation(
                                    turns: abierta ? 0.5 : 0,
                                    duration: const Duration(milliseconds: 200),
                                    child: const Icon(Icons.keyboard_arrow_down, size: 18, color: AppColors.gradientStart),
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
                    }).toList(),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              GestureDetector(
                onTap: widget.onAbrirChat,
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
                        Text('Abrir chat', style: AppTextStyles.cuerpo.copyWith(fontSize: 14, fontWeight: FontWeight.w500)),
                        const SizedBox(width: 8),
                        const Icon(Icons.send, size: 16, color: AppColors.textPrimary),
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
