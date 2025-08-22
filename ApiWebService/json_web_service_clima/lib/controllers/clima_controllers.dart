import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:json_web_service_clima/models/clima_model.dart';

class ClimaControllers {
  final String _apiKey = 'd0efdc7578faae6ecd75524d8a2289de';

  // Métodos
  Future<Clima?> getClima(String cidade) async {
    // Converte a String em URL
    final url = Uri.parse(
      "https://api.openweathermap.org/data/2.5/weather?q=$cidade&appid=$_apiKey&units=metric&lang=pt_br",
    );
    final res = await http.get(url);

    // Verifica se deu certo
    if (res.statusCode == 200) {
      final dados = json.decode(res.body);
      return Clima.fromJson(dados);
    } else {
      return null;
    }
  }
}
