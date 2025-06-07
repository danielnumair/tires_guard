import 'package:flutter/material.dart';
import '../core/theme/app_colors.dart';
import '../models/chassi.dart';
import '../widgets/custom_text_field.dart';

class MapaPneusScreen extends StatefulWidget {
  final Chassi chassi;

  const MapaPneusScreen({super.key, required this.chassi});

  @override
  State<MapaPneusScreen> createState() => _MapaPneusScreenState();
}

class _MapaPneusScreenState extends State<MapaPneusScreen> {
  late int steps;
  late int eixos;
  late List<int> pneusPorEixo;
  final ScrollController _scrollController = ScrollController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  List<bool> pneusSelecionados = List.generate(100, (_) => false);

  @override
  void initState() {
    super.initState();
    steps = widget.chassi.steps;
    eixos = widget.chassi.eixos;
    pneusPorEixo = List<int>.from(widget.chassi.pneusPorEixo);
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
          return 'Pneu ${eixo + 1}E$pos';
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
          return 'Pneu ${eixo + 1}D$pos';
        }
      }

      eixoOffset += total;
    }

    // Steps
    int totalPneus = pneusPorEixo.fold(0, (sum, item) => sum + item);
    if (index >= totalPneus && index < totalPneus + steps) {
      int stepIndex = index - totalPneus;
      return 'Pneu ${stepIndex + 1}S';
    }

    return 'Pneu';
  }

  Widget _pneu(int index) {
    return Padding(
      padding: EdgeInsets.zero,
      child: GestureDetector(
        onTap: () {
          showDialog(
            context: context,
            builder: (_) {
              final fogoController = TextEditingController();
              final vidaController = TextEditingController();
              final serieController = TextEditingController();
              return AlertDialog(
                backgroundColor: const Color(0xFF1E1E1E),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      _getPneuTitulo(index),
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
                          hintText: 'Número de fogo',
                          controller: fogoController,
                          icon: Icons.fire_extinguisher_outlined,
                          validator: (value) => value == null || value.isEmpty ? 'Campo obrigatório' : null,
                        ),
                        const SizedBox(height: 8),
                        CustomTextField(
                          hintText: 'Número da vida',
                          controller: vidaController,
                          icon: Icons.favorite_outline,
                          keyboardType: TextInputType.number,
                          validator: (value) => value == null || value.isEmpty ? 'Campo obrigatório' : null,
                        ),
                        const SizedBox(height: 8),
                        CustomTextField(
                          hintText: 'Número de série',
                          controller: serieController,
                          icon: Icons.confirmation_number_outlined,
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
                          setState(() {
                            pneusSelecionados[index] = true;
                          });
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
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          );
        },
        child: Image.asset(
          pneusSelecionados[index]
              ? 'assets/images/pneuverde.png'
              : 'assets/images/pneupreto.png',
          width: 40,
          height: 40,
        ),
      ),
    );
  }

  Widget _input(TextEditingController controller, String hint) {
    return TextFormField(
      controller: controller,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.grey),
        filled: true,
        fillColor: Color(0xFF262626),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }


  Widget _linhaEixo(int index, int eixoIndex) {
    int totalPneus = pneusPorEixo[eixoIndex];
    int pneusLado = totalPneus ~/ 2;
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
            Row(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(pneusLado, (i) => _pneu(index + i)),
            ),
            Container(
              width: 120,
              height: 14,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(pneusLado, (i) => _pneu(index + pneusLado + i)),
            ),
          ],
        ),
        Container(
          width: 80,
          height: 36,
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () {
                  if (pneusPorEixo[eixoIndex] > 2) {
                    setState(() {
                      pneusPorEixo[eixoIndex] -= 2;
                    });
                  }
                },
                child: const Icon(Icons.remove, color: Colors.white, size: 20),
              ),
              Text(
                pneusPorEixo[eixoIndex].toString(),
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
              GestureDetector(
                onTap: () {
                  if (pneusPorEixo[eixoIndex] < 6) {
                    setState(() {
                      pneusPorEixo[eixoIndex] += 2;
                    });
                  }
                },
                child: const Icon(Icons.add, color: Colors.white, size: 20),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  void _incrementSteps() {
    if (steps < 6) {
      setState(() {
        steps++;
      });
    }
  }

  void _decrementSteps() {
    if (steps > 1) {
      setState(() {
        steps--;
      });
    }
  }

  void _incrementEixos() {
    if (eixos < 9) {
      setState(() {
        eixos++;
        pneusPorEixo.add(4);
      });
    }
  }

  void _decrementEixos() {
    if (eixos > 2) {
      setState(() {
        eixos--;
        pneusPorEixo.removeLast();
      });
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
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
                          'Chassi n ${widget.chassi.numero}',
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
                        width: 80,
                        height: 40,
                        decoration: BoxDecoration(
                          color: const Color(0xFF262626),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            GestureDetector(
                              onTap: _decrementEixos,
                              child: const Icon(Icons.remove, color: Colors.white, size: 20),
                            ),
                            Text(
                              eixos.toString(),
                              style: const TextStyle(color: Colors.white, fontSize: 22),
                            ),
                            GestureDetector(
                              onTap: _incrementEixos,
                              child: const Icon(Icons.add, color: Colors.white, size: 20),
                            ),
                          ],
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
              child: Padding(
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
                                Widget eixoWidget = _linhaEixo(offset, i);
                                offset += pneusPorEixo[i];
                                return eixoWidget;
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
                                children: [
                                  for (int i = 0; i < steps; i++) _pneu(offset + i),
                                  const SizedBox(width: 8),
                                  Container(
                                    width: 80,
                                    height: 36,
                                    decoration: BoxDecoration(
                                      color: Colors.black,
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        GestureDetector(
                                          onTap: _decrementSteps,
                                          child: const Icon(Icons.remove, color: Colors.white, size: 20),
                                        ),
                                        Text(
                                          steps.toString(),
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w600,
                                            color: Colors.white,
                                            fontSize: 18,
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: _incrementSteps,
                                          child: const Icon(Icons.add, color: Colors.white, size: 20),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
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
