import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:map_app/components/my_point_details.dart';


class MyMapMarkers extends StatelessWidget {
  final LatLng userLocation;
  final List<Map<String, dynamic>> filteredPoints;
  //kullanıcının ve diğer konumların harita üzerinde gösterilmesini sağlayan component

  const MyMapMarkers({
    super.key,
    required this.userLocation,
    required this.filteredPoints,
  });

  @override
  Widget build(BuildContext context) {
    return MarkerLayer(
      markers: [
   
        Marker(
          point: userLocation,
          child: const Icon(Icons.location_on, color: Colors.red, size: 40),
        ),
  
        ...filteredPoints.map((point) => Marker(
              point: LatLng(point['latitude'], point['longitude']),
              child: GestureDetector(
                onTap: () => MyPointDetailsDialog.show(context, point),
                child: const Icon(Icons.location_pin, color: Colors.blue, size: 40),
              ),
            )),
      ],
    );
  }
}