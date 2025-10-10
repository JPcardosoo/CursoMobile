import 'package:intl/date_symbol_data_local.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:intl/intl.dart';

class LocationService {
  static Future<Map<String, String>> getCurrentLocation() async {
    await initializeDateFormatting('pt_BR', null);

    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw Exception('Serviço de localização desativado.');
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception('Permissão de localização negada.');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw Exception(
          'Permissão de localização permanentemente negada. Vá nas configurações e habilite manualmente.');
    }

    final position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    final placemarks = await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );

    final placemark = placemarks.first;

    String city = placemark.subAdministrativeArea ??
        placemark.locality ??
        'Cidade desconhecida';

    String country = placemark.isoCountryCode == 'BR'
        ? 'Brasil'
        : placemark.country ?? '';

    String formattedDate =
        DateFormat('dd/MM/yyyy HH:mm', 'pt_BR').format(DateTime.now());

    return {
      'city': '$city - $country',
      'dateTime': formattedDate,
    };
  }
}
