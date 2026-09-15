/// Modelos del chat — reflejan el formato de respuesta estructurada del
/// agente (titulo/resumen/bloques/cta/pregunta_seguimiento) que ya
/// documentamos para n8n.
abstract class ChatMessage {}

class UserMessage extends ChatMessage {
  UserMessage(this.texto);
  final String texto;
}

class AgentMessage extends ChatMessage {
  AgentMessage({
    required this.titulo,
    required this.resumen,
    this.bloques = const [],
    this.ctaTexto,
    this.onCtaTap,
    this.preguntaSeguimiento,
  });

  final String titulo;
  final String resumen;
  final List<String> bloques;
  final String? ctaTexto;
  final void Function()? onCtaTap;
  final String? preguntaSeguimiento;
}
