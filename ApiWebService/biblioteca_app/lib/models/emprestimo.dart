class Emprestimo {
  final int id;
  final int usuarioId;
  final int livroId;
  final String dataEmprestimo;
  final String dataDevolucao;
  final bool devolvido;

  Emprestimo({
    required this.id,
    required this.usuarioId,
    required this.livroId,
    required this.dataEmprestimo,
    required this.dataDevolucao,
    required this.devolvido,
  });

  factory Emprestimo.fromJson(Map<String, dynamic> json) {
    return Emprestimo(
      id: json['id'],
      usuarioId: json['usuario_id'],
      livroId: json['livro_id'],
      dataEmprestimo: json['data_emprestimo'],
      dataDevolucao: json['data_devolucao'],
      devolvido: json['devolvido'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "usuario_id": usuarioId,
      "livro_id": livroId,
      "data_emprestimo": dataEmprestimo,
      "data_devolucao": dataDevolucao,
      "devolvido": devolvido,
    };
  }
}
