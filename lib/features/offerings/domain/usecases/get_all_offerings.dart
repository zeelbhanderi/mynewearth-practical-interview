import '../entities/offering.dart';
import '../repositories/offering_repository.dart';

class GetAllOfferings {
  final OfferingRepository repository;

  GetAllOfferings(this.repository);

  Future<List<Offering>> call() async {
    return await repository.getAllOfferings();
  }
}