class Atendimento {
  final String id;
  final String veiculo;
  final String chassi;
  String observacoes;
  DateTime data;
  String status;
  String? cor;
  String? placa;
  String? responsavel;
  final int eixos;
  final int steps;
  final List<int> pneusPorEixo;

  Atendimento({
    required this.id,
    required this.veiculo,
    required this.chassi,
    required this.observacoes,
    required this.data,
    required this.status,
    this.cor,
    this.placa,
    this.responsavel,
    required this.eixos,
    required this.steps,
    required this.pneusPorEixo,
  });
}