import '../../domain/entities/pagination_entity.dart';

class PaginationWithDataModel<T> {
  final PaginationModel pagination;
  final T data;

  PaginationWithDataModel({required this.pagination, required this.data});

  factory PaginationWithDataModel.fromJson({
    required Map<String, dynamic> json,
    required T Function(dynamic json) fromJsonT,
    String? keyName,
  }) {
    final dataJson = json[keyName ?? "data"];

    return PaginationWithDataModel<T>(
      pagination: PaginationModel.fromJson(json["pagination"]),
      data: fromJsonT(dataJson),
    );
  }
}

class PaginationModel extends PaginationEntity {
  PaginationModel({
    required super.page,
    required super.perPage,
    required super.total,
    required super.lastPage,
    required super.totalPages,
    required super.hasNextPage,
    required super.hasPreviousPage,
  });

  factory PaginationModel.fromJson(Map<String, dynamic> json) {
    return PaginationModel(
      page: _readInt(json['page']),
      perPage: _readInt(json['per_page']),
      total: _readInt(json['total']),
      lastPage: _readInt(json['last_page']),
      totalPages: _readInt(json['total_page'] ?? json['total_pages']),
      hasNextPage: json['has_next_page'] ?? false,
      hasPreviousPage: json['has_previous_page'] ?? false,
    );
  }

  static int _readInt(dynamic value) {
    if (value is int) return value;
    return int.tryParse(value?.toString() ?? '') ?? 0;
  }
}
