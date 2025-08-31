import '../entities/offering.dart';

abstract class OfferingRepository {
  Future<List<Offering>> getAllOfferings();
  Future<int> addOffering(Offering offering);
  Future<int> updateOffering(Offering offering);
  Future<int> deleteOffering(int id);
}