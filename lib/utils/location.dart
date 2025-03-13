
import 'package:latlong2/latlong.dart';
import 'dart:math';


class LocationUtils {
  // İki nokta arasındaki mesafeyi hesaplar 
  //Hem sıralama işleminde hem de filtreleme işleminde kullanıldı
  static double calculateDistance(LatLng point1, LatLng point2) {
    const double earthRadius = 6371; 
    double lat1 = point1.latitude * (pi / 180);
    double lon1 = point1.longitude * (pi / 180);
    double lat2 = point2.latitude * (pi / 180);
    double lon2 = point2.longitude * (pi / 180);

    double dLat = lat2 - lat1;
    double dLon = lon2 - lon1;

    double a = sin(dLat / 2) * sin(dLat / 2) +
        cos(lat1) * cos(lat2) * sin(dLon / 2) * sin(dLon / 2);
    double c = 2 * atan2(sqrt(a), sqrt(1 - a));

    return earthRadius * c;
  }

static List<Map<String, dynamic>> filterPointsByRadius(
  LatLng userLocation,
  List<Map<String, dynamic>> points,
  double radiusInKm,
) {
  List<Map<String, dynamic>> filteredPoints = [];
  //filterpoint listesine kullanıcının belirlediği mesafe içerisindeki konumları alır
  for (var point in points) {

    double distance = calculateDistance(
      userLocation,
      LatLng(point['latitude'], point['longitude']),
    );
    if (distance <= radiusInKm) {
      filteredPoints.add(point);
    }
  }

  return filteredPoints;
}
}