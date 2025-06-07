import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../core/theme/app_colors.dart';
import 'cadastro_pneu_screen.dart';
import '../models/pneu.dart';

class PneusScreen extends StatefulWidget {
  const PneusScreen({super.key});

  @override
  State<PneusScreen> createState() => _PneusScreenState();
}

class _PneusScreenState extends State<PneusScreen> {
  Future<List<Pneu>> carregarPneus() async {
    await Future.delayed(const Duration(seconds: 1));
    return List.generate(
      6,
          (index) => Pneu(
        marca: 'Marca $index',
        fabricante: 'Fabricante $index',
        status: index % 2 == 0 ? 'Em uso' : 'Estoque',
        serie: 'S00$index',
        fogo: 'F00000$index',
        aro: 'Aro ${index + 13}',
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

  void _abrirCadastroPneu({Pneu? pneu}) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CadastroPneuScreen(pneu: pneu),
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
                      'PNEUS',
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
                          'Série',
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
                          'Fogo',
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
                          'Marca',
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
                child: FutureBuilder<List<Pneu>>(
                  future: carregarPneus(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return const Center(child: Text('Erro ao carregar pneus'));
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Center(child: Text('Nenhum pneu encontrado'));
                    }
                    final pneus = snapshot.data!;
                    return Align(
                      alignment: Alignment.topCenter,
                      child: SizedBox(
                        width: 340,
                        child: ListView.builder(
                          itemCount: pneus.length,
                          itemBuilder: (context, index) {
                            final pneu = pneus[index];
                            return Column(
                              children: [
                                ListTile(
                                  contentPadding: const EdgeInsets.symmetric(horizontal: 0),
                                  title: Row(
                                    children: [
                                      Expanded(
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(pneu.serie,
                                              style: const TextStyle(
                                                  fontFamily: 'Inter', fontWeight: FontWeight.w500, color: AppColors.white)),
                                        ),
                                      ),
                                      Expanded(
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(pneu.fogo,
                                              style: const TextStyle(
                                                  fontFamily: 'Inter', fontWeight: FontWeight.w500, color: AppColors.white)),
                                        ),
                                      ),
                                      Expanded(
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(pneu.marca,
                                              style: const TextStyle(
                                                  fontFamily: 'Inter', fontWeight: FontWeight.w500, color: AppColors.white)),
                                        ),
                                      ),
                                    ],
                                  ),
                                  trailing: IconButton(
                                    icon: const Icon(Icons.open_in_new, color: AppColors.white),
                                    onPressed: () => _abrirCadastroPneu(pneu: pneu),
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
                      onPressed: () => _abrirCadastroPneu(),
                      child: const Text(
                        'Cadastrar novo pneu',
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
