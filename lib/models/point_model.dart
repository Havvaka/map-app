class Point {
  final int id;
  final String name;
  final double latitude;
  final double longitude;
  final String distance;

  Point({
    required this.id,
    required this.name,
    required this.latitude,
    required this.longitude,
    required this.distance,
  });

  factory Point.fromJson(Map<String, dynamic> json) {
    return Point(
      id: json['id'],
      name: json['name'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      distance: json['distance'],
    );
  }
}