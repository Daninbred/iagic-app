import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

/// Editar "Mi negocio" — a la que lleva la fila de Perfil.
/// Campos = exactamente los de perfil_negocio.
class EditarNegocioScreen extends StatefulWidget {
  const EditarNegocioScreen({
    super.key,
    this.nombreNegocio = '',
    this.sector = '',
    this.publicoObjetivo = '',
    this.tonoMarca = '',
    this.descripcionCorta = '',
  });
  final String nombreNegocio;
  final String sector;
  final String publicoObjetivo;
  final String tonoMarca;
  final String descripcionCorta;

  @override
  State<EditarNegocioScreen> createState() => _EditarNegocioScreenState();
}

class _EditarNegocioScreenState extends State<EditarNegocioScreen> {
  late final _nombreCtrl = TextEditingController(text: widget.nombreNegocio);
  late final _sectorCtrl = TextEditingController(text: widget.sector);
  late final _publicoCtrl = TextEditingController(text: widget.publicoObjetivo);
  late final _tonoCtrl = TextEditingController(text: widget.tonoMarca);
  late final _descripcionCtrl = TextEditingController(text: widget.descripcionCorta);
  bool _guardando = false;
  bool _guardado = false;

  Future<void> _guardar() async {
    setState(() {
      _guardando = true;
      _guardado = false;
    });
    // AVISO: falta el update real a perfil_negocio en Supabase — se
    // conecta en el hilo de n8n/Backend.
    await Future.delayed(const Duration(milliseconds: 600));
    setState(() {
      _guardando = false;
      _guardado = true;
    });
  }

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
                  GestureDetector(onTap: () => Navigator.of(context).pop(), child: const Icon(Icons.arrow_back, size: 20, color: AppColors.textPrimary)),
                  const SizedBox(width: 10),
                  Text('Mi negocio', style: AppTextStyles.tituloMediano.copyWith(fontSize: 17)),
                ],
              ),
              const SizedBox(height: 20),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _label('Nombre del negocio'),
                      _campo(_nombreCtrl),
                      const SizedBox(height: 16),
                      _label('Sector'),
                      _campo(_sectorCtrl),
                      const SizedBox(height: 16),
                      _label('Público objetivo'),
                      _campo(_publicoCtrl),
                      const SizedBox(height: 16),
                      _label('Tono de marca'),
                      _campo(_tonoCtrl),
                      const SizedBox(height: 16),
                      _label('Descripción corta'),
                      _campo(_descripcionCtrl, multiline: true),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 12),
              if (_guardado) Padding(padding: const EdgeInsets.only(bottom: 8), child: Text('Guardado', style: AppTextStyles.caption.copyWith(color: AppColors.success))),
              GestureDetector(
                onTap: _guardando ? null : _guardar,
                child: Container(
                  height: 52,
                  decoration: BoxDecoration(gradient: AppGradients.primary, borderRadius: BorderRadius.circular(26)),
                  child: Container(
                    margin: const EdgeInsets.all(2),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(24)),
                    child: _guardando
                        ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2.4, color: AppColors.gradientStart))
                        : Text('Guardar cambios', style: AppTextStyles.cuerpo.copyWith(fontSize: 14, fontWeight: FontWeight.w500)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _label(String t) => Padding(padding: const EdgeInsets.only(bottom: 6), child: Text(t, style: AppTextStyles.cuerpo.copyWith(fontSize: 13, fontWeight: FontWeight.w600)));

  Widget _campo(TextEditingController controller, {bool multiline = false}) {
    return Container(
      decoration: BoxDecoration(color: Colors.white, border: Border.all(color: AppColors.border), borderRadius: BorderRadius.circular(14)),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: TextField(
        controller: controller,
        maxLines: multiline ? 4 : 1,
        style: AppTextStyles.cuerpo.copyWith(fontSize: 14),
        decoration: const InputDecoration(border: InputBorder.none),
      ),
    );
  }
}
