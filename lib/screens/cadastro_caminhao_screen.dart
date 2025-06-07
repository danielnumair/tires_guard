import 'package:flutter/material.dart';
import '../core/theme/app_colors.dart';
import '../widgets/custom_text_field.dart';
import '../models/caminhao.dart';
import '../screens/cadastro_chassi_screen.dart';

class CadastroCaminhaoScreen extends StatefulWidget {
  final Caminhao? caminhao;

  const CadastroCaminhaoScreen({super.key, this.caminhao});

  @override
  State<CadastroCaminhaoScreen> createState() => _CadastroCaminhaoScreenState();
}

class _CadastroCaminhaoScreenState extends State<CadastroCaminhaoScreen> {
  final _formKey = GlobalKey<FormState>();
  final _modeloController = TextEditingController();
  final _placaController = TextEditingController();
  final _corController = TextEditingController();
  final _anoController = TextEditingController();
  final _chassiController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.caminhao != null) {
      _modeloController.text = widget.caminhao!.modelo;
      _placaController.text = widget.caminhao!.placa;
      _corController.text = widget.caminhao!.cor;
      _anoController.text = widget.caminhao!.ano;
      _chassiController.text = widget.caminhao!.chassi;
    }
  }

  @override
  void dispose() {
    _modeloController.dispose();
    _placaController.dispose();
    _corController.dispose();
    _anoController.dispose();
    _chassiController.dispose();
    super.dispose();
  }

  void _salvarCaminhao() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Caminhão salvo com sucesso!'),
          backgroundColor: AppColors.button,
        ),
      );

      Navigator.pop(context);
    }
  }

  void _adicionarNovoChassi() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const CadastroChassiScreen()),
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
                        child:Text(
                          'Cadastro de caminhão',
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      SizedBox(
                        width: 300,
                        child: CustomTextField(
                          hintText: 'Modelo',
                          controller: _modeloController,
                          icon: Icons.directions_bus_outlined,
                          validator: (value) => value == null || value.isEmpty ? 'Campo obrigatório' : null,
                        ),
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                        width: 300,
                        child: CustomTextField(
                          hintText: 'Placa',
                          controller: _placaController,
                          icon: Icons.confirmation_number_outlined,
                          validator: (value) => value == null || value.isEmpty ? 'Campo obrigatório' : null,
                        ),
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                        width: 300,
                        child: CustomTextField(
                          hintText: 'Cor',
                          controller: _corController,
                          icon: Icons.palette_outlined,
                          validator: (value) => value == null || value.isEmpty ? 'Campo obrigatório' : null,
                        ),
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                        width: 300,
                        child: CustomTextField(
                          hintText: 'Ano',
                          controller: _anoController,
                          icon: Icons.date_range_outlined,
                          validator: (value) => value == null || value.isEmpty ? 'Campo obrigatório' : null,
                        ),
                      ),
                      const SizedBox(height: 30),
                      SizedBox(
                        width: 300,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Chassi',
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 14,
                                color: AppColors.inputText,
                              ),
                            ),
                            GestureDetector(
                              onTap: _adicionarNovoChassi,
                              child: const Text(
                                'novo +',
                                style: TextStyle(
                                  fontFamily: 'Inter',
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.redAccent,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),
                      SizedBox(
                        width: 300,
                        child: CustomTextField(
                          hintText: 'Pesquise o chassi',
                          controller: _chassiController,
                          icon: Icons.search,
                        ),
                      ),
                      const SizedBox(height: 40),
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
                          onPressed: _salvarCaminhao,
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
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
