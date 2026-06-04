import 'package:pos/domain/entities/general_setting_entity.dart';

abstract class SettingRepo {
  Future<GeneralSettingEntity> getGeneralSetting();
  Future<bool> postGeneralSetting(GeneralSettingEntity setting);
  Future<String> getContent(String key);
  Future<bool> insertContent(String key, String data);
}
