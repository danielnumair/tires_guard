import 'package:flutter/material.dart';
import '../core/theme/app_colors.dart';
import '../models/atendimento.dart';
import 'package:intl/intl.dart';
import 'mapa_pneus_atendimento_screen.dart';
import 'galeria_fotos_screen.dart';

class AtendimentoDetalhesScreen extends StatefulWidget {
  final Atendimento atendimento;

  const AtendimentoDetalhesScreen({super.key, required this.atendimento});

  @override
  State<AtendimentoDetalhesScreen> createState() => _AtendimentoDetalhesScreenState();
}

class _AtendimentoDetalhesScreenState extends State<AtendimentoDetalhesScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _observacoesController = TextEditingController();
  bool _finalizado = false;

  @override
  void initState() {
    super.initState();
    _observacoesController.text = widget.atendimento.observacoes;
    _finalizado = widget.atendimento.status.toLowerCase() == 'concluído';
  }

  void _salvar() {
    setState(() {
      widget.atendimento.observacoes = _observacoesController.text;
      widget.atendimento.status = _finalizado ? 'concluído' : 'pendente';
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Alterações salvas com sucesso!'),
        backgroundColor: AppColors.button,
      ),
    );
    Navigator.pop(context);
  }

  void _cancelar() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final statusColor = widget.atendimento.status.toLowerCase() == 'pendente'
        ? Colors.orange
        : Colors.greenAccent;
    final dataFormatada = DateFormat('dd/MM/yyyy').format(widget.atendimento.data);

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
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Atendimento ${widget.atendimento.id}',
                        style: const TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Veículo: ${widget.atendimento.veiculo}',
                        style: const TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 16,
                          color: AppColors.inputText,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Chassi: ${widget.atendimento.chassi}',
                        style: const TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 16,
                          color: AppColors.inputText,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Cor: ${widget.atendimento.cor ?? '---'}    Placa: ${widget.atendimento.placa ?? '---'}',
                        style: const TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 16,
                          color: AppColors.inputText,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Data: $dataFormatada',
                        style: const TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 16,
                          color: AppColors.inputText,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Status: ${widget.atendimento.status}',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 16,
                          color: statusColor,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Responsável: ${widget.atendimento.responsavel ?? '---'}',
                        style: const TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 16,
                          color: AppColors.inputText,
                        ),
                      ),
                      const SizedBox(height: 24),
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => MapaPneusAtendimentoScreen(
                                      atendimento: widget.atendimento,
                                    ),
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.button,
                                padding: const EdgeInsets.symmetric(vertical: 14),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                  side: const BorderSide(color: Colors.black, width: 1),
                                ),
                              ),
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
                          const SizedBox(width: 12),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => GaleriaFotosScreen(atendimentoId: widget.atendimento.id),
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.button,
                                padding: const EdgeInsets.symmetric(vertical: 14),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                  side: const BorderSide(color: Colors.black, width: 1),
                                ),
                              ),
                              child: const Text(
                                'Galeria de Fotos',
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
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: _observacoesController,
                        maxLines: 6,
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
                      const SizedBox(height: 12),
                      CheckboxListTile(
                        value: _finalizado,
                        onChanged: (val) => setState(() => _finalizado = val ?? false),
                        title: const Text(
                          'Atendimento finalizado',
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 16,
                            color: AppColors.white,
                          ),
                        ),
                        activeColor: AppColors.button,
                        controlAffinity: ListTileControlAffinity.leading,
                        contentPadding: EdgeInsets.zero,
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: double.infinity,
                        height: 48,
                        child: ElevatedButton(
                          onPressed: _salvar,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF4F160B),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                              side: const BorderSide(color: Colors.black),
                            ),
                          ),
                          child: const Text('Salvar', style: TextStyle(color: Colors.white)),
                        ),
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                        width: double.infinity,
                        height: 48,
                        child: ElevatedButton(
                          onPressed: _cancelar,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                              side: const BorderSide(color: Colors.black),
                            ),
                          ),
                          child: const Text('Cancelar', style: TextStyle(color: Colors.white)),
                        ),
                      ),
                      const SizedBox(height: 16),
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
