import 'package:flutter/material.dart';
import '../core/theme/app_colors.dart';
import '../widgets/custom_text_field.dart';
import '../models/pneu.dart';

class CadastroPneuScreen extends StatefulWidget {
  final Pneu? pneu;

  const CadastroPneuScreen({super.key, this.pneu});

  @override
  State<CadastroPneuScreen> createState() => _CadastroPneuScreenState();
}

class _CadastroPneuScreenState extends State<CadastroPneuScreen> {
  final _formKey = GlobalKey<FormState>();
  final _marcaController = TextEditingController();
  final _fabricanteController = TextEditingController();
  final _statusController = TextEditingController();
  final _serieController = TextEditingController();
  final _fogoController = TextEditingController();
  final _aroController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.pneu != null) {
      _marcaController.text = widget.pneu!.marca;
      _fabricanteController.text = widget.pneu!.fabricante;
      _statusController.text = widget.pneu!.status;
      _serieController.text = widget.pneu!.serie;
      _fogoController.text = widget.pneu!.fogo;
      _aroController.text = widget.pneu!.aro;
    }
  }

  @override
  void dispose() {
    _marcaController.dispose();
    _fabricanteController.dispose();
    _statusController.dispose();
    _serieController.dispose();
    _fogoController.dispose();
    _aroController.dispose();
    super.dispose();
  }

  void _salvarPneu() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Pneu salvo com sucesso!'),
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
            crossAxisAlignment: CrossAxisAlignment.stretch,
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
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Cadastro de pneus',
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
                          hintText: 'Marca',
                          controller: _marcaController,
                          icon: Icons.tire_repair,
                          validator: (value) => value == null || value.isEmpty ? 'Campo obrigatório' : null,
                        ),
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                        width: 300,
                        child: CustomTextField(
                          hintText: 'Fabricante',
                          controller: _fabricanteController,
                          icon: Icons.factory,
                          validator: (value) => value == null || value.isEmpty ? 'Campo obrigatório' : null,
                        ),
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                        width: 300,
                        child: CustomTextField(
                          hintText: 'Status/local',
                          controller: _statusController,
                          icon: Icons.location_on_outlined,
                          validator: (value) => value == null || value.isEmpty ? 'Campo obrigatório' : null,
                        ),
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                        width: 300,
                        child: CustomTextField(
                          hintText: 'Número de série',
                          controller: _serieController,
                          icon: Icons.numbers,
                          validator: (value) => value == null || value.isEmpty ? 'Campo obrigatório' : null,
                        ),
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                        width: 300,
                        child: CustomTextField(
                          hintText: 'Número de fogo',
                          controller: _fogoController,
                          icon: Icons.local_fire_department_outlined,
                          validator: (value) => value == null || value.isEmpty ? 'Campo obrigatório' : null,
                        ),
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                        width: 300,
                        child: CustomTextField(
                          hintText: 'Aro',
                          controller: _aroController,
                          icon: Icons.circle_outlined,
                          validator: (value) => value == null || value.isEmpty ? 'Campo obrigatório' : null,
                        ),
                      ),
                      const SizedBox(height: 24),
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
                          onPressed: _salvarPneu,
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
