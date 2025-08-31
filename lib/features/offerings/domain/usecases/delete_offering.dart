import '../repositories/offering_repository.dart';

class DeleteOffering {
  final OfferingRepository repository;

  DeleteOffering(this.repository);

  Future<int> call(int id) async {
    return await repository.deleteOffering(id);
  }
}