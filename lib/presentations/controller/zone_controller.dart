import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pos/core/utils/utils.dart';
import 'package:pos/data/model/zone_model.dart';
import 'package:pos/domain/repos/zone_repo.dart';

class ZoneController extends GetxController {
  final _repo = Get.find<ZoneRepo>();
  final TextEditingController nameController = TextEditingController();
  var mapController = Rxn<GoogleMapController>();
  var isStatusActive = true.obs;
  var center = LatLng(23.8103, 90.4125).obs;
  var radius = Rxn<double>(6000);
  var selectedZone = Rxn<ZoneModel>();

  //get zones
  var isZoneGetLoading = false.obs;
  var zoneList = <ZoneModel>[].obs;

  @override
  void onInit() {
    getZones();
    super.onInit();
  }

  Future getZones() async {
    isZoneGetLoading(true);
    try {
      zoneList.value = await _repo.getZones();
      isZoneGetLoading(false);
    } on Exception catch (e) {
      isZoneGetLoading(false);
      debugPrint("Error to get zones. ${e.toString()}");
    }
  }

  Future saveZone() async {
    if (nameController.text.isEmpty) {
      Utils.showSnackBar("Please enter zone name.");
      return;
    }

    try {
      Utils.showCustomLoader();
      final result = await _repo.insertZone(
        ZoneModel(
          id: "",
          name: nameController.text,
          lat: center.value.latitude.toString(),
          long: center.value.longitude.toString(),
          radius: (radius.value ?? 6000).toInt(),
          status: isStatusActive.value,
          createdAt: DateTime.now(),
        ),
      );
      if (result != null) {
        zoneList.add(result);
        nameController.clear();
        radius.value = 6000;
        Utils.dismissLoadingDialog();
        Get.back();
      }
    } on Exception catch (e) {
      debugPrint("Error to insert zone. ${e.toString()}");
      Utils.dismissLoadingDialog();
    }
  }

  void prepareUpdateData(ZoneModel zone) {
    nameController.text = zone.name;
    center.value = LatLng(
      double.tryParse(zone.lat) ?? 0.0,
      double.tryParse(zone.long) ?? 0,
    );
    radius.value = zone.radius.toDouble();
    isStatusActive.value = zone.status;
    selectedZone.value = zone;
  }

  Future updateZone() async {
    if (nameController.text.isEmpty) {
      Utils.showSnackBar("Please enter zone name.");
      return;
    }

    try {
      Utils.showCustomLoader();
      final result = await _repo.updateZone(
        ZoneModel(
          id: "",
          name: nameController.text,
          lat: center.value.latitude.toString(),
          long: center.value.longitude.toString(),
          radius: (radius.value ?? 6000).toInt(),
          status: isStatusActive.value,
          createdAt: DateTime.now(),
        ),
        selectedZone.value?.id ?? "",
      );
      if (result != null) {
        var index = zoneList.indexWhere((e) => e.id == selectedZone.value?.id);
        if (index != -1) {
          zoneList[index] = result;
          nameController.clear();
          radius.value = 6000;
        }
        Utils.dismissLoadingDialog();
        Get.back();
      }
    } on Exception catch (e) {
      debugPrint("Error to insert zone. ${e.toString()}");
      Utils.dismissLoadingDialog();
    }
  }

  Future deleteZone(String id) async {
    try {
      Utils.showCustomLoader();
      final result = await _repo.deleteZone(id);
      if (result) {
        zoneList.removeWhere((e) => e.id == id);
      }
      Utils.dismissLoadingDialog();
      Get.back();
    } on Exception catch (e) {
      debugPrint("Error to delete zone. ${e.toString()}");
      Utils.dismissLoadingDialog();
    }
  }
}
