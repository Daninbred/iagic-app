import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../models/chat_message.dart';

/// Chat — UNA pantalla genérica para los 3 agentes, igual que
/// AgentDetailScreen. Fondo degradado (mismo estilo que Registro/Login,
/// confirmado en tu Figma real de esta pantalla).
class ChatScreen extends StatefulWidget {
  const ChatScreen({
    super.key,
    required this.mascota,
    required this.nombreAgente,
    required this.rol,
    required this.mensajesIniciales,
    required this.onEnviarMensaje,
  });

  final Widget mascota;
  final String nombreAgente;
  final String rol;
  final List<ChatMessage> mensajesIniciales;
  final void Function(String texto) onEnviarMensaje;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late final List<ChatMessage> _mensajes = List.of(widget.mensajesIniciales);
  final _controller = TextEditingController();

  void _enviar() {
    final texto = _controller.text.trim();
    if (texto.isEmpty) return;
    setState(() => _mensajes.add(UserMessage(texto)));
    widget.onEnviarMensaje(texto);
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: AppGradients.authBackground),
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.of(context).pop(),
                      child: const Icon(Icons.chevron_left, size: 22, color: AppColors.textPrimary),
                    ),
                    const SizedBox(width: 6),
                    widget.mascota,
                    const SizedBox(width: 8),
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(text: widget.nombreAgente, style: AppTextStyles.cuerpo.copyWith(fontWeight: FontWeight.w700, fontSize: 14)),
                          TextSpan(text: '  |  ${widget.rol}', style: AppTextStyles.secundario.copyWith(fontSize: 13)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  itemCount: _mensajes.length,
                  itemBuilder: (context, i) {
                    final m = _mensajes[i];
                    if (m is UserMessage) return _UserBubble(texto: m.texto);
                    if (m is AgentMessage) return _AgentBubble(mensaje: m);
                    return const SizedBox.shrink();
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: AppColors.gradientStart, width: 1.2),
                          borderRadius: BorderRadius.circular(24),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: TextField(
                          controller: _controller,
                          onSubmitted: (_) => _enviar(),
                          style: AppTextStyles.cuerpo.copyWith(fontSize: 14),
                          decoration: InputDecoration(border: InputBorder.none, hintText: 'Escribe aquí...', hintStyle: AppTextStyles.secundario.copyWith(fontSize: 14)),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    GestureDetector(
                      onTap: _enviar,
                      child: Container(
                        width: 46,
                        height: 46,
                        decoration: BoxDecoration(gradient: AppGradients.primary, borderRadius: BorderRadius.circular(14)),
                        child: const Icon(Icons.send, size: 18, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _UserBubble extends StatelessWidget {
  const _UserBubble({required this.texto});
  final String texto;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.75),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(color: const Color(0xFFF3E8FE), borderRadius: BorderRadius.circular(14).copyWith(bottomRight: const Radius.circular(4))),
        child: Text(texto, style: AppTextStyles.cuerpo.copyWith(fontSize: 13)),
      ),
    );
  }
}

class _AgentBubble extends StatelessWidget {
  const _AgentBubble({required this.mensaje});
  final AgentMessage mensaje;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.82),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14).copyWith(bottomLeft: const Radius.circular(4)),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 8, offset: const Offset(0, 3))],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(mensaje.titulo, style: AppTextStyles.tituloMediano.copyWith(fontSize: 15)),
            const SizedBox(height: 4),
            Text(mensaje.resumen, style: AppTextStyles.secundario.copyWith(fontSize: 13, height: 1.4)),
            if (mensaje.bloques.isNotEmpty) ...[
              const SizedBox(height: 8),
              ...mensaje.bloques.map((b) => Padding(
                    padding: const EdgeInsets.only(bottom: 2),
                    child: Text('•  $b', style: AppTextStyles.cuerpo.copyWith(fontSize: 13)),
                  )),
            ],
            if (mensaje.ctaTexto != null) ...[
              const SizedBox(height: 10),
              GestureDetector(
                onTap: mensaje.onCtaTap,
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(color: Colors.white, border: Border.all(color: AppColors.gradientStart, width: 1.5), borderRadius: BorderRadius.circular(22)),
                  child: Text(mensaje.ctaTexto!, textAlign: TextAlign.center, style: AppTextStyles.cuerpo.copyWith(fontSize: 13, fontWeight: FontWeight.w500)),
                ),
              ),
            ],
            if (mensaje.preguntaSeguimiento != null) ...[
              const SizedBox(height: 8),
              Text(mensaje.preguntaSeguimiento!, style: TextStyle(fontSize: 12, color: AppColors.linkSoft)),
            ],
          ],
        ),
      ),
    );
  }
}
