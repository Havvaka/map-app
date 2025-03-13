import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:map_app/components/my_filter_range.dart.dart';

import 'package:map_app/components/my_marker.dart';
import 'package:map_app/components/my_sorted_point_pdel.dart';
import 'package:map_app/services/location_service.dart';
import 'package:map_app/utils/location.dart';

import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';  // OpenStreetMap için LatLng sınıfı



class MapScreen extends StatefulWidget {
  const MapScreen({super.key});
  
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  LatLng? userLocation;
List<Map<String, dynamic>> points = [
    { "id": 1, "name": "A Noktası", "latitude": 37.0662, "longitude": 37.3833, "distance": "2.1 km" },
    { "id": 2, "name": "B Noktası", "latitude": 37.0623, "longitude": 37.3876, "distance": "2.5 km" },
    { "id": 3, "name": "C Noktası", "latitude": 37.0601, "longitude": 37.3902, "distance": "3.0 km" },
    { "id": 4, "name": "D Noktası", "latitude": 37.0550, "longitude": 37.3955, "distance": "4.0 km" },
    { "id": 5, "name": "F Noktası", "latitude": 37.0485, "longitude": 37.4030, "distance": "7.0 km" },
    // Ankara yakınlarında eklenen noktalar
    { "id": 6, "name": "Ankara Kalesi", "latitude": 39.9381, "longitude": 32.8638, "distance": "1.8 km" },
    { "id": 7, "name": "Anıtkabir", "latitude": 39.9253, "longitude": 32.8351, "distance": "3.2 km" },
    { "id": 8, "name": "ODTÜ", "latitude": 39.8914, "longitude": 32.7817, "distance": "5.7 km" },
    { "id": 9, "name": "Kızılay Meydanı", "latitude": 39.9201, "longitude": 32.8543, "distance": "0.9 km" },
    { "id": 10, "name": "Gençlik Parkı", "latitude": 39.9366, "longitude": 32.8544, "distance": "1.5 km" },
    { "id": 11, "name": "Bilkent Üniversitesi", "latitude": 39.8690, "longitude": 32.7487, "distance": "8.3 km" },
    { "id": 12, "name": "AŞTİ", "latitude": 39.9257, "longitude": 32.8143, "distance": "4.1 km" },
    { "id": 13, "name": "Eymir Gölü", "latitude": 39.8235, "longitude": 32.8359, "distance": "10.5 km" },
    { "id": 14, "name": "Atakule", "latitude": 39.8937, "longitude": 32.8636, "distance": "3.8 km" },
    { "id": 15, "name": "Ankara Etnografya Müzesi", "latitude": 39.9337, "longitude": 32.8500, "distance": "2.0 km" }
];
  List<Map<String, dynamic>> filteredPoints = [];
  double filterRadius = 5.0; 

  @override
  void initState() {
    super.initState();
    _loadUserLocation();
  }
  



  Future<void> _loadUserLocation() async {
    final location = await LocationService.getUserLocation();
    
    if (location != null) {
      setState(() {
        userLocation = location;
      });
      _filterPoints(filterRadius);
    } else {
      // Kullanıcıya konum alınamadığı hakkında bilgi verilebilir
      print("Konum alınamadı");
    }
  }
  


  void _filterPoints(double radiusInKm) {
    // seçilen kilometreye göre filtreleme işlemini yapacak fonksiyorn
    if (userLocation == null) return;

    setState(() {
      filteredPoints = LocationUtils.filterPointsByRadius(
        userLocation!,
        points,
        radiusInKm,
      );
      filterRadius = radiusInKm;
    });
  }

  void _showFilterDialog() {
    //Kullanıcının filtreleme işlemini yapacağı modal ekranı 
    FilterRange.show(context, filterRadius, _filterPoints);
  }
void _showSortDistance() {
  //kullanıcının sıralama işlemini yapacağı modal ekranı
  if (userLocation == null) return;

// Verileri sıralalama işleminin ve kullanıcıya yakınlığının hesaplanacağı fonsiyorn
  List<Map<String, dynamic>> sortedPoints = List.from(filteredPoints);
  sortedPoints.sort((a, b) {
    double distanceA = LocationUtils.calculateDistance(
      userLocation!,
      LatLng(a['latitude'], a['longitude']),
    );
    double distanceB = LocationUtils.calculateDistance(
      userLocation!,
      LatLng(b['latitude'], b['longitude']),
    );
    return distanceA.compareTo(distanceB);
  });

  // Kullanıcının sıralanmış verileri görüntüleyeceği modal
   showModalBottomSheet(
    context: context,
    builder: (context) {
      return SortedPointsModal(
        sortedPoints: sortedPoints,
        userLocation: userLocation!,
      );
    },
  );
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor:Colors.blue,
      appBar: AppBar(
      
        backgroundColor: Colors.transparent,
        
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: const Text(
            'Harita',
            style: TextStyle(color:Colors.white,fontSize:25,fontWeight: FontWeight.bold)),
        ),
        actions: [
          //filtreleme ve sıralama ıconları
          IconButton(
            icon: Icon(Icons.filter_list,color: Colors.white),
            onPressed: _showFilterDialog,
          ),
          IconButton(onPressed: _showSortDistance, icon: Icon(Icons.swap_vert,color:Colors.white)),
        ],
      ),
      body: userLocation == null
          ? const Center(child: CircularProgressIndicator())
          : FlutterMap(
              options: MapOptions(
                initialCenter: userLocation!,
                initialZoom: 14.0,
              ),
              children: [
                TileLayer(
                  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  userAgentPackageName: 'com.example.harita_uygulamasi',
                ),
                MyMapMarkers(
                  userLocation: userLocation!,
                  filteredPoints: filteredPoints,
                ),
              ],
            ),
    );
  }
}