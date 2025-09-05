class Livro {
  final int? id; 
  final String titulo;
  final String autor;
  final bool disponivel;

  Livro({
    this.id, 
    required this.titulo,
    required this.autor,
    required this.disponivel,
  });

  factory Livro.fromMap(Map<String, dynamic> map) {
    return Livro(
      id: map['id'], 
      titulo: map['titulo'],
      autor: map['autor'],
      disponivel: map['disponivel'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      if (id != null) "id": id, 
      "titulo": titulo,
      "autor": autor,
      "disponivel": disponivel,
    };
  }
}
