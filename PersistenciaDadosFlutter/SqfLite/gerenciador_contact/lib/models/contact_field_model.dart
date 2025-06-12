class ContactField {
  final int? id;
  final int contactId;
  final String tipo;
  final String? valor;

  ContactField({
    this.id,
    required this.contactId,
    required this.tipo,
    this.valor,
  });

  Map<String, dynamic> toMap() {
    return {"id": id, "contact_id": contactId, "tipo": tipo, "valor": valor};
  }

  factory ContactField.fromMap(Map<String, dynamic> map) {
    return ContactField(
      id: map["id"] as int?,
      contactId: map["contact_id"] as int,
      tipo: map["tipo"] as String,
      valor: map["valor"] as String?,
    );
  }

  ContactField copyWith({
    int? id,
    int? contactId,
    String? tipo,
    String? valor,
  }) {
    return ContactField(
      id: id ?? this.id,
      contactId: contactId ?? this.contactId,
      tipo: tipo ?? this.tipo,
      valor: valor ?? this.valor,
    );
  }
}
