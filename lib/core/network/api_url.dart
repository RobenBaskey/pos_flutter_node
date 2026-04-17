class ApiUrl {
  static const String _rootUrl = "https://api.jonosokti.com/";
  //static const String _rootUrl = "http://localhost:8005/";
  static const String _baseUrl = "${_rootUrl}v1";
  static String getImageBaseUrl() => _rootUrl;

  ///auth urls
  static String loginUrl() => "$_baseUrl/admin-auth/login";

  ///category urls
  static String getCategoryUrl() => "$_baseUrl/category/tree-category";
  static String getAllCategoryUrl() => "$_baseUrl/categories";
  static String addCategoryUrl() => "$_baseUrl/category/insert-category";
  static String updateCategoryUrl() => "$_baseUrl/category/update-category";
  static String deleteCategoryUrl(String id) =>
      "$_baseUrl/category/delete-category?id=$id";

  ///job type url
  static String getJobTypeUrl() => "$_baseUrl/job/all-job-types";
  static String updateJobTypeUrl() => "$_baseUrl/admin/update-job-type";
  static String deleteJobTypeUrl(String id) =>
      "$_baseUrl/admin/delete-job-type?id=$id";
  static String addJobTypeUrl() => "$_baseUrl/admin/insert-job-type";

  ///workplace type url
  static String getWorkplaceTypeUrl() => "$_baseUrl/job/all-workplace-types";
  static String updateWorkplaceTypeUrl() =>
      "$_baseUrl/admin/update-workplace-type";
  static String deleteWorkplaceTypeUrl(String id) =>
      "$_baseUrl/admin/delete-workplace-type?id=$id";
  static String addWorkplaceTypeUrl() =>
      "$_baseUrl/admin/insert-workplace-type";

  ///package url
  static String getPackageUrl() => "$_baseUrl/package/packages";
  static String getSinglePackageUrl(String id) =>
      "$_baseUrl/package/single-package?id=$id";
  static String insertPackageUrl() => "$_baseUrl/package/insert-package";
  static String updatePackageUrl() => "$_baseUrl/package/update-package";
  static String deletePackageUrl(String id) =>
      "$_baseUrl/package/delete-package?id=$id";
  static String insertPackageContentUrl() =>
      "$_baseUrl/package/insert-package-content";
  static String updatePackageContentUrl() =>
      "$_baseUrl/package/update-package-content";
  static String deletePackageContentUrl({
    required String packageId,
    required String contentId,
  }) =>
      "$_baseUrl/package/delete-package-content?package_id=$packageId&content_id=$contentId";

  ///coupon
  static String getCouponUrl() => "$_baseUrl/coupen/all-coupens";
  static String insertCouponUrl() => "$_baseUrl/coupen/insert-coupen";
  static String updateCouponUrl() => "$_baseUrl/coupen/update-coupen";
  static String deleteCouponUrl(String id) =>
      "$_baseUrl/coupen/delete-coupen?id=$id";

  ///user url
  static String getUserUrl({
    required String type,
    int page = 1,
    int limit = 10,
  }) => "$_baseUrl/user/filter-user?user_type=$type&page=$page&limit=$limit";
}
