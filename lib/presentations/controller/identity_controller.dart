import 'package:get/get.dart';
import 'package:pos/core/constants/enum.dart';
import 'package:pos/data/model/identity_model.dart';
import 'package:pos/domain/repos/identity_repo.dart';

class IdentityController extends GetxController {
  final IdentityRepo _repo;
  IdentityController(this._repo);

  var isLoading = false.obs;
  var identityList = <IdentityModel>[].obs;

  var isVerifying = false.obs;

  var idenetityStatusList = [
    IdentityStatus.pending,
    IdentityStatus.verified,
    IdentityStatus.rejected,
  ];
  var selectedStatus = Rxn<IdentityStatus>();

  @override
  void onInit() {
    super.onInit();
    fetchIdentity();
  }

  Future<void> fetchIdentity({String? status}) async {
    try {
      isLoading.value = true;
      final identities = await _repo.getIdentity(status: status);
      identityList.value = identities;
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch identity data: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future verifyIdentity({required String id, required String status}) async {
    try {
      isVerifying.value = true;
      await _repo.verifyIdentity(id, status);
      Get.back();
      fetchIdentity(); // Refresh the list after verification
    } catch (e) {
      Get.snackbar('Error', 'Failed to verify identity: $e');
    } finally {
      isVerifying.value = false;
    }
  }
}
