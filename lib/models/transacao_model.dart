class Transacao {
  String id;
  String nome;
  double valor;
  DateTime data;
  bool receita;
  int categoriaId;
  String? descricao;

  Transacao({
    required this.id,
    required this.nome,
    required this.valor,
    required this.data,
    required this.receita,
    required this.categoriaId,
    this.descricao,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'valor': valor,
      'data': data.toIso8601String(),
      'receita': receita ? 1 : 0,
      'categoria_id': categoriaId,
      'descricao': descricao,
    };
  }

  factory Transacao.fromMap(Map<String, dynamic> map) {
    return Transacao(
      id: map['id'],
      nome: map['nome'],
      valor: map['valor'],
      data: DateTime.parse(map['data']),
      receita: map['receita'] == 1,
      categoriaId: map['categoria_id'] as int,
      descricao: map['descricao'] as String?,
    );
  }
}
