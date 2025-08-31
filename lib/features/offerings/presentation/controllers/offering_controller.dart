import 'package:get/get.dart';
import '../../domain/entities/offering.dart';
import '../../domain/usecases/add_offering.dart';
import '../../domain/usecases/delete_offering.dart';
import '../../domain/usecases/get_all_offerings.dart';
import '../../domain/usecases/update_offering.dart';

class OfferingController extends GetxController {
  final GetAllOfferings _getAllOfferings;
  final AddOffering _addOffering;
  final UpdateOffering _updateOffering;
  final DeleteOffering _deleteOffering;

  OfferingController(
      this._getAllOfferings,
      this._addOffering,
      this._updateOffering,
      this._deleteOffering,
      );

  final RxList<Offering> offerings = <Offering>[].obs;
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadOfferings();
  }

  Future<void> loadOfferings() async {
    try {
      isLoading.value = true;
      final result = await _getAllOfferings();
      offerings.value = result;
    } catch (e) {
      Get.snackbar('Error', 'Failed to load offerings');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> addNewOffering(Offering offering) async {
    try {
      isLoading.value = true;
      await _addOffering(offering);
      await loadOfferings();
      Get.back();
      Get.snackbar('Success', 'Offering added successfully');
    } catch (e) {
      Get.snackbar('Error', 'Failed to add offering');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updateExistingOffering(Offering offering) async {
    try {
      isLoading.value = true;
      await _updateOffering(offering);
      await loadOfferings();
      Get.back();
      Get.snackbar('Success', 'Offering updated successfully');
    } catch (e) {
      Get.snackbar('Error', 'Failed to update offering');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> deleteExistingOffering(int id) async {
    try {
      isLoading.value = true;
      await _deleteOffering(id);
      await loadOfferings();
      Get.snackbar('Success', 'Offering deleted successfully');
    } catch (e) {
      Get.snackbar('Error', 'Failed to delete offering');
    } finally {
      isLoading.value = false;
    }
  }
}