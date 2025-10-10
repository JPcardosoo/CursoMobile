import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import '../services/location_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ImagePicker _picker = ImagePicker();
  List<File> _images = [];
  List<Map<String, String>> _photoInfo = [];

  Future<void> _takePhoto() async {
    try {
      final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
      if (photo == null) return;

      // Obtém localização e hora formatada
      final locationData = await LocationService.getCurrentLocation();

      // Salva a imagem em app_flutter
      final appDir = await getApplicationDocumentsDirectory();
      final fileName = DateTime.now().millisecondsSinceEpoch.toString();
      final savedImage = await File(photo.path).copy('${appDir.path}/$fileName.jpg');

      setState(() {
        _images.add(savedImage);
        _photoInfo.add(locationData);
      });

      debugPrint("Foto tirada: ${savedImage.path}");
      debugPrint("Local: ${locationData['city']}  ${locationData['dateTime']}");
    } catch (e) {
      debugPrint('Erro ao tirar foto: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Minhas Fotos'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: _images.length,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.file(_images[index]),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    '${_photoInfo[index]['city']}\n ${_photoInfo[index]['dateTime']}',
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _takePhoto,
        child: const Icon(Icons.camera_alt),
      ),
    );
  }
}
