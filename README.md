# IAGIC — App

App de agentes IA (Zael, Fénix, Nyx) para ayudar a emprendedores a crear y mantener su negocio.

## Estado
Frontend en construcción directa en código Flutter (no FlutterFlow — se abandonó por fricción de herramienta, ver historial de decisiones en el hilo de Diseño UI/UX del proyecto).

## Pendientes de backend / n8n
Ver `PENDIENTES_BACKEND.md` en este repo, y el archivo de memoria del proyecto
`/areas/pendientes-backend.md` para la versión más actualizada.

## Cómo correr esto en local
1. Instalar Flutter SDK: https://docs.flutter.dev/get-started/install
2. `flutter pub get`
3. `flutter run` (con un simulador de iOS o emulador de Android abierto)

Falta inicializar Supabase en `lib/main.dart` con la URL y anon key reales
del proyecto antes de que el login/registro funcione de verdad.
