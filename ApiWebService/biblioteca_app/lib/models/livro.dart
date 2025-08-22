class Livro {
  final int id;
  final String titulo;
  final String autor;
  final bool disponivel;

  Livro({
    required this.id,
    required this.titulo,
    required this.autor,
    required this.disponivel,
  });

  factory Livro.fromJson(Map<String, dynamic> json) {
    return Livro(
      id: json['id'],
      titulo: json['titulo'],
      autor: json['autor'],
      disponivel: json['disponivel'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "titulo": titulo,
      "autor": autor,
      "disponivel": disponivel,
    };
  }
}
