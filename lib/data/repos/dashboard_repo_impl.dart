import 'package:pos/data/datasource/remote_db/dashboard_db_source.dart';
import 'package:pos/domain/entities/dashboard_entity.dart';
import 'package:pos/domain/repos/dashboard_repo.dart';

class DashboardRepoImpl extends DashboardRepo {
  final DashboardDbSource dashboardDbSource;
  DashboardRepoImpl({required this.dashboardDbSource});
  @override
  Future<DashboardEntity> getDashboardData() {
    return dashboardDbSource.getDashboardData();
  }
}
