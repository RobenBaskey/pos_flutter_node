import 'package:pos/core/network/api_url.dart';
import 'package:pos/core/network/dio_client.dart';
import 'package:pos/domain/entities/general_setting_entity.dart';

abstract class SettingDbSource {
  Future<GeneralSettingEntity> getGeneralSetting();
  Future<bool> postGeneralSetting(GeneralSettingEntity setting);
  Future<String> getContent(String key);
  Future<bool> insertContent(String key, String data);
}

class SettingDbSourceImpl extends SettingDbSource {
  final DioClients _clients;
  SettingDbSourceImpl(this._clients);

  @override
  Future<GeneralSettingEntity> getGeneralSetting() async {
    try {
      final response = await _clients.get(
        url: ApiUrl.getGeneralSetting(),
        isTokenRequired: true,
      );
      return GeneralSettingEntity.fromJson(_extractMap(response));
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<bool> postGeneralSetting(GeneralSettingEntity setting) async {
    try {
      await _clients.post(
        url: ApiUrl.postGeneralSetting(),
        body: setting.toJson(),
        isTokenRequired: true,
      );
      return true;
    } on Exception {
      rethrow;
    }
  }

  @override
  Future<String> getContent(String key) async {
    try {
      final response = await _clients.get(
        url: ApiUrl.getSettingContent(key),
        isTokenRequired: true,
      );
      return _extractContent(response, key);
    } on Exception {
      return "";
    }
  }

  @override
  Future<bool> insertContent(String key, String data) async {
    try {
      await _clients.post(
        url: ApiUrl.insertSettingContent(),
        body: {"key": key, "content_html": data},
        isTokenRequired: true,
      );
      return true;
    } on Exception {
      rethrow;
    }
  }

  String _extractContent(dynamic response, String key) {
    dynamic data = response;
    if (data is Map && data['data'] != null) data = data['data'];

    if (data is List) {
      data = data.cast<dynamic>().firstWhere(
        (item) => item is Map && item['key'] == key,
        orElse: () => null,
      );
    }

    if (data is Map) {
      return (data['content_html'] ?? data['content'] ?? data['html'] ?? '')
          .toString();
    }

    return data?.toString() ?? '';
  }

  Map<String, dynamic> _extractMap(dynamic response) {
    dynamic data = response;
    if (data is Map && data['data'] != null) data = data['data'];
    if (data is List && data.isNotEmpty) data = data.first;

    if (data is Map) {
      return Map<String, dynamic>.from(data);
    }

    return <String, dynamic>{};
  }
}
