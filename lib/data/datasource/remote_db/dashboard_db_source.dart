import 'package:pos/core/network/api_url.dart';
import 'package:pos/core/network/dio_client.dart';
import 'package:pos/data/model/dashboard_model.dart';

abstract class DashboardDbSource {
  Future<DashboardModel> getDashboardData();
}

class DashboardDbSourceImpl implements DashboardDbSource {
  final DioClients dioClient;
  DashboardDbSourceImpl({required this.dioClient});

  @override
  Future<DashboardModel> getDashboardData() async {
    try {
      final response = await dioClient.get(
        url: ApiUrl.getDashboardData,
        isTokenRequired: true,
      );
      if (response["data"] == null) {
        throw Exception("No data found");
      }
      return DashboardModel.fromJson(response["data"]);
    } catch (e) {
      rethrow;
    }
  }
}
