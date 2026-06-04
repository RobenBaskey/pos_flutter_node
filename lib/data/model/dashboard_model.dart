import '../../domain/entities/dashboard_entity.dart';

class DashboardModel extends DashboardEntity {
  DashboardModel({
    super.totalTodayActiveUser,
    super.totalCategories,
    super.totalJobs,
    super.totalUsers,
    super.totalCustomers,
    super.totalProviders,
    super.totalBookings,
    super.customerDistributionByCategory,
    super.providerDistributionByCategory,
  });

  factory DashboardModel.fromJson(Map<String, dynamic> json) => DashboardModel(
    totalTodayActiveUser: json["total_today_active_user"],
    totalCategories: json["total_categories"],
    totalJobs: json["total_jobs"],
    totalUsers: json["total_users"],
    totalCustomers: json["total_customers"],
    totalProviders: json["total_providers"],
    totalBookings: json["total_bookings"],
    customerDistributionByCategory:
        json["customer_distribution_by_category"] == null
        ? []
        : List<ErDistributionByCategory>.from(
            json["customer_distribution_by_category"]!.map(
              (x) => ErDistributionByCategory.fromJson(x),
            ),
          ),
    providerDistributionByCategory:
        json["provider_distribution_by_category"] == null
        ? []
        : List<ErDistributionByCategory>.from(
            json["provider_distribution_by_category"]!.map(
              (x) => ErDistributionByCategory.fromJson(x),
            ),
          ),
  );
}

class ErDistributionByCategory extends ErDistributionByCategoryEntity {
  ErDistributionByCategory({super.category, super.count});

  factory ErDistributionByCategory.fromJson(Map<String, dynamic> json) =>
      ErDistributionByCategory(
        category: json["category_name"],
        count: json["total"],
      );

  Map<String, dynamic> toJson() => {"category_name": category, "total": count};
}
