# IAGIC — Pendientes de backend detectados al construir el front (para el hilo de n8n)

Todo lo de abajo salió como "AVISO" dentro de los comentarios del código Flutter mientras construíamos las pantallas de Auth y el onboarding de Business Developer. Ninguno bloquea seguir construyendo pantallas nuevas — pero sin esto, lo ya construido no funciona de verdad, solo visualmente.

## 1. Inicialización de Supabase
`main.dart` todavía no llama a `Supabase.initialize()`. Hace falta:
- URL del proyecto Supabase
- Anon key
Sin esto, ningún botón de auth funciona aunque el código ya esté escrito (`auth_service.dart`).

## 2. Google Sign-In nativo (no solo vía navegador)
El código ya llama a `signInWithOAuth(OAuthProvider.google)`, pero para que abra el selector de cuenta nativo del sistema (no un navegador/webview) hace falta configuración de plataforma:
- **Android:** SHA-1 del certificado de firma + `google-services.json`
- **iOS:** URL scheme del cliente OAuth de Google
Sin esto funciona igual, pero con peor experiencia (pasa por navegador).

## 3. Recuperar contraseña ("¿Olvidaste tu contraseña?")
En Login hay un link puesto pero sin acción todavía. Falta:
- Pantalla de "recuperar contraseña"
- Configurar en Supabase la plantilla de email de recuperación
- Llamar a `resetPasswordForEmail()` desde el cliente

## 4. Escritura real en `perfil_negocio`
Los pasos 2 y 3 del onboarding de BD ya **recogen** los datos (nombre, email, sobre ti, nombre de empresa) vía callbacks (`onContinuar(...)`), pero **todavía no escriben en Supabase** — falta conectar esos callbacks a un `PerfilNegocioService` (o similar) que haga el insert/update real en la tabla.

## 5. Generación real de sugerencias de nombre (paso 3 del onboarding BD)
Ahora mismo la lista de sugerencias es un **mock estático** (Geekstreet, Dragonstore, Freak paradise, Blackshirts, Geek house) dentro del propio código Dart. La generación real tiene que venir del agente **Zael** vía el workflow `motor-agente-chat` de n8n, pasando la descripción del negocio que el usuario escribió.

## 6. Confirmación de email — dependencia de configuración de Supabase
La lógica de "reenviar correo" (`resendConfirmationEmail`) ya está en el código, pero depende de que el proyecto de Supabase tenga bien configurado el envío de emails de confirmación (plantilla, remitente, etc.) — no es código Dart, es configuración del proyecto.

## 7. Pendientes ya documentados antes (recordatorio, no nuevos)
- Dónde persiste el toggle de reporte semanal (Detalle de Agente → Métricas)
- Dónde persiste `landing_url` de la web publicada por Web Developer
- Escala exacta de las 6 métricas de calidad (Completitud, Profundidad, etc.) y quién las calcula

---

**Nota de alcance:** este documento cubre solo lo que ha salido de construir Auth + onboarding BD (pasos 1-3). Seguirá creciendo a medida que construyamos más pantallas — trátalo como una lista viva, no cerrada.
