import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'theme/app_theme.dart';
import 'screens/registro_screen.dart';

/// Punto de entrada de la app.
///
/// AVISO IMPORTANTE: la URL y la anon key de abajo son de ejemplo, NO son
/// las del proyecto real de Supabase (pendiente en el hilo de n8n/Backend).
/// Con estos valores la app arranca y se ven todas las pantallas, pero
/// cualquier acción que llame de verdad a Supabase (login, registro...)
/// va a fallar hasta que se sustituyan por las reales.
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://placeholder.supabase.co',
    anonKey: 'placeholder-anon-key',
  );

  runApp(const IagicApp());
}

class IagicApp extends StatelessWidget {
  const IagicApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'IAGIC',
      debugShowCheckedModeBanner: false,
      theme: buildAppTheme(),
      home: const RegistroScreen(),
    );
  }
}