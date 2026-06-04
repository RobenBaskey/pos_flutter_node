class ApiUrl {
  static const String _rootUrl = "https://api.jonosokti.com/api/";
  //static const String _rootUrl = "http://localhost:8080/api/";
  static const String _baseUrl = "${_rootUrl}v1";
  //static String getImageBaseUrl() => "http://localhost:8080";
  static String getImageBaseUrl() => "https://api.jonosokti.com";

  ///auth urls
  static String loginUrl() => "$_baseUrl/admin/login";

  //dashboard url
  static String getDashboardData = "$_baseUrl/admin/dashboard";

  ///category urls
  static String getCategoryUrl() => "$_baseUrl/admin/moderator/tree-category";
  static String getAllCategoryUrl() => "$_baseUrl/categories";
  static String addCategoryUrl() => "$_baseUrl/admin/moderator/insert-category";
  static String updateCategoryUrl() =>
      "$_baseUrl/admin/moderator/update-category";
  static String deleteCategoryUrl(String id) =>
      "$_baseUrl/admin/moderator/delete-category?id=$id";

  ///job type url
  static String getJobTypeUrl() => "$_baseUrl/all-job-types";
  static String updateJobTypeUrl() =>
      "$_baseUrl/admin/moderator/update-job-type";
  static String deleteJobTypeUrl(String id) =>
      "$_baseUrl/admin/moderator/delete-job-type?id=$id";
  static String addJobTypeUrl() => "$_baseUrl/admin/moderator/insert-job-type";

  ///jobs url
  static String getAllJobsUrl({int page = 1, int limit = 10}) =>
      "$_baseUrl/admin/moderator/all-jobs?page=$page&limit=$limit";
  static String updateJobStatusUrl() =>
      "$_baseUrl/admin/moderator/update-job-status";

  ///workplace type url
  static String getWorkplaceTypeUrl() => "$_baseUrl/all-workplace-types";
  static String updateWorkplaceTypeUrl() =>
      "$_baseUrl/admin/moderator/update-workplace-type";
  static String deleteWorkplaceTypeUrl(String id) =>
      "$_baseUrl/admin/moderator/delete-workplace-type?id=$id";
  static String addWorkplaceTypeUrl() =>
      "$_baseUrl/admin/moderator/insert-workplace-type";

  ///package url
  static String getPackageUrl() => "$_baseUrl/admin/moderator/packages";
  static String getSinglePackageUrl(String id) =>
      "$_baseUrl/admin/moderator/single-package?id=$id";
  static String insertPackageUrl() =>
      "$_baseUrl/admin/moderator/insert-package";
  static String updatePackageUrl() =>
      "$_baseUrl/admin/moderator/update-package";
  static String deletePackageUrl(String id) =>
      "$_baseUrl/admin/moderator/delete-package?id=$id";
  static String insertPackageContentUrl() =>
      "$_baseUrl/admin/moderator/insert-package-content";
  static String updatePackageContentUrl() =>
      "$_baseUrl/admin/moderator/update-package-content";
  static String deletePackageContentUrl({
    required String packageId,
    required String contentId,
  }) =>
      "$_baseUrl/admin/moderator/delete-package-content?package_id=$packageId&content_id=$contentId";

  ///coupon
  static String getCouponUrl() => "$_baseUrl/admin/moderator/all-coupens";
  static String insertCouponUrl() => "$_baseUrl/admin/moderator/insert-coupen";
  static String updateCouponUrl() => "$_baseUrl/admin/moderator/update-coupen";
  static String deleteCouponUrl(String id) =>
      "$_baseUrl/admin/moderator/delete-coupen?id=$id";

  ///user url
  static String getUserUrl({
    required String type,
    int page = 1,
    int limit = 10,
  }) => "$_baseUrl/filter-user?user_type=$type&page=$page&limit=$limit";

  //role
  static String getRoleUrl() => "$_baseUrl/admin/moderator/all-admins";
  static String addRoleUrl() => "$_baseUrl/admin/super-admin/create-roles";
  static String deleteRoleUrl(String id) =>
      "$_baseUrl/admin/super-admin/delete-role?id=$id";

  ///identity url
  static String getIdentityUrl({String? status}) =>
      "$_baseUrl/admin/moderator/identity-verification-list?status${status != null ? "=$status" : ""}";
  static String verifyIdentityUrl(String userId) =>
      "$_baseUrl/admin/moderator/verify-identity?user_id=$userId";

  ///setting content
  static String getGeneralSetting() =>
      "$_baseUrl/admin/moderator/get-general-setting";

  static String postGeneralSetting() =>
      "$_baseUrl/admin/moderator/insert-general-setting";

  static String getSettingContent(String key) =>
      "$_baseUrl/admin/moderator/get-setting-content?key=$key";

  static String insertSettingContent() =>
      "$_baseUrl/admin/moderator/insert-setting-content";
}
