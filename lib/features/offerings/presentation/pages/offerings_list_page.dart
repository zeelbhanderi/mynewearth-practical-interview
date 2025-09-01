import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../controllers/offering_controller.dart';
import '../widgets/offering_card.dart';
import 'add_edit_offering_page.dart';

class OfferingsListPage extends StatelessWidget {
  const OfferingsListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<OfferingController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          AppStrings.offerings,
          style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.text),
        ),
        centerTitle: true,
      ),
      body: Obx(() {
        if (controller.isLoading.value && controller.offerings.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.offerings.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.spa_outlined,
                  size: 80,
                  color: AppColors.subDescription,
                ),
                const SizedBox(height: 24),
                Text(
                  'No offerings yet',
                  style: TextStyle(
                    fontSize: 18,
                    color: AppColors.description,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Tap the + button to add your first offering',
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.subDescription,
                  ),
                ),
              ],
            ),
          );
        }

        return RefreshIndicator(
          onRefresh: controller.loadOfferings,
          color: AppColors.primary,
          child: ListView.builder(
            padding: const EdgeInsets.all(20),
            itemCount: controller.offerings.length,
            itemBuilder: (context, index) {
              final offering = controller.offerings[index];
              return OfferingCard(
                offering: offering,
                onTap: () =>
                    Get.to(() => AddEditOfferingPage(offering: offering)),
                onDelete: () =>
                    _showDeleteDialog(context, controller, offering.id!),
              );
            },
          ),
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.to(() => const AddEditOfferingPage()),
        backgroundColor: AppColors.primary,
        elevation: 4,
        child: const Icon(Icons.add, color: AppColors.text, size: 28),
      ),
    );
  }

  void _showDeleteDialog(
    BuildContext context,
    OfferingController controller,
    int id,
  ) {
    Get.dialog(
      AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text(
          'Delete Offering',
          style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.text),
        ),
        content: const Text(
          'Are you sure you want to delete this offering? This action cannot be undone.',
          style: TextStyle(color: AppColors.textLight),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text(
              AppStrings.cancel,
              style: TextStyle(color: AppColors.textLight),
            ),
          ),
          TextButton(
            onPressed: () {
              Get.back();
              controller.deleteExistingOffering(id);
            },
            child: const Text(
              AppStrings.delete,
              style: TextStyle(color: AppColors.error),
            ),
          ),
        ],
      ),
    );
  }
}
