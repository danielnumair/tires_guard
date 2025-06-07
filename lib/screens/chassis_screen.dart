import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../core/theme/app_colors.dart';
import '../models/chassi.dart';
import 'cadastro_chassi_screen.dart';
import 'dart:math';

class ChassisScreen extends StatefulWidget {
  const ChassisScreen({super.key});

  @override
  State<ChassisScreen> createState() => _ChassisScreenState();
}

class _ChassisScreenState extends State<ChassisScreen> {
  Future<List<Chassi>> carregarChassis() async {
    await Future.delayed(const Duration(milliseconds: 1));
    final random = Random();
    return List.generate(6, (index) {
      int eixos = random.nextInt(7) + 2; // 2 a 8
      int steps = random.nextInt(6) + 1; // 1 a 6
      List<int> pneusPorEixo = List.generate(eixos, (_) => (random.nextInt(3) + 1) * 2); // 2, 4 ou 6

      return Chassi(
        codigo: 'CH${(index + 1).toString().padLeft(3, '0')}',
        numero: '${1000000000 + index}',
        observacoes: 'Obs do chassi ${index + 1}',
        caminhao: 'ABC${1000 + index}',
        eixos: eixos,
        steps: steps,
        pneusPorEixo: pneusPorEixo,
      );
    });
  }

  void _abrirCadastroChassi({Chassi? chassi}) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CadastroChassiScreen(chassi: chassi),
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
          color: enabled ? Color(0xFF444444) : Color(0xFF262626),
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
                    Image.asset('assets/images/logo.png', height: 70, semanticLabel: 'Logo do Tires Guard'),
                    Image.asset('assets/images/user.png', height: 60, semanticLabel: 'Ícone do usuário'),
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
                      'CHASSIS',
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
                          'Código',
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
                          'Número',
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: AppColors.inputText,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 30),
                  ],
                ),
              ),
              Expanded(
                child: FutureBuilder<List<Chassi>>(
                  future: carregarChassis(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return const Center(child: Text('Erro ao carregar chassis'));
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Center(child: Text('Nenhum chassi encontrado'));
                    }
                    final lista = snapshot.data!;
                    return Align(
                      alignment: Alignment.topCenter,
                      child: SizedBox(
                        width: 340,
                        child: ListView.builder(
                          itemCount: lista.length,
                          itemBuilder: (context, index) {
                            final chassi = lista[index];
                            return Column(
                              children: [
                                ListTile(
                                  contentPadding: const EdgeInsets.symmetric(horizontal: 0),
                                  title: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            chassi.codigo,
                                            style: const TextStyle(
                                              fontFamily: 'Inter',
                                              fontWeight: FontWeight.w500,
                                              color: AppColors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            chassi.numero,
                                            style: const TextStyle(
                                              fontFamily: 'Inter',
                                              fontWeight: FontWeight.w500,
                                              color: AppColors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  trailing: IconButton(
                                    icon: const Icon(Icons.open_in_new, color: AppColors.white),
                                    onPressed: () => _abrirCadastroChassi(chassi: chassi),
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
                      onPressed: () => _abrirCadastroChassi(),
                      child: const Text(
                        'Cadastrar novo chassi',
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
