//classe modelos - > conectar com as entidades do BD

class Pet{
  final int? id; // Permite se nulo
  final String nome;
  final String raca;
  final String nomeDono;
  final String telefoneDono;

  Pet({
    this.id,
    required this.nome,
    required this.raca,
    required this.nomeDono,
    required this.telefoneDono,
  });

  // Métodos do conversão -> obg -> BD : BD -> obj

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "nome": nome,
      "raca": raca,
      "nomeDono": nomeDono,
      "telefone_Dono": telefoneDono, 
    };
  }

  factory Pet.fromMap(Map<String, dynamic> Map) {
    return Pet(
        id: map["id"] as int,
        nome: map["nome"] as String,
        raca: ap["raca"] as String,
        nomeDono: map["nome_dono"] as String,
        telefoneDono: map["telefone_dono"] as String,);
  }
}