import 'package:supabase_flutter/supabase_flutter.dart';

/// Envuelve todas las llamadas de autenticación a Supabase.
/// Las pantallas nunca llaman a Supabase directamente, siempre pasan
/// por aquí — si algún día cambia el backend de auth, se toca un
/// solo archivo.
///
/// AVISO IMPORTANTE: para que esto funcione de verdad hace falta:
/// 1. Inicializar Supabase en main.dart con la URL y anon key reales
///    del proyecto (pendiente — se cierra en el hilo de n8n/Backend).
/// 2. Para que "Registrarse con Google" abra el flujo NATIVO (sin pasar
///    por el navegador), hay que configurar en el proyecto:
///    - Android: SHA-1 del certificado + google-services.json
///    - iOS: URL scheme del cliente OAuth de Google
///    Esto es configuración de plataforma, no código Dart — lo dejamos
///    anotado como tarea pendiente para cuando conectemos el backend real.
///    Mientras tanto, el código de abajo funciona igual pero abre un
///    navegador/webview en vez del selector de cuenta nativo.
class AuthService {
  final _client = Supabase.instance.client;

  Future<void> signInWithGoogle() async {
    await _client.auth.signInWithOAuth(
      OAuthProvider.google,
      redirectTo: 'io.supabase.iagic://login-callback/',
    );
  }

  Future<AuthResponse> signUpWithEmail({
    required String email,
    required String password,
  }) {
    return _client.auth.signUp(email: email, password: password);
  }

  Future<AuthResponse> signInWithEmail({
    required String email,
    required String password,
  }) {
    return _client.auth.signInWithPassword(email: email, password: password);
  }

  Future<void> resendConfirmationEmail(String email) {
    return _client.auth.resend(type: OtpType.signup, email: email);
  }
}
