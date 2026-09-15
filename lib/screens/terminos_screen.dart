import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

/// Términos y Privacidad — contenido real tomado de tu Figma original
/// (no es texto de relleno). Pantalla estática, reutilizada desde
/// Registro y desde Perfil — no se duplica.
class TerminosScreen extends StatelessWidget {
  const TerminosScreen({super.key});

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
              GestureDetector(
                onTap: () => Navigator.of(context).pop(),
                child: Row(
                  children: [
                    const Icon(Icons.arrow_back, size: 18, color: AppColors.gradientStart),
                    const SizedBox(width: 6),
                    Text('Volver', style: AppTextStyles.secundario.copyWith(color: AppColors.gradientStart, fontWeight: FontWeight.w500)),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Términos de Servicio\ny Política de Privacidad', style: AppTextStyles.tituloGrande.copyWith(color: AppColors.gradientStart)),
                      const SizedBox(height: 20),

                      _h1('TÉRMINOS DE SERVICIO'),
                      _h2('1. Aceptación de los términos'),
                      _p('Al acceder o utilizar iagic ("el Servicio"), usted acepta estar sujeto a estos Términos de Servicio ("Términos"). Si no está de acuerdo, no utilice el Servicio.'),
                      _h2('2. Descripción del servicio'),
                      _p('iagic es una plataforma de agentes de inteligencia artificial para automatizar tareas comerciales y personales.'),
                      _h2('3. Registro y cuenta de usuario'),
                      _p('3.1 Elegibilidad: Debe ser mayor de 18 años para utilizar el servicio.\n3.2 Información de registro: Se compromete a proporcionar información precisa y actualizada durante el registro.\n3.3 Seguridad de la cuenta: Es responsable de mantener la confidencialidad de sus credenciales de acceso.'),
                      _h2('4. Uso aceptable'),
                      _p('4.1 Usos permitidos: Automatización de tareas comerciales legítimas, presentaciones y análisis de datos, asistencia en actividades profesionales y educativas.\n4.2 Usos prohibidos: Actividades ilegales o fraudulentas, violación de derechos de propiedad intelectual, generación de contenido dañino, difamatorio o discriminatorio, intentos de manipular o hackear el sistema, uso para crear contenido engañoso, violación de la privacidad de terceros.'),
                      _h2('5. Propiedad intelectual'),
                      _p('5.1 Derechos de iagic: Conservamos todos los derechos sobre el software, algoritmos y tecnologías.\n5.2 Contenido del usuario: Usted mantiene la propiedad de sus datos, pero nos otorga licencia para procesarlos según sea necesario para prestar el servicio.\n5.3 Contenido generado: El contenido generado por los agentes de IA está sujeto a limitaciones según las leyes aplicables.'),
                      _h2('6. Limitaciones del servicio'),
                      _p('6.1 Disponibilidad: No garantizamos acceso al servicio ininterrumpido.\n6.2 Precisión: Los resultados de la IA son probabilísticos y pueden contener errores o inexactitudes.\n6.3 Capacidad: Las funcionalidades pueden limitarse según su plan.'),
                      _h2('7. Facturación y pagos'),
                      _p('7.1 Planes de suscripción: los precios y planes están disponibles en nuestro sitio web.\n7.2 Pagos: Los pagos son procesados por terceros proveedores seguros.\n7.3 Reembolsos: Aplicamos una política de reembolso de [X días] bajo ciertas condiciones.'),
                      _h2('8. Terminación'),
                      _p('Podemos suspender o terminar su acceso al servicio en cualquier momento por razón justificada, con o sin previo aviso.'),
                      _h2('9. Exención de responsabilidad'),
                      _p('EL SERVICIO SE PROPORCIONA "TAL COMO ESTÁ". NO OFRECEMOS GARANTÍAS EXPRESAS NI IMPLÍCITAS SOBRE LA PRECISIÓN, FIABILIDAD O DISPONIBILIDAD DEL SERVICIO.'),
                      _h2('10. Limitación de responsabilidad'),
                      _p('En ningún caso seremos responsables por daños indirectos, incidentales, especiales o consecuentes que surjan del uso del servicio.'),
                      _h2('11. Ley aplicable'),
                      _p('Estos términos y cualquier disputa se resolverán de conformidad con las leyes de España y sujeta a la jurisdicción de sus tribunales.'),

                      const SizedBox(height: 24),
                      _h1('POLÍTICA DE PRIVACIDAD'),
                      _h2('1. Información que recopilamos'),
                      _p('1.1 Información proporcionada directamente: Datos de registro (nombre, email, información de contacto), datos de pago y facturación, consultas y contenido enviado a los agentes de IA, configuraciones y preferencias del usuario.\n1.2 Información recopilada automáticamente: Datos de uso y navegación, información técnica del dispositivo, dirección IP y datos de geolocalización, cookies y tecnologías similares.\n1.3 Información de terceros: Datos de integraciones autorizadas, información de proveedores de servicios.'),
                      _h2('2. Cómo utilizamos su información'),
                      _p('2.1 Prestación del servicio: Procesar consultas y generar respuestas de los agentes de IA, personalizar la experiencia del usuario, mejorar y optimizar nuestros algoritmos.\n2.2 Comunicación: Enviar notificaciones del servicio, proporcionar soporte al cliente, comunicar actualizaciones y nuevas funcionalidades.\n2.3 Mejora del servicio: Analizar patrones de uso, desarrollar nuevas características, entrenar y mejorar nuestros modelos de IA (agregado).'),
                      _h2('3. Compartir información'),
                      _p('3.1 No vendemos sus datos personales a terceros.\n3.2 Podemos compartir información con: Proveedores de servicios que nos asisten en operación, autoridades legales cuando sea requerido por ley, terceros en caso de fusión, adquisición legal o venta de activos.'),
                      _h2('4. Entrenamiento de modelos de IA'),
                      _p('4.1 Uso de datos: Sus interacciones pueden ser utilizadas para mejorar nuestros modelos de IA, de forma agregada y anonimizada.\n4.2 Opt-out: Puede solicitar que sus datos no sean usados para entrenamiento contactando a nuestro equipo de soporte.'),
                      _h2('5. Seguridad de datos'),
                      _p('Implementamos medidas técnicas y organizativas apropiadas para proteger su información personal contra acceso no autorizado, alteración, divulgación o destrucción.'),
                      _h2('6. Retención de datos'),
                      _p('Conservamos su información durante el tiempo necesario para cumplir con los propósitos descritos en esta política, a menos que la ley exija un período de retención mayor.'),
                      _h2('7. Sus derechos'),
                      _p('Dependiendo de su jurisdicción, puede tener derecho a: Acceder a su información personal, rectificar datos inexactos, eliminar su información personal, restringir el procesamiento, oponerse al procesamiento, portabilidad de datos.'),
                      _h2('8. Transferencias internacionales'),
                      _p('Sus datos pueden ser procesados en países fuera de su jurisdicción. Implementamos salvaguardas apropiadas para proteger su información en estas transferencias.'),
                      _h2('9. Cookies y tecnologías de seguimiento'),
                      _p('Utilizamos cookies y tecnologías similares para mejorar su experiencia. Puede configurar sus preferencias a través de la configuración de su navegador.'),
                      _h2('10. Menores de edad'),
                      _p('No recopilamos intencionalmente información de menores de 18 años. Si detectamos información de este tipo, la eliminaremos de inmediato.'),
                      _h2('11. Cambios en esta política'),
                      _p('Podemos actualizar esta política ocasionalmente. Le notificaremos sobre cambios materiales a través del servicio o por email.'),
                      _h2('12. Contacto'),
                      _p('Para preguntas sobre esta política de privacidad, contáctenos en: Email: info@iagic.es'),

                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _h1(String t) => Padding(
        padding: const EdgeInsets.only(top: 8, bottom: 10),
        child: Text(t, style: AppTextStyles.tituloMediano.copyWith(fontSize: 17, color: AppColors.gradientStart)),
      );

  Widget _h2(String t) => Padding(
        padding: const EdgeInsets.only(top: 12, bottom: 4),
        child: Text(t, style: AppTextStyles.cuerpo.copyWith(fontWeight: FontWeight.w600, fontSize: 13)),
      );

  Widget _p(String t) => Text(t, style: AppTextStyles.cuerpo.copyWith(fontSize: 12.5, height: 1.55, color: AppColors.textSecondary));
}
