import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/onboarding_shared.dart';
import '../widgets/zael_mascot.dart';
import 'onboarding_bd_loading_screen.dart';
import 'onboarding_bd_resultados_screen.dart';
import 'onboarding_bd_ayuda_screen.dart';

/// Onboarding BD — Paso 3/8: Sobre tu empresa.
/// Tiene 3 sub-estados dentro del mismo paso (según tu Figma):
///  1) Elegir si ya tiene nombre (Sí / No, necesito uno)
///  2a) Si Sí → campo directo de nombre
///  2b) Si No → textarea de descripción → botón genera sugerencias
///  3) Lista de sugerencias para elegir una (solo si vino del camino "No")
///
/// AVISO: las sugerencias de nombre son un mock estático de momento.
/// La generación real vendrá del agente Zael vía n8n — se conecta cuando
/// cerremos ese prompt en el hilo de Agentes IA.
class OnboardingSobreEmpresaScreen extends StatefulWidget {
  const OnboardingSobreEmpresaScreen({super.key, required this.onContinuar});
  final void Function(String nombreEmpresa, String? descripcion) onContinuar;

  @override
  State<OnboardingSobreEmpresaScreen> createState() => _OnboardingSobreEmpresaScreenState();
}

class _OnboardingSobreEmpresaScreenState extends State<OnboardingSobreEmpresaScreen> {
  bool? _tieneNombre;
  final _nombreController = TextEditingController();
  final _descripcionController = TextEditingController();
  bool _mostrandoSugerencias = false;
  String? _sugerenciaElegida;

  // Mock — sustituir por la respuesta real del agente cuando se conecte n8n.
  final List<String> _sugerencias = const ['Geekstreet', 'Dragonstore', 'Freak paradise', 'Blackshirts', 'Geek house'];

  bool get _canContinue {
    if (_mostrandoSugerencias) return _sugerenciaElegida != null;
    if (_tieneNombre == true) return _nombreController.text.isNotEmpty;
    if (_tieneNombre == false) return _descripcionController.text.isNotEmpty;
    return false;
  }

  void _onBotonPrincipal() {
    String? nombreFinal;
    if (_mostrandoSugerencias) {
      nombreFinal = _sugerenciaElegida;
    } else if (_tieneNombre == true) {
      nombreFinal = _nombreController.text.trim();
    } else if (_tieneNombre == false) {
      // Aquí, en real, se llamaría al agente para generar sugerencias
      // a partir de _descripcionController.text — de momento mock.
      setState(() => _mostrandoSugerencias = true);
      return;
    }

    if (nombreFinal == null) return;
    widget.onContinuar(nombreFinal, _descripcionController.text.trim());

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => OnboardingLoadingScreen(
          onFinalizado: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (_) => OnboardingResultadosScreen(
                  onContinuar: () {
                    // Avanza al onboarding de Copywriter (Fénix) — se
                    // conecta cuando construyamos esas pantallas.
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  String get _textoBoton => (_tieneNombre == false && !_mostrandoSugerencias) ? 'Ver sugerencias' : 'Continuar';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const OnboardingHeader(titulo: 'Sobre tu empresa', paso: 3, total: 8),
              const SizedBox(height: 20),
              OnboardingPrompt(
                mascota: const ZaelMascot(size: 44),
                mensaje: _mostrandoSugerencias
                    ? 'Elige el nombre para tu empresa.'
                    : 'Háblanos ahora sobre tu futura empresa.',
              ),
              const SizedBox(height: 20),
              Expanded(
                child: SingleChildScrollView(
                  child: _mostrandoSugerencias ? _buildSugerencias() : _buildEleccion(),
                ),
              ),
              const SizedBox(height: 12),
              GestureDetector(
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const OnboardingAyudaScreen()),
                ),
                child: Text.rich(
                  TextSpan(
                    text: '¿Tienes dudas? ',
                    style: AppTextStyles.caption,
                    children: [
                      TextSpan(
                        text: 'Aquí tienes nuestra guía para describir tu empresa',
                        style: TextStyle(color: AppColors.linkSoft, decoration: TextDecoration.underline, fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              _ContinuarButton(text: _textoBoton, enabled: _canContinue, onTap: _onBotonPrincipal),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEleccion() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('¿Tienes nombre para la empresa?', style: AppTextStyles.tituloMediano.copyWith(fontSize: 15)),
        const SizedBox(height: 10),
        Row(
          children: [
            _RadioOption(
              label: 'Si',
              selected: _tieneNombre == true,
              onTap: () => setState(() => _tieneNombre = true),
            ),
            const SizedBox(width: 20),
            _RadioOption(
              label: 'No, necesito uno',
              selected: _tieneNombre == false,
              onTap: () => setState(() => _tieneNombre = false),
            ),
          ],
        ),
        const SizedBox(height: 16),
        if (_tieneNombre == true)
          _CajaTexto(controller: _nombreController, hint: 'Nombre de tu empresa', onChanged: (_) => setState(() {})),
        if (_tieneNombre == false)
          _CajaTexto(
            controller: _descripcionController,
            hint: 'Es un ecommerce de venta de ropa urbana, con temática friki, final fantasy; star wars, Zelda; entre otros.',
            multiline: true,
            onChanged: (_) => setState(() {}),
          ),
      ],
    );
  }

  Widget _buildSugerencias() {
    return Column(
      children: _sugerencias.map((nombre) {
        final selected = nombre == _sugerenciaElegida;
        return GestureDetector(
          onTap: () => setState(() => _sugerenciaElegida = nombre),
          child: Container(
            margin: const EdgeInsets.only(bottom: 10),
            padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
            decoration: BoxDecoration(
              color: selected ? AppColors.gradientStart : const Color(0xFFF3F0F8),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Row(
              children: [
                if (selected) const Icon(Icons.check, size: 16, color: Colors.white),
                if (selected) const SizedBox(width: 8),
                Text(
                  nombre,
                  style: AppTextStyles.cuerpo.copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: selected ? Colors.white : AppColors.textPrimary,
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}

class _RadioOption extends StatelessWidget {
  const _RadioOption({required this.label, required this.selected, required this.onTap});
  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 18,
            height: 18,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.gradientStart, width: 1.5),
            ),
            child: selected
                ? Center(
                    child: Container(
                      width: 9,
                      height: 9,
                      decoration: const BoxDecoration(shape: BoxShape.circle, color: AppColors.gradientStart),
                    ),
                  )
                : null,
          ),
          const SizedBox(width: 8),
          Text(label, style: AppTextStyles.cuerpo.copyWith(fontSize: 14)),
        ],
      ),
    );
  }
}

class _CajaTexto extends StatelessWidget {
  const _CajaTexto({required this.controller, required this.hint, required this.onChanged, this.multiline = false});
  final TextEditingController controller;
  final String hint;
  final ValueChanged<String> onChanged;
  final bool multiline;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: AppColors.border),
        borderRadius: BorderRadius.circular(14),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        maxLines: multiline ? 4 : 1,
        style: AppTextStyles.cuerpo.copyWith(fontSize: 14),
        decoration: InputDecoration(border: InputBorder.none, hintText: hint, hintStyle: AppTextStyles.secundario.copyWith(fontSize: 13)),
      ),
    );
  }
}

class _ContinuarButton extends StatelessWidget {
  const _ContinuarButton({required this.text, required this.onTap, this.enabled = true});
  final String text;
  final VoidCallback onTap;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: enabled ? 1 : 0.4,
      child: GestureDetector(
        onTap: enabled ? onTap : null,
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
                Text(text, style: AppTextStyles.cuerpo.copyWith(fontSize: 14, fontWeight: FontWeight.w500)),
                const SizedBox(width: 8),
                const Icon(Icons.arrow_forward, size: 18, color: AppColors.textPrimary),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
