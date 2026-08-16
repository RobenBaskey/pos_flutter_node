import 'package:pos/data/datasource/remote_db/feature_plan_db_source.dart';
import 'package:pos/data/model/feature_plan_model.dart';

import '../../domain/repos/feature_plan_repo.dart';
import '../model/pagination_model.dart';
import '../model/purchased_plan_model.dart';

class FeaturePlanRepoImpl extends FeaturePlanRepo {
  final FeaturePlanDbSource _dbSource;
  FeaturePlanRepoImpl(this._dbSource);

  @override
  Future<FeaturePlanModel> createFeaturePlan(FeaturePlanModel featurePlan) {
    return _dbSource.createFeaturePlan(featurePlan);
  }

  @override
  Future<void> deleteFeaturePlan(String featurePlanId) {
    return _dbSource.deleteFeaturePlan(featurePlanId);
  }

  @override
  Future<List<FeaturePlanModel>> getFeaturePlans() {
    return _dbSource.getFeaturePlans();
  }

  @override
  Future<FeaturePlanModel> updateFeaturePlan(FeaturePlanModel featurePlan) {
    return _dbSource.updateFeaturePlan(featurePlan);
  }

  @override
  Future<PaginationWithDataModel<List<PurchasedPlanModel>>>
  getPurchasedPlans() {
    return _dbSource.getPurchasedPlans();
  }
}
