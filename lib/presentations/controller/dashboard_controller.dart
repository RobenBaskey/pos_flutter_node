import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:pos/domain/entities/dashboard_entity.dart';
import 'package:pos/domain/repos/dashboard_repo.dart';

class DashboardController extends GetxController {
  final DashboardRepo dashboardRepo;
  DashboardController(this.dashboardRepo);

  var isLoading = false.obs;
  var dashboardData = Rxn<DashboardEntity>();

  @override
  onInit() {
    super.onInit();
    getDashboardData();
  }

  Future<void> getDashboardData() async {
    try {
      isLoading.value = true;
      final dashboardData = await dashboardRepo.getDashboardData();
      this.dashboardData.value = dashboardData;
      // Process the dashboard data as needed
    } catch (e) {
      debugPrint('Error fetching dashboard data: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
