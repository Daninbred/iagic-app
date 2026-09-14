import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../services/auth_service.dart';
import 'alta_email_screen.dart';
import 'login_screen.dart';

/// Registro — primera pantalla real de la app (no existe un Splash
/// independiente en el Figma; el arranque es directamente aquí).
///
/// AVISO: la foto de la tarjeta central usa Image.network sobre Unsplash.
/// Si se quiere servir desde otro origen (asset propio, CDN), solo hay
/// que cambiar la propiedad imageUrl de cada _RegistroSlide.
class RegistroScreen extends StatefulWidget {
  const RegistroScreen({super.key});

  @override
  State<RegistroScreen> createState() => _RegistroScreenState();
}

class _RegistroSlide {
  const _RegistroSlide({
    required this.imageUrl,
    required this.credito,
    required this.texto,
    required this.acento,
  });
  final String imageUrl;
  final String credito;
  final String texto;
  // Paleta de acento de esta diapositiva — usada para mutar el color
  // de los rombos decorativos mientras se hace swipe hacia ella.
  final List<Color> acento;
}

const _slides = [
  _RegistroSlide(
    imageUrl: 'https://images.unsplash.com/photo-1592621385612-4d7129426394?w=440&h=440&fit=crop&q=80&fm=jpg',
    credito: 'Jonathan Borba — Unsplash',
    texto: 'Un equipo que nunca duerme, nunca cobra de más, nunca te deja tirado.',
    acento: [Color(0xFFD87064), Color(0xFFB77F8D), Color(0xFF799AD9)],
  ),
  _RegistroSlide(
    imageUrl: 'https://images.unsplash.com/photo-1659714962352-434900f95a91?w=440&h=440&fit=crop&q=80&fm=jpg',
    credito: 'Susie Burleson — Unsplash',
    texto: 'Estrategia, textos y web, listos el mismo día que tienes la idea.',
    acento: [Color(0xFF5DCAA5), Color(0xFF7FA8D0), Color(0xFF9B7FE0)],
  ),
  _RegistroSlide(
    imageUrl: 'https://images.unsplash.com/photo-1484863137850-59afcfe05386?w=440&h=440&fit=crop&q=80&fm=jpg',
    credito: 'Brooke Cagle — Unsplash',
    texto: 'Tu empresa nace hoy, no dentro de tres meses.',
    acento: [Color(0xFFE0937F), Color(0xFFC98BB0), Color(0xFF8B79D9)],
  ),
];

class _RegistroScreenState extends State<RegistroScreen> {
  final _pageController = PageController();
  final _authService = AuthService();
  int _currentPage = 0;
  bool _cargandoGoogle = false;

  Future<void> _registrarConGoogle() async {
    setState(() => _cargandoGoogle = true);
    try {
      await _authService.signInWithGoogle();
      // La navegación tras Google la dispara el listener de sesión de
      // Supabase (auth state changes) — se conecta en el hilo de n8n/Backend.
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('No se pudo iniciar sesión con Google')),
        );
      }
    } finally {
      if (mounted) setState(() => _cargandoGoogle = false);
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  double get _page {
    if (_pageController.hasClients && _pageController.page != null) {
      return _pageController.page!;
    }
    return _currentPage.toDouble();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: AppGradients.authBackground),
        child: Stack(
          children: [
            // Los 3 rombos escuchan el mismo controller que el carrusel:
            // cada uno se mueve a su propia velocidad (parallax en capas),
            // gira levemente, y su color muta entre la paleta de la
            // diapositiva actual y la siguiente según el swipe.
            AnimatedBuilder(
              animation: _pageController,
              builder: (context, _) {
                final page = _page.clamp(0.0, (_slides.length - 1).toDouble());
                final baseIndex = page.floor().clamp(0, _slides.length - 1);
                final nextIndex = (baseIndex + 1).clamp(0, _slides.length - 1);
                final frac = page - baseIndex;
                final colors = List.generate(3, (j) {
                  return Color.lerp(
                    _slides[baseIndex].acento[j],
                    _slides[nextIndex].acento[j],
                    frac,
                  )!;
                });

                return Stack(
                  children: [
                    Positioned(
                      top: 56,
                      right: 20,
                      child: Transform.translate(
                        offset: Offset(page * -18, 0),
                        child: SparkleDiamond(
                          width: 14,
                          height: 18,
                          opacity: 0.55,
                          colors: colors,
                          angle: page * 0.6,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 210,
                      right: 4,
                      child: Transform.translate(
                        offset: Offset(page * 12, 0),
                        child: SparkleDiamond(
                          width: 10,
                          height: 13,
                          opacity: 0.45,
                          colors: colors,
                          angle: page * -0.9,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 270,
                      left: 6,
                      child: Transform.translate(
                        offset: Offset(page * -9, 0),
                        child: SparkleDiamond(
                          width: 12,
                          height: 15,
                          opacity: 0.5,
                          colors: colors,
                          angle: page * 0.4,
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
                child: Column(
                  children: [
                    Text(
                      'IAGIC',
                      style: AppTextStyles.tituloMediano.copyWith(
                        fontWeight: FontWeight.w400,
                        letterSpacing: 2.5,
                        color: const Color(0xFF4A3AAE),
                      ),
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      height: 280,
                      child: PageView.builder(
                        controller: _pageController,
                        itemCount: _slides.length,
                        onPageChanged: (i) => setState(() => _currentPage = i),
                        itemBuilder: (context, i) {
                          final slide = _slides[i];
                          return AnimatedBuilder(
                            animation: _pageController,
                            builder: (context, child) {
                              final delta = (i - _page).clamp(-1.0, 1.0);
                              final absDelta = delta.abs();

                              return Column(
                                children: [
                                  Transform.translate(
                                    offset: Offset(delta * -34, 0),
                                    child: Transform.scale(
                                      scale: 1 - (0.12 * absDelta),
                                      child: Opacity(
                                        opacity: 1 - (0.35 * absDelta),
                                        child: Transform.rotate(
                                          angle: -0.05,
                                          child: Container(
                                            width: 220,
                                            height: 220,
                                            padding: const EdgeInsets.all(6),
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.circular(20),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.black.withOpacity(0.08),
                                                  blurRadius: 16,
                                                  offset: const Offset(0, 6),
                                                ),
                                              ],
                                            ),
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.circular(16),
                                              child: Image.network(
                                                slide.imageUrl,
                                                fit: BoxFit.cover,
                                                loadingBuilder: (context, child, progress) => progress == null
                                                    ? child
                                                    : Container(
                                                        color: const Color(0xFFEDE9FE),
                                                        child: const Center(
                                                            child: CircularProgressIndicator(strokeWidth: 2)),
                                                      ),
                                                errorBuilder: (context, error, stackTrace) => Container(
                                                  decoration: const BoxDecoration(
                                                    gradient: LinearGradient(
                                                        colors: [Color(0xFFD9C9F0), Color(0xFFB9D8E8)]),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  Transform.translate(
                                    offset: Offset(delta * 18, 0),
                                    child: Opacity(
                                      opacity: (1 - absDelta).clamp(0.0, 1.0),
                                      child: Text(
                                        slide.texto,
                                        textAlign: TextAlign.center,
                                        style: AppTextStyles.cuerpo.copyWith(fontSize: 14),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(_slides.length, (i) {
                        final active = i == _currentPage;
                        return AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          margin: const EdgeInsets.symmetric(horizontal: 3),
                          width: active ? 20 : 7,
                          height: 7,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            gradient: active ? AppGradients.primary : null,
                            color: active ? null : const Color(0xFFD1C7E0),
                          ),
                        );
                      }),
                    ),
                    const Spacer(),
                    _GradientBorderButton(
                      text: 'Registrase con Google',
                      loading: _cargandoGoogle,
                      onTap: _registrarConGoogle,
                    ),
                    const SizedBox(height: 10),
                    _PlainButton(
                      text: 'Registrase con Email',
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => const AltaEmailScreen()),
                      ),
                    ),
                    const SizedBox(height: 16),
                    GestureDetector(
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => LoginScreen(onLoginExitoso: () {
                          // Navegación tras login exitoso — se conecta al
                          // arbol de rutas real en el hilo de n8n/Backend.
                        })),
                      ),
                      child: const Text(
                        'Ya tengo cuenta',
                        style: TextStyle(
                          fontSize: 13,
                          color: AppColors.linkSoft,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Destello decorativo — rombo alargado con degradado de 3 paradas,
/// más las dos facetas superpuestas (una fría, una cálida, a 20% de
/// opacidad) que le dan el aspecto de "gema tallada" del SVG original.
/// Recibe `colors` y `angle` desde fuera para poder animarse en sincronía
/// con el swipe del carrusel.
class SparkleDiamond extends StatelessWidget {
  const SparkleDiamond({
    super.key,
    required this.width,
    required this.height,
    this.opacity = 0.5,
    this.colors = const [Color(0xFFD87064), Color(0xFFB77F8D), Color(0xFF799AD9)],
    this.angle = 0,
  });

  final double width;
  final double height;
  final double opacity;
  final List<Color> colors;
  final double angle;

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: opacity,
      child: CustomPaint(
        size: Size(width, height),
        painter: _DiamondPainter(colors: colors, angle: angle),
      ),
    );
  }
}

class _DiamondPainter extends CustomPainter {
  _DiamondPainter({required this.colors, required this.angle});
  final List<Color> colors;
  final double angle;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);

    canvas.save();
    canvas.translate(center.dx, center.dy);
    canvas.rotate(angle * 0.15); // giro sutil, nunca da vueltas completas
    canvas.translate(-center.dx, -center.dy);

    final top = Offset(size.width / 2, 0);
    final right = Offset(size.width, size.height / 2);
    final bottom = Offset(size.width / 2, size.height);
    final left = Offset(0, size.height / 2);

    // Base — el rombo completo con el degradado de 3 paradas
    final basePath = Path()
      ..moveTo(top.dx, top.dy)
      ..lineTo(right.dx, right.dy)
      ..lineTo(bottom.dx, bottom.dy)
      ..lineTo(left.dx, left.dy)
      ..close();
    final baseShader = LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: colors,
    ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));
    canvas.drawPath(basePath, Paint()..shader = baseShader);

    // Faceta superior derecha — tinte frío, simula la sombra de la gema
    final upperFacet = Path()
      ..moveTo(top.dx, top.dy)
      ..lineTo(center.dx, center.dy)
      ..lineTo(right.dx, right.dy)
      ..close();
    canvas.drawPath(upperFacet, Paint()..color = const Color(0xFF4B58AA).withOpacity(0.2));

    // Faceta inferior derecha — tinte cálido, simula el brillo de la gema
    final lowerFacet = Path()
      ..moveTo(center.dx, center.dy)
      ..lineTo(bottom.dx, bottom.dy)
      ..lineTo(right.dx, right.dy)
      ..close();
    canvas.drawPath(lowerFacet, Paint()..color = const Color(0xFFFDF1EB).withOpacity(0.2));

    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant _DiamondPainter oldDelegate) =>
      oldDelegate.colors != colors || oldDelegate.angle != angle;
}

class _GradientBorderButton extends StatelessWidget {
  const _GradientBorderButton({required this.text, required this.onTap, this.loading = false});
  final String text;
  final VoidCallback onTap;
  final bool loading;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: loading ? null : onTap,
      child: Container(
        width: double.infinity,
        height: 52,
        decoration: BoxDecoration(gradient: AppGradients.primary, borderRadius: BorderRadius.circular(26)),
        child: Container(
          margin: const EdgeInsets.all(2),
          alignment: Alignment.center,
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(24)),
          child: loading
              ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(strokeWidth: 2.4, color: AppColors.gradientStart),
                )
              : Text('$text  G', style: AppTextStyles.cuerpo.copyWith(fontSize: 14)),
        ),
      ),
    );
  }
}

class _PlainButton extends StatelessWidget {
  const _PlainButton({required this.text, required this.onTap});
  final String text;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 52,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: AppColors.border),
          borderRadius: BorderRadius.circular(26),
        ),
        child: Text(text, style: AppTextStyles.cuerpo.copyWith(fontSize: 14)),
      ),
    );
  }
}
