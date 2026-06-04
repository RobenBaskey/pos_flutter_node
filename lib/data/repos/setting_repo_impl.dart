import 'package:pos/data/datasource/remote_db/setting_db_source.dart';
import 'package:pos/domain/entities/general_setting_entity.dart';
import 'package:pos/domain/repos/setting_repo.dart';

class SettingRepoImpl extends SettingRepo {
  final SettingDbSource _dbSource;
  SettingRepoImpl(this._dbSource);

  @override
  Future<GeneralSettingEntity> getGeneralSetting() {
    return _dbSource.getGeneralSetting();
  }

  @override
  Future<bool> postGeneralSetting(GeneralSettingEntity setting) {
    return _dbSource.postGeneralSetting(setting);
  }

  @override
  Future<String> getContent(String key) {
    return _dbSource.getContent(key);
  }

  @override
  Future<bool> insertContent(String key, String data) {
    return _dbSource.insertContent(key, data);
  }
}
