import 'package:flutter/material.dart';
import '../core/theme/app_colors.dart';
import '../models/atendimento.dart';
import '../widgets/pneu_afericao.dart';

class MapaPneusAtendimentoScreen extends StatefulWidget {
  final Atendimento atendimento;

  const MapaPneusAtendimentoScreen({super.key, required this.atendimento});

  @override
  State<MapaPneusAtendimentoScreen> createState() => _MapaPneusAtendimentoScreenState();
}

class _MapaPneusAtendimentoScreenState extends State<MapaPneusAtendimentoScreen> {
  late int eixos;
  late int steps;
  late List<int> pneusPorEixo;
  final ScrollController _scrollController = ScrollController();
  final List<bool> pneusAferidos = List.generate(100, (_) => false);

  @override
  void initState() {
    super.initState();
    eixos = widget.atendimento.eixos;
    steps = widget.atendimento.steps;
    pneusPorEixo = List<int>.from(widget.atendimento.pneusPorEixo);
  }

  void _salvarAlteracoes() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Mapa de pneus salvo com sucesso!'),
        backgroundColor: Color(0xFF4F160B),
      ),
    );
    Navigator.pop(context);
  }

  String _getPneuTitulo(int index) {
    int eixoOffset = 0;
    for (int eixo = 0; eixo < eixos; eixo++) {
      int total = pneusPorEixo[eixo];
      int lado = total ~/ 2;

      // Esquerda
      for (int i = 0; i < lado; i++) {
        if (index == eixoOffset + i) {
          String pos = '';
          if (lado == 1) {
            pos = '';
          } else if (lado == 2) {
            pos = i == 0 ? 'E' : 'I';
          } else {
            pos = i == 0 ? 'E' : i == 1 ? 'M' : 'I';
          }
          return 'Aferição Pneu ${eixo + 1}E$pos';
        }
      }

      // Direita
      for (int i = 0; i < lado; i++) {
        if (index == eixoOffset + lado + i) {
          String pos = '';
          if (lado == 1) {
            pos = '';
          } else if (lado == 2) {
            pos = i == 0 ? 'I' : 'E';
          } else {
            pos = i == 0 ? 'I' : i == 1 ? 'M' : 'E';
          }
          return 'Aferição Pneu ${eixo + 1}D$pos';
        }
      }

      eixoOffset += total;
    }

    // Steps
    int totalPneus = pneusPorEixo.fold(0, (sum, item) => sum + item);
    if (index >= totalPneus && index < totalPneus + steps) {
      int stepIndex = index - totalPneus;
      return 'Aferição Pneu ${stepIndex + 1}S';
    }

    return 'Pneu';
  }

  void _abrirAfericao(int index) async {
    await PneuAfericao.mostrarFormulario(
      context: context,
      titulo: _getPneuTitulo(index),
      onSalvar: () {
        setState(() {
          pneusAferidos[index] = true;
        });
      },
    );
  }

  Widget _campo(String label, TextEditingController controller) {
    return TextField(
      controller: controller,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.white70),
        filled: true,
        fillColor: const Color(0xFF262626),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }

  Widget _pneu(int index) {
    return Padding(
      padding: EdgeInsets.zero,
      child: GestureDetector(
        onTap: () => _abrirAfericao(index),
        child: Image.asset(
          pneusAferidos[index] ? 'assets/images/pneuverde.png' : 'assets/images/pneupreto.png',
          width: 36,
          height: 36,
        ),
      ),
    );
  }

  Widget _linhaEixo(int index, int eixoIndex) {
    int total = pneusPorEixo[eixoIndex];
    int lado = total ~/ 2;
    return Column(
      children: [
        Text(
          'EIXO ${eixoIndex + 1}',
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(children: List.generate(lado, (i) => _pneu(index + i))),
            Container(
              width: 120,
              height: 14,
              margin: const EdgeInsets.symmetric(horizontal: 4),
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            Row(children: List.generate(lado, (i) => _pneu(index + lado + i))),
          ],
        ),
        const SizedBox(height: 8),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    int offset = 0;
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
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
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Mapa de pneus',
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Veículo: ${widget.atendimento.veiculo}\nCor: ${widget.atendimento.cor ?? ''}      Placa: ${widget.atendimento.placa ?? ''}',
                          style: const TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 16,
                            color: AppColors.inputText,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      Container(
                        width: 60,
                        height: 40,
                        decoration: BoxDecoration(
                          color: const Color(0xFF262626),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                          child: Text(
                            eixos.toString(),
                            style: const TextStyle(color: Colors.white, fontSize: 22),
                          ),
                        ),
                      ),
                      const SizedBox(height: 2),
                      const Text(
                        'EIXOS',
                        style: TextStyle(color: Colors.white54, fontSize: 14),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFFBDBDBD),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Scrollbar(
                    controller: _scrollController,
                    thumbVisibility: true,
                    trackVisibility: true,
                    thickness: 8,
                    radius: const Radius.circular(6),
                    child: SingleChildScrollView(
                      controller: _scrollController,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: Column(
                        children: [
                          for (int i = 0; i < eixos; i++)
                            Builder(
                              builder: (context) {
                                Widget eixo = _linhaEixo(offset, i);
                                offset += pneusPorEixo[i];
                                return eixo;
                              },
                            ),
                          const SizedBox(height: 10),
                          Column(
                            children: [
                              const Text(
                                'STEP',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: List.generate(steps, (i) => _pneu(offset + i)),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: 300,
              height: 48,
              child: ElevatedButton(
                onPressed: _salvarAlteracoes,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4F160B),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                    side: const BorderSide(color: Colors.black),
                  ),
                ),
                child: const Text(
                  'Salvar',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: 300,
              height: 48,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                    side: const BorderSide(color: Colors.black),
                  ),
                ),
                child: const Text(
                  'Cancelar',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
