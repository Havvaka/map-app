// lib/services/location_service.dart
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

class LocationService {
  // Kullanıcının konumunu almak için fonksiyon
  static Future<LatLng?> getUserLocation() async {
    // Konum izinlerini kontrol et
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // İzinler reddedildi
        return null;
      }
    }
    
    if (permission == LocationPermission.deniedForever) {
      // Kullanıcı izinleri kalıcı olarak reddetti
      return null;
    }
    
    try {
      // Kullanıcının konumunu al
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high
      );
      
      // Konum bilgisini LatLng olarak döndür
      return LatLng(position.latitude, position.longitude);
    } catch (e) {
      print("Konum alınamadı: $e");
      return null;
    }
  }
  
  // İzin durumunu kontrol etmek için yardımcı metod
  static Future<bool> checkLocationPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();
    return permission != LocationPermission.denied && 
           permission != LocationPermission.deniedForever;
  }
}