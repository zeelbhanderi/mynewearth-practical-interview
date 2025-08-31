import 'package:get/get.dart';
import '../../features/offerings/data/datasources/offering_local_datasource.dart';
import '../../features/offerings/data/repositories/offering_repository_impl.dart';
import '../../features/offerings/domain/repositories/offering_repository.dart';
import '../../features/offerings/domain/usecases/add_offering.dart';
import '../../features/offerings/domain/usecases/delete_offering.dart';
import '../../features/offerings/domain/usecases/get_all_offerings.dart';
import '../../features/offerings/domain/usecases/update_offering.dart';
import '../../features/offerings/presentation/controllers/offering_controller.dart';
import '../database/database_helper.dart';

class InitialBindings extends Bindings {
  @override
  void dependencies() {
    // Core
    Get.put(DatabaseHelper(), permanent: true);

    // Data Sources
    Get.put(OfferingLocalDataSource(Get.find()), permanent: true);

    // Repositories
    Get.put<OfferingRepository>(
      OfferingRepositoryImpl(Get.find()),
      permanent: true,
    );

    // Use Cases
    Get.put(GetAllOfferings(Get.find()), permanent: true);
    Get.put(AddOffering(Get.find()), permanent: true);
    Get.put(UpdateOffering(Get.find()), permanent: true);
    Get.put(DeleteOffering(Get.find()), permanent: true);

    // Controllers
    Get.put(OfferingController(
      Get.find(),
      Get.find(),
      Get.find(),
      Get.find(),
    ));
  }
}