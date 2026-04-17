import 'package:pos/core/network/dio_client.dart';
import 'package:pos/data/model/coupon_model.dart';

import '../../../core/network/api_url.dart';

abstract class CouponDbSource {
  Future<bool> addCoupen({required CouponModel coupon});
  Future<bool> updateCoupen({required String id, required CouponModel coupon});
  Future<bool> deleteCoupen({required String id});
  Future<List<CouponModel>> getCoupens();
}

class CouponDbSourceImpl extends CouponDbSource {
  final DioClients dioClients;
  CouponDbSourceImpl(this.dioClients);

  @override
  Future<bool> addCoupen({required CouponModel coupon}) async {
    try {
      await dioClients.post(
        url: ApiUrl.insertCouponUrl(),
        body: coupon.toJson(),
        isTokenRequired: true,
      );
      return true;
    } catch (e) {
      throw Exception("Failed to add coupon: ${e.toString()}");
    }
  }

  @override
  Future<bool> deleteCoupen({required String id}) async {
    try {
      await dioClients.delete(
        url: ApiUrl.deleteCouponUrl(id),
        isTokenRequired: true,
      );
      return true;
    } catch (e) {
      throw Exception("Failed to delete coupon: ${e.toString()}");
    }
  }

  @override
  Future<bool> updateCoupen({
    required String id,
    required CouponModel coupon,
  }) async {
    var body = coupon.toJson();

    body["coupen_id"] = id;
    try {
      await dioClients.put(
        url: ApiUrl.updateCouponUrl(),
        body: body,
        isTokenRequired: true,
      );
      return true;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<CouponModel>> getCoupens() async {
    try {
      var response = await dioClients.get(
        url: ApiUrl.getCouponUrl(),
        isTokenRequired: true,
      );
      return List<CouponModel>.from(
        response["data"]!.map((x) => CouponModel.fromJson(x)),
      );
    } catch (e) {
      throw Exception("Failed to load coupons: ${e.toString()}");
    }
  }
}
