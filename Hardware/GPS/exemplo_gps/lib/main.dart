import 'package:exemplo_gps/clima_service.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

void main() {
  runApp(const MaterialApp(
    home: LocationScreen(),
  ));
}

class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key});

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  String mensagem = "Carregando localização...";

  Future<String?> _getLocation() async {
    bool serviceEnable;
    LocationPermission permission;

    serviceEnable = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnable) {
      return "Serviço de Localização está Desativado";
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return "Permissão de Localização Negada";
      }
    }

    Position position = await Geolocator.getCurrentPosition();

    try {
      final cidade = await ClimaService.getCityWeatherByPosition(position);

      if (cidade != null && cidade["main"] != null) {
        return "${cidade["name"]} -- ${(cidade["main"]["temp"] - 273).toStringAsFixed(1)}°";
      } else {
        return "Erro: cidade não encontrada";
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Erro: $e")),
      );
      return "Erro ao buscar clima";
    }
  }

  @override
  void initState() {
    super.initState();
    _loadLocation();
  }

  Future<void> _loadLocation() async {
    String? result = await _getLocation();
    setState(() {
      mensagem = result ?? "Erro ao obter localização";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("GPS - Localização")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(mensagem),
            ElevatedButton(
              onPressed: () async {
                await _loadLocation();
              },
              child: const Text("Pegar a Localização"),
            ),
          ],
        ),
      ),
    );
  }
}
