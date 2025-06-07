import 'package:flutter/material.dart';
import '../core/theme/app_colors.dart';
import '../widgets/custom_text_field.dart';
import '../models/atendimento.dart';
import 'cadastro_caminhao_screen.dart';

class CadastroAtendimentoScreen extends StatefulWidget {
  final Atendimento? atendimento;

  const CadastroAtendimentoScreen({super.key, this.atendimento});

  @override
  State<CadastroAtendimentoScreen> createState() => _CadastroAtendimentoScreenState();
}

class _CadastroAtendimentoScreenState extends State<CadastroAtendimentoScreen> {
  final _formKey = GlobalKey<FormState>();
  final _veiculoController = TextEditingController();
  final _chassiController = TextEditingController();
  final _observacoesController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.atendimento != null) {
      _veiculoController.text = widget.atendimento!.veiculo;
      _chassiController.text = widget.atendimento!.chassi;
      _observacoesController.text = widget.atendimento!.observacoes;
    }
  }

  @override
  void dispose() {
    _veiculoController.dispose();
    _chassiController.dispose();
    _observacoesController.dispose();
    super.dispose();
  }

  void _salvarAtendimento() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Atendimento salvo com sucesso!'),
          backgroundColor: AppColors.button,
        ),
      );
      Navigator.pop(context);
    }
  }

  void _abrirCadastroVeiculo() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const CadastroCaminhaoScreen()),
    );
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
                          'Cadastro de atendimento',
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
                              child: Stack(
                                alignment: Alignment.centerRight,
                                children: [
                                  CustomTextField(
                                    controller: _veiculoController,
                                    hintText: 'Veículo',
                                    icon: Icons.directions_car,
                                    validator: (value) => value == null || value.isEmpty ? 'Campo obrigatório' : null,
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.add, color: Colors.white),
                                    onPressed: _abrirCadastroVeiculo,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 16),
                            SizedBox(
                              width: 300,
                              child: CustomTextField(
                                controller: _chassiController,
                                hintText: 'Chassi',
                                icon: Icons.confirmation_number,
                                validator: (value) => value == null || value.isEmpty ? 'Campo obrigatório' : null,
                              ),
                            ),
                            const SizedBox(height: 16),
                            SizedBox(
                              width: 300,
                              child: TextFormField(
                                controller: _observacoesController,
                                maxLines: 3,
                                style: const TextStyle(color: Colors.white, fontFamily: 'Inter'),
                                decoration: const InputDecoration(
                                  hintText: 'Observações',
                                  hintStyle: TextStyle(color: AppColors.inputText),
                                  filled: true,
                                  fillColor: AppColors.inputBackground,
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(8)),
                                    borderSide: BorderSide(color: Colors.black),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(8)),
                                    borderSide: BorderSide(color: Colors.black, width: 2),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 80),
                            SizedBox(
                              width: 300,
                              height: 48,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.button,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                    side: const BorderSide(color: Colors.black),
                                  ),
                                ),
                                onPressed: _salvarAtendimento,
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
                                    side: const BorderSide(color: Colors.black),
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
                            const SizedBox(height: 40),
                          ],
                        ),
                      ),
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
}
