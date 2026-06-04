class DashboardEntity {
  final int? totalTodayActiveUser;
  final int? totalCategories;
  final int? totalJobs;
  final int? totalUsers;
  final int? totalCustomers;
  final int? totalProviders;
  final int? totalBookings;
  final List<ErDistributionByCategoryEntity>? customerDistributionByCategory;
  final List<ErDistributionByCategoryEntity>? providerDistributionByCategory;

  DashboardEntity({
    this.totalTodayActiveUser,
    this.totalCategories,
    this.totalJobs,
    this.totalUsers,
    this.totalCustomers,
    this.totalProviders,
    this.totalBookings,
    this.customerDistributionByCategory,
    this.providerDistributionByCategory,
  });
}

class ErDistributionByCategoryEntity {
  final String? category;
  final int? count;

  ErDistributionByCategoryEntity({this.category, this.count});
}
