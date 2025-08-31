import '../entities/offering.dart';
import '../repositories/offering_repository.dart';

class AddOffering {
  final OfferingRepository repository;

  AddOffering(this.repository);

  Future<int> call(Offering offering) async {
    return await repository.addOffering(offering);
  }
}