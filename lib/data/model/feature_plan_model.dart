class FeaturePlanModel {
  final String id;
  final String name;
  final int days;
  final int price;
  final bool status;
  final List<String> advantages;
  final DateTime createdAt;

  FeaturePlanModel({
    required this.id,
    required this.name,
    required this.days,
    required this.price,
    required this.status,
    required this.advantages,
    required this.createdAt,
  });

  factory FeaturePlanModel.fromJson(Map<String, dynamic> json) {
    return FeaturePlanModel(
      id: json['_id'] ?? "",
      name: json['name'] ?? "",
      days: json['days'] ?? 0,
      price: json['price'] ?? 0,
      status: json['status'] ?? false,
      advantages: json['advantages'] != null
          ? List<String>.from(json["advantages"]!.map((x) => x))
          : [],
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'days': days,
      'price': price,
      'status': status,
      'advantages': advantages,
    };
  }
}
