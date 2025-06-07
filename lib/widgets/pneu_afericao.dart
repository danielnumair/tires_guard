import 'package:flutter/material.dart';
import '../core/theme/app_colors.dart';
import '../widgets/custom_text_field.dart';

class PneuAfericao {
  static Future<void> mostrarFormulario({
    required BuildContext context,
    required String titulo,
    required VoidCallback onSalvar,
  }) async {
    final _formKey = GlobalKey<FormState>();
    final sulcoController = TextEditingController();
    final calibragemController = TextEditingController();
    final servicoController = TextEditingController();
    final statusController = TextEditingController();
    final posicaoAnteriorController = TextEditingController();

    await showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: const Color(0xFF1E1E1E),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              titulo,
              style: const TextStyle(
                fontFamily: 'Inter',
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            IconButton(
              icon: const Icon(Icons.close, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            )
          ],
        ),
        content: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomTextField(
                  hintText: 'Profundidade Sulco',
                  controller: sulcoController,
                  icon: Icons.format_line_spacing,
                  validator: (value) => value == null || value.isEmpty ? 'Campo obrigatório' : null,
                ),
                const SizedBox(height: 8),
                CustomTextField(
                  hintText: 'Calibragem',
                  controller: calibragemController,
                  icon: Icons.speed,
                  validator: (value) => value == null || value.isEmpty ? 'Campo obrigatório' : null,
                ),
                const SizedBox(height: 8),
                CustomTextField(
                  hintText: 'Serviço Realizado',
                  controller: servicoController,
                  icon: Icons.build_outlined,
                  validator: (value) => value == null || value.isEmpty ? 'Campo obrigatório' : null,
                ),
                const SizedBox(height: 8),
                CustomTextField(
                  hintText: 'Status',
                  controller: statusController,
                  icon: Icons.check_circle_outline,
                  validator: (value) => value == null || value.isEmpty ? 'Campo obrigatório' : null,
                ),
                const SizedBox(height: 8),
                CustomTextField(
                  hintText: 'Posição Anterior',
                  controller: posicaoAnteriorController,
                  icon: Icons.swap_horiz,
                  validator: (value) => value == null || value.isEmpty ? 'Campo obrigatório' : null,
                ),
              ],
            ),
          ),
        ),
        actions: [
          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.button,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                  side: const BorderSide(color: Colors.black),
                ),
              ),
              onPressed: () {
                if (_formKey.currentState?.validate() ?? false) {
                  onSalvar();
                  Navigator.pop(context);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Preencha todos os campos antes de salvar.'),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
              child: const Text(
                'Salvar',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
