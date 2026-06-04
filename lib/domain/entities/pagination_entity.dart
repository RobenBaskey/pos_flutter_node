class PaginationEntity<T> {
  final List<T> items;
  final int lastPage;
  final int perPage;
  final int total;
  final int totalPages;

  PaginationEntity({
    required this.items,
    required this.lastPage,
    required this.perPage,
    required this.total,
    required this.totalPages,
  });
}
