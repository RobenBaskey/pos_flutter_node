class PaginationEntity {
  final int page;
  final int perPage;
  final int total;
  final int lastPage;
  final int totalPages;
  final bool hasNextPage;
  final bool hasPreviousPage;

  PaginationEntity({
    required this.page,
    required this.perPage,
    required this.total,
    required this.lastPage,
    required this.totalPages,
    required this.hasNextPage,
    required this.hasPreviousPage
  });
}
