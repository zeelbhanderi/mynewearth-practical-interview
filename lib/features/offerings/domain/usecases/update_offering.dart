import '../entities/offering.dart';
import '../repositories/offering_repository.dart';

class UpdateOffering {
  final OfferingRepository repository;

  UpdateOffering(this.repository);

  Future<int> call(Offering offering) async {
    return await repository.updateOffering(offering);
  }
}