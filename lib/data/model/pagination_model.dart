import '../../domain/entities/pagination_entity.dart';

class PaginationModel<T> extends PaginationEntity<T> {
  PaginationModel({
    required super.items,
    required super.lastPage,
    required super.perPage,
    required super.total,
    required super.totalPages,
  });

  factory PaginationModel.fromJson(
    Map<String, dynamic> json, {
    required String itemKey,
    required T Function(Map<String, dynamic> json) fromJsonT,
  }) {
    final itemsJson = json[itemKey] as List<dynamic>? ?? [];

    return PaginationModel<T>(
      items: itemsJson
          .map((item) => fromJsonT(item as Map<String, dynamic>))
          .toList(),
      lastPage: _readInt(json['last_page']),
      perPage: _readInt(json['per_page']),
      total: _readInt(json['total']),
      totalPages: _readInt(json['total_page'] ?? json['total_pages']),
    );
  }

  factory PaginationModel.fromResponse(
    Map<String, dynamic> json, {
    String dataKey = 'data',
    required String itemKey,
    required T Function(Map<String, dynamic> json) fromJsonT,
  }) {
    return PaginationModel<T>.fromJson(
      json[dataKey] as Map<String, dynamic>,
      itemKey: itemKey,
      fromJsonT: fromJsonT,
    );
  }

  static int _readInt(dynamic value) {
    if (value is int) return value;
    return int.tryParse(value?.toString() ?? '') ?? 0;
  }
}
