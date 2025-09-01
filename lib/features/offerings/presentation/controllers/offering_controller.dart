import 'package:get/get.dart';
import 'package:mynewearth_practical_interview/core/widgets/custom_snackbar.dart';
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
      CustomSnackBar.showError( 'Failed to load offerings');
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
      CustomSnackBar.showSuccess("Offering added successfully");
    } catch (e) {
      CustomSnackBar.showError('Failed to add offering');
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
      CustomSnackBar.showSuccess('Offering updated successfully');
    } catch (e) {
      CustomSnackBar.showError( 'Failed to update offering');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> deleteExistingOffering(int id) async {
    try {
      isLoading.value = true;
      await _deleteOffering(id);
      await loadOfferings();
      CustomSnackBar.showSuccess('Offering deleted successfully');
    } catch (e) {
      CustomSnackBar.showError( 'Failed to delete offering');
    } finally {
      isLoading.value = false;
    }
  }
}