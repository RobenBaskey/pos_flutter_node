class ZoneModel {
  final String id;
  final String name;
  final String lat, long;
  final int radius;
  final bool status;
  final DateTime createdAt;

  ZoneModel({
    required this.id,
    required this.name,
    required this.lat,
    required this.long,
    required this.radius,
    required this.status,
    required this.createdAt,
  });

  factory ZoneModel.fromJson(Map<String, dynamic> json) {
    return ZoneModel(
      id: json["_id"],
      name: json["name"],
      lat: json["lat"],
      long: json["long"],
      radius: json["radius"],
      status: json["status"],
      createdAt: DateTime.parse(json['created_at']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "lat": lat,
      "long": long,
      "radius": radius,
      "status": status,
    };
  }
}
