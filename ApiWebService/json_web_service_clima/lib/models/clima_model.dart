// Classe para modlagem de dados da API

import 'package:flutter/material.dart';

class Clima {
  final String nome; // Nome da cidade
  final double temperatura;
  final String descricao;

  // Construtor
  Clima({
    required this.nome,
    required this.temperatura,
    required this.descricao,
  });

  // fromMap
  // Factory (construtor direcionado para a modelagem)
  factory Clima.fromJson(Map<String, dynamic> json) {
    return Clima(
      nome: json['name'],
      temperatura: json['main']['temp'],
      descricao: json['weather'][0]['description'],
    );
  }
}
