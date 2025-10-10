import 'dart:io';

class PhotoModel {
  final File file;
  final DateTime dateTime;
  final double latitude;
  final double longitude;

  PhotoModel({
    required this.file,
    required this.dateTime,
    required this.latitude,
    required this.longitude,
  });
}
