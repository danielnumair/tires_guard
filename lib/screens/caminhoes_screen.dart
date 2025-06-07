import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../core/theme/app_colors.dart';
import 'cadastro_caminhao_screen.dart';
import '../models/caminhao.dart';

class CaminhoesScreen extends StatefulWidget {
  const CaminhoesScreen({super.key});

  @override
  State<CaminhoesScreen> createState() => _CaminhoesScreenState();
}

class _CaminhoesScreenState extends State<CaminhoesScreen> {
  Future<List<Caminhao>> carregarCaminhoes() async {
    await Future.delayed(const Duration(seconds: 1));
    return [
      Caminhao(modelo: 'Volvo FH', placa: 'ABC-1234', cor: 'Branco', ano: '2022', chassi: 'CH001'),
      Caminhao(modelo: 'Scania R450', placa: 'XYZ-5678', cor: 'Vermelho', ano: '2021', chassi: 'CH002'),
      Caminhao(modelo: 'Mercedes-Benz Actros', placa: 'DEF-4321', cor: 'Preto', ano: '2023', chassi: 'CH003'),
      Caminhao(modelo: 'DAF XF', placa: 'GHI-8765', cor: 'Azul', ano: '2020', chassi: 'CH004'),
      Caminhao(modelo: 'Iveco Hi-Way', placa: 'JKL-1122', cor: 'Prata', ano: '2021', chassi: 'CH005'),
    ];
  }

  void _abrirCadastroCaminhao({Caminhao? caminhao}) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CadastroCaminhaoScreen(caminhao: caminhao),
      ),
    );
  }

  Widget _paginaBotao(IconData icon, bool enabled) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2),
      child: Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          color: enabled ? const Color(0xFF444444) : const Color(0xFF262626),
          borderRadius: BorderRadius.circular(6),
        ),
        child: IconButton(
          icon: Icon(icon, size: 16, color: Colors.white),
          onPressed: enabled ? () {} : null,
          padding: EdgeInsets.zero,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light.copyWith(statusBarColor: Colors.black),
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: SafeArea(
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
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back, color: AppColors.inputText),
                      tooltip: 'Voltar ao menu',
                      onPressed: () => Navigator.pop(context),
                    ),
                    const Text(
                      'CAMINHÕES',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: AppColors.inputText,
                      ),
                    ),
                  ],
                ),
              ),
              Container(width: double.infinity, height: 1, color: Colors.grey),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 8),
                child: Row(
                  children: const [
                    Expanded(
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Placa',
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: AppColors.inputText,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Modelo',
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: AppColors.inputText,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Cor',
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: AppColors.inputText,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: FutureBuilder<List<Caminhao>>(
                  future: carregarCaminhoes(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return const Center(child: Text('Erro ao carregar caminhões'));
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Center(child: Text('Nenhum caminhão encontrado'));
                    }

                    final lista = snapshot.data!;
                    return Align(
                      alignment: Alignment.topCenter,
                      child: SizedBox(
                        width: 340,
                        child: ListView.builder(
                          itemCount: lista.length,
                          itemBuilder: (context, index) {
                            final caminhao = lista[index];
                            return Column(
                              children: [
                                ListTile(
                                  contentPadding: const EdgeInsets.symmetric(horizontal: 0),
                                  title: Row(
                                    children: [
                                      Expanded(
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(caminhao.placa,
                                              style: const TextStyle(
                                                  fontFamily: 'Inter', fontWeight: FontWeight.w500, color: AppColors.white)),
                                        ),
                                      ),
                                      Expanded(
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(caminhao.modelo,
                                              style: const TextStyle(
                                                  fontFamily: 'Inter', fontWeight: FontWeight.w500, color: AppColors.white)),
                                        ),
                                      ),
                                      Expanded(
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(caminhao.cor,
                                              style: const TextStyle(
                                                  fontFamily: 'Inter', fontWeight: FontWeight.w500, color: AppColors.white)),
                                        ),
                                      ),
                                    ],
                                  ),
                                  trailing: IconButton(
                                    icon: const Icon(Icons.open_in_new, color: AppColors.white),
                                    onPressed: () => _abrirCadastroCaminhao(caminhao: caminhao),
                                  ),
                                ),
                                const Divider(color: Colors.grey),
                              ],
                            );
                          },
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.button,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                          side: const BorderSide(color: Colors.black),
                        ),
                      ),
                      onPressed: () => _abrirCadastroCaminhao(),
                      child: const Text(
                        'Cadastrar novo caminhão',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        _paginaBotao(Icons.first_page, false),
                        _paginaBotao(Icons.navigate_before, false),
                        _paginaBotao(Icons.navigate_next, true),
                        _paginaBotao(Icons.last_page, true),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
