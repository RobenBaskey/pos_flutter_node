import 'package:pos/core/network/api_url.dart';
import 'package:pos/data/model/feature_plan_model.dart';
import 'package:pos/data/model/pagination_model.dart';

import '../../../core/network/dio_client.dart';
import '../../model/purchased_plan_model.dart';
import '../../model/success_response_model.dart';

abstract class FeaturePlanDbSource {
  Future<List<FeaturePlanModel>> getFeaturePlans();
  Future<FeaturePlanModel> createFeaturePlan(FeaturePlanModel featurePlan);
  Future<FeaturePlanModel> updateFeaturePlan(FeaturePlanModel featurePlan);
  Future<void> deleteFeaturePlan(String featurePlanId);
  Future<PaginationWithDataModel<List<PurchasedPlanModel>>> getPurchasedPlans();
}

class FeaturePlanDbSourceImpl implements FeaturePlanDbSource {
  final DioClients _clients;
  FeaturePlanDbSourceImpl(this._clients);

  @override
  Future<List<FeaturePlanModel>> getFeaturePlans() async {
    try {
      final response = await _clients.get(
        url: ApiUrl.getFeaturePlanUrl(),
        isTokenRequired: true,
      );
      return SuccessResponse<List<FeaturePlanModel>>.fromJson(response, (data) {
        return (data as List).map((e) => FeaturePlanModel.fromJson(e)).toList();
      }).data;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<FeaturePlanModel> createFeaturePlan(
    FeaturePlanModel featurePlan,
  ) async {
    try {
      final response = await _clients.post(
        url: ApiUrl.createFeaturePlanUrl(),
        body: featurePlan.toJson(),
        isTokenRequired: true,
      );
      return SuccessResponse.fromJson(
        response,
        (data) => FeaturePlanModel.fromJson(data),
      ).data;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> deleteFeaturePlan(String featurePlanId) async {
    try {
      await _clients.delete(
        url: ApiUrl.deleteFeaturePlanUrl(featurePlanId),
        isTokenRequired: true,
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<FeaturePlanModel> updateFeaturePlan(
    FeaturePlanModel featurePlan,
  ) async {
    try {
      final response = await _clients.put(
        url: ApiUrl.updateFeaturePlanUrl(featurePlan.id),
        body: featurePlan.toJson(),
        isTokenRequired: true,
      );
      return SuccessResponse.fromJson(
        response,
        (data) => FeaturePlanModel.fromJson(data),
      ).data;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<PaginationWithDataModel<List<PurchasedPlanModel>>>
  getPurchasedPlans() async {
    final response = await _clients.get(
      url: ApiUrl.getPurchasedFeatureUrl(),
      isTokenRequired: true,
    );

    return SuccessResponse<
          PaginationWithDataModel<List<PurchasedPlanModel>>
        >.fromJson(
          response,
          (data) => PaginationWithDataModel<List<PurchasedPlanModel>>.fromJson(
            json: data,
            fromJsonT: (json) => (json as List)
                .map((x) => PurchasedPlanModel.fromJson(x))
                .toList(),
            keyName: "plans",
          ),
        )
        .data;
  }
}
