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
}
