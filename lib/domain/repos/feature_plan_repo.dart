import '../../data/model/feature_plan_model.dart';
import '../../data/model/pagination_model.dart';
import '../../data/model/purchased_plan_model.dart';

abstract class FeaturePlanRepo {
  Future<List<FeaturePlanModel>> getFeaturePlans();
  Future<FeaturePlanModel> createFeaturePlan(FeaturePlanModel featurePlan);
  Future<FeaturePlanModel> updateFeaturePlan(FeaturePlanModel featurePlan);
  Future<void> deleteFeaturePlan(String featurePlanId);
  Future<PaginationWithDataModel<List<PurchasedPlanModel>>> getPurchasedPlans();
}
