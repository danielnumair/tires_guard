import 'package:flutter/material.dart';
import '../core/theme/app_colors.dart';
import '../widgets/custom_text_field.dart';
import '../models/chassi.dart';
import 'mapa_pneus_screen.dart';

class CadastroChassiScreen extends StatefulWidget {
  final Chassi? chassi;

  const CadastroChassiScreen({super.key, this.chassi});

  @override
  State<CadastroChassiScreen> createState() => _CadastroChassiScreenState();
}

class _CadastroChassiScreenState extends State<CadastroChassiScreen> {
  final _formKey = GlobalKey<FormState>();
  final _numeroChassiController = TextEditingController();
  final _observacoesController = TextEditingController();
  final _placaCaminhaoController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.chassi != null) {
      _numeroChassiController.text = widget.chassi!.numero;
      _observacoesController.text = widget.chassi!.observacoes;
      _placaCaminhaoController.text = widget.chassi!.caminhao;
    }
  }

  @override
  void dispose() {
    _numeroChassiController.dispose();
    _observacoesController.dispose();
    _placaCaminhaoController.dispose();
    super.dispose();
  }

  void _abrirMapaPneus() {
    if (_formKey.currentState!.validate()) {
      final chassi = widget.chassi != null
          ? Chassi(
        codigo: widget.chassi!.codigo,
        numero: _numeroChassiController.text,
        observacoes: _observacoesController.text,
        caminhao: _placaCaminhaoController.text,
        eixos: widget.chassi!.eixos,
        steps: widget.chassi!.steps,
        pneusPorEixo: widget.chassi!.pneusPorEixo,
      )
          : Chassi(
        codigo: '',
        numero: _numeroChassiController.text,
        observacoes: _observacoesController.text,
        caminhao: _placaCaminhaoController.text,
        eixos: 3,
        steps: 2,
        pneusPorEixo: List.generate(3, (_) => 4),
      );

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MapaPneusScreen(chassi: chassi),
        ),
      );
    }
  }

  void _salvarChassi() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Chassi salvo com sucesso!'),
          backgroundColor: AppColors.button,
        ),
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                color: Colors.black,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset('assets/images/logo.png', height: 70),
                    Image.asset('assets/images/user.png', height: 60),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Cadastro de chassi',
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      Center(
                        child: Column(
                          children: [
                            SizedBox(
                              width: 300,
                              child: CustomTextField(
                                hintText: 'Número do chassi',
                                controller: _numeroChassiController,
                                icon: Icons.confirmation_number_outlined,
                                validator: (value) => value == null || value.isEmpty ? 'Campo obrigatório' : null,
                              ),
                            ),
                            const SizedBox(height: 12),
                            SizedBox(
                              width: 300,
                              child: TextFormField(
                                controller: _observacoesController,
                                maxLines: 3,
                                style: const TextStyle(
                                  fontFamily: 'Inter',
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.inputText,
                                ),
                                decoration: InputDecoration(
                                  prefixIcon: const Icon(Icons.description_outlined, color: AppColors.inputText),
                                  hintText: 'Observações',
                                  hintStyle: const TextStyle(
                                    fontFamily: 'Inter',
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.inputText,
                                  ),
                                  filled: true,
                                  fillColor: AppColors.inputBackground,
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: const BorderSide(color: Colors.black, width: 1),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: const BorderSide(color: Colors.black, width: 2),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 24),
                            const SizedBox(
                              width: 300,
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Vincular à um caminhão',
                                  style: TextStyle(
                                    fontFamily: 'Inter',
                                    fontSize: 14,
                                    color: AppColors.inputText,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 4),
                            SizedBox(
                              width: 300,
                              child: CustomTextField(
                                hintText: 'Pesquise pela placa',
                                controller: _placaCaminhaoController,
                                icon: Icons.local_shipping_outlined,
                              ),
                            ),
                            const SizedBox(height: 16),
                            SizedBox(
                              width: 300,
                              height: 48,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF8C3D2F),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                    side: const BorderSide(color: Colors.black, width: 1),
                                  ),
                                ),
                                onPressed: _abrirMapaPneus,
                                child: const Text(
                                  'Mapa de pneus',
                                  style: TextStyle(
                                    fontFamily: 'Inter',
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 50),
                            SizedBox(
                              width: 300,
                              height: 48,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.button,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                    side: const BorderSide(color: Colors.black, width: 1),
                                  ),
                                ),
                                onPressed: _salvarChassi,
                                child: const Text(
                                  'Salvar',
                                  style: TextStyle(
                                    fontFamily: 'Inter',
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 12),
                            SizedBox(
                              width: 300,
                              height: 48,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.black,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                    side: const BorderSide(color: Colors.black, width: 1),
                                  ),
                                ),
                                onPressed: () => Navigator.pop(context),
                                child: const Text(
                                  'Cancelar',
                                  style: TextStyle(
                                    fontFamily: 'Inter',
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 24),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
