class Usuario {
  final String? id; // id pode ser nulo inicialmente
  final String nome;
  final String email;

  Usuario({this.id, required this.nome, required this.email});

  Map<String, dynamic> toJson() {
    final data = {
      "nome": nome,
      "email": email,
    };
    if (id != null) {
      data["id"] = id;
    }
    return data;
  }

  factory Usuario.fromJson(Map<String, dynamic> json) => Usuario(
        id: json["id"] != null ? json["id"].toString() : null,
        nome: json["nome"].toString(),
        email: json["email"].toString(),
      );
}
