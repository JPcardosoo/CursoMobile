import 'package:intl/intl.dart';

class Consulta {
    // Atributos
    final int? id;
    final int PetId;
    final DateTime dataHora; // Obj é dateTime -> BD é string
    final String tipoServico;
    final String? observacao;

    Consulta({
        this.id,
        required this.petId,
        required this.dataHora,
        required this.dataHora,
        required this.tipoServico,
        this.observacao,
    });

    // toMap - obj -> BD
    Map<String, dynamic> toMap() {
        return {
            "id": id,
            "pet_id": petId,
            "data_hora": dataHora,
            "tipo_servico": tipoServico,
            "observacao": observacao
        };
    }

    // fromMap() - BD -> Obj
    factory.fromMap(Map<String, dynamic> map) {
        return Consulta(
            id: map["id"] as int, // Cast
            petId: map["pet_id"] as int,
            dataHora: DataTime.parse(map["data_hora"] as String), // Converter String em formato de da DateTime
            tipoServico: map["tipo_servico"] as Sstring,
            observacao: map["observacao"] as String?,); // Pode ser nulo
    }

    // Método formatar data e hora em formato Brasil
    String get dataHoraFormatada {
        final  formatter = DateFormat("dd/MM/yyyy HH:MM");
        return formatter.format(dataHora);
    }
}
