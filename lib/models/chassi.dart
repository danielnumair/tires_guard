class Chassi {
  final String codigo;
  final String numero;
  final String observacoes;
  final String caminhao;
  final int eixos;
  final int steps;
  final List<int> pneusPorEixo;

  Chassi({
    required this.codigo,
    required this.numero,
    required this.observacoes,
    required this.caminhao,
    required this.eixos,
    required this.steps,
    required this.pneusPorEixo,
  });
}