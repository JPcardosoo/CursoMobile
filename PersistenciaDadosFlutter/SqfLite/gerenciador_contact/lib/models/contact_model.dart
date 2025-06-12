class Contact {
  final int? id;
  final String nome;
  final String telefone;
  final String? email;

  Contact({
    this.id,
    required this.nome,
    required this.telefone,
    this.email,
  });

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "nome": nome,
      "telefone": telefone,
      "email": email,
    };
  }

  factory Contact.fromMap(Map<String, dynamic> map) {
    return Contact(
      id: map["id"] as int?,
      nome: map["nome"] as String,
      telefone: map["telefone"] as String,
      email: map["email"] as String?,
    );
  }
}