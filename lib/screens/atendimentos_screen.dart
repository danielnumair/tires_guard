import 'package:flutter/material.dart';
import '../core/theme/app_colors.dart';
import '../models/atendimento.dart';
import 'cadastro_atendimento_screen.dart';
import 'menu_gestor_screen.dart';
import 'login_screen.dart';
import 'atendimentos_detalhes_screen.dart';
import 'package:intl/intl.dart';

class AtendimentosScreen extends StatefulWidget {
  const AtendimentosScreen({super.key});

  @override
  State<AtendimentosScreen> createState() => _AtendimentosScreenState();
}

class _AtendimentosScreenState extends State<AtendimentosScreen> {
  final List<Atendimento> _todosAtendimentos = [
    Atendimento(
      id: 'A1',
      veiculo: 'Volvo FH 540',
      chassi: '9BWZZZ377VT004251',
      observacoes: 'Troca de pneu dianteiro.',
      data: DateTime(2025, 6, 5),
      status: 'pendente',
      cor: 'Branco',
      placa: 'ABC-1234',
      responsavel: 'João Pereira',
      eixos: 4,
      steps: 2,
      pneusPorEixo: [4, 4, 4, 4],
    ),
    Atendimento(
      id: 'A2',
      veiculo: 'Scania R450',
      chassi: '9BWZZZ377VT004252',
      observacoes: 'Verificação de alinhamento.',
      data: DateTime(2025, 6, 4),
      status: 'concluído',
      cor: 'Vermelho',
      placa: 'DEF-5678',
      responsavel: 'Maria Souza',
      eixos: 3,
      steps: 1,
      pneusPorEixo: [2, 4, 4],
    ),
    Atendimento(
      id: 'A3',
      veiculo: 'Mercedes-Benz Actros',
      chassi: '9BWZZZ377VT004253',
      observacoes: 'Revisão geral.',
      data: DateTime(2025, 6, 3),
      status: 'pendente',
      cor: 'Preto',
      placa: 'GHI-9012',
      responsavel: 'Carlos Silva',
      eixos: 5,
      steps: 2,
      pneusPorEixo: [4, 4, 2, 4, 4],
    ),
    Atendimento(
      id: 'A4',
      veiculo: 'DAF XF 105',
      chassi: '9BWZZZ377VT004254',
      observacoes: 'Troca de óleo e filtro.',
      data: DateTime(2025, 6, 2),
      status: 'concluído',
      cor: 'Azul',
      placa: 'JKL-3456',
      responsavel: 'Ana Lima',
      eixos: 2,
      steps: 1,
      pneusPorEixo: [2, 4],
    ),
    Atendimento(
      id: 'A5',
      veiculo: 'Iveco Stralis',
      chassi: '9BWZZZ377VT004255',
      observacoes: 'Inspeção dos freios.',
      data: DateTime(2025, 6, 1),
      status: 'pendente',
      cor: 'Prata',
      placa: 'MNO-7890',
      responsavel: 'Pedro Henrique',
      eixos: 3,
      steps: 2,
      pneusPorEixo: [4, 2, 4],
    ),
    Atendimento(
      id: 'A6',
      veiculo: 'MAN TGX',
      chassi: '9BWZZZ377VT004256',
      observacoes: 'Troca de pneu traseiro.',
      data: DateTime(2025, 5, 31),
      status: 'concluído',
      cor: 'Cinza',
      placa: 'PQR-1122',
      responsavel: 'Fernanda Dias',
      eixos: 4,
      steps: 1,
      pneusPorEixo: [4, 4, 2, 2],
    ),
    Atendimento(
      id: 'A7',
      veiculo: 'Volkswagen 25.420',
      chassi: '9BWZZZ377VT004257',
      observacoes: 'Diagnóstico de falha eletrônica.',
      data: DateTime(2025, 5, 30),
      status: 'pendente',
      cor: 'Verde',
      placa: 'STU-3344',
      responsavel: 'Lucas Almeida',
      eixos: 5,
      steps: 3,
      pneusPorEixo: [4, 4, 4, 4, 4],
    ),
  ];


  String _filtroStatus = 'pendente';

  List<Atendimento> get _filtrados {
    if (_filtroStatus == 'todos') return _todosAtendimentos;
    return _todosAtendimentos.where((a) => a.status == _filtroStatus).toList();
  }

  Icon _statusIcon(String status) {
    return Icon(
      status == 'pendente' ? Icons.access_time : Icons.check_circle_outline,
      color: status == 'pendente' ? Colors.orange : Colors.greenAccent,
      size: 20,
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

  void _abrirCadastroAtendimento({Atendimento? atendimento}) {
    if (atendimento != null &&
        (atendimento.veiculo.isNotEmpty ||
            atendimento.chassi.isNotEmpty ||
            atendimento.observacoes.isNotEmpty ||
            atendimento.status.isNotEmpty)) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AtendimentoDetalhesScreen(atendimento: atendimento),
        ),
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const CadastroAtendimentoScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 6),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: AppColors.inputText),
                    tooltip: 'Voltar',
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  const Text(
                    'ATENDIMENTOS',
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () => setState(() => _filtroStatus = 'todos'),
                    child: Text(
                      'TODOS',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: _filtroStatus == 'todos' ? Colors.white : AppColors.inputText,
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Container(width: 1, height: 20, color: Colors.grey),
                  const SizedBox(width: 20),
                  GestureDetector(
                    onTap: () => setState(() => _filtroStatus = 'pendente'),
                    child: Text(
                      'EM ABERTO',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: _filtroStatus == 'pendente' ? Colors.white : AppColors.inputText,
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Container(width: 1, height: 20, color: Colors.grey),
                  const SizedBox(width: 20),
                  GestureDetector(
                    onTap: () => setState(() => _filtroStatus = 'concluído'),
                    child: Text(
                      'CONCLUÍDOS',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: _filtroStatus == 'concluído' ? Colors.white : AppColors.inputText,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(width: double.infinity, height: 1, color: Colors.grey),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 8),
              child: Row(
                children: const [
                  Flexible(
                    flex: 1,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Id',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: AppColors.inputText,
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 2,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Veiculo',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: AppColors.inputText,
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 2,
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        'Data',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: AppColors.inputText,
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 2,
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        'Status',
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
              child: Align(
                alignment: Alignment.topCenter,
                child: SizedBox(
                  width: 380,
                  child: ListView.builder(
                    itemCount: _filtrados.length,
                    itemBuilder: (context, index) {
                      final a = _filtrados[index];
                      return Column(
                        children: [
                          ListTile(
                            contentPadding: const EdgeInsets.symmetric(horizontal: 0),
                            title: Row(
                              children: [
                                Flexible(
                                  flex: 1,
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(a.id,
                                    style: const TextStyle(
                                      fontFamily: 'Inter', fontSize: 14, fontWeight: FontWeight.w500, color: AppColors.white)),
                                  ),
                                ),
                                Flexible(
                                  flex: 2,
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(a.veiculo,
                                    style: const TextStyle(
                                      fontFamily: 'Inter', fontSize: 14,fontWeight: FontWeight.w500, color: AppColors.white)),
                                  ),
                                ),
                                Flexible(
                                  flex: 2,
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(DateFormat('dd/MM/yyyy').format(a.data),
                                    style: const TextStyle(
                                      fontFamily: 'Inter', fontSize: 14,fontWeight: FontWeight.w500, color: AppColors.white)),
                                  ),
                                ),
                                _statusIcon(a.status),
                              ],
                            ),
                            trailing: IconButton(
                              icon: const Icon(Icons.open_in_new, color: AppColors.white),
                              onPressed: () => _abrirCadastroAtendimento(atendimento: a),
                            ),
                          ),
                          const Divider(color: Colors.grey),
                        ],
                      );
                    },
                  ),
                ),
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
                    onPressed: () => _abrirCadastroAtendimento(),
                    child: const Text(
                      'Cadastrar atendimento',
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
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
