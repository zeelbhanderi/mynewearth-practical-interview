import '../../domain/entities/offering.dart';
import '../../domain/repositories/offering_repository.dart';
import '../datasources/offering_local_datasource.dart';
import '../models/offering_model.dart';

class OfferingRepositoryImpl implements OfferingRepository {
  final OfferingLocalDataSource localDataSource;

  OfferingRepositoryImpl(this.localDataSource);

  @override
  Future<List<Offering>> getAllOfferings() async {
    return await localDataSource.getAllOfferings();
  }

  @override
  Future<int> addOffering(Offering offering) async {
    final model = OfferingModel(
      practitionerName: offering.practitionerName,
      title: offering.title,
      description: offering.description,
      category: offering.category,
      duration: offering.duration,
      type: offering.type,
      price: offering.price,
      createdAt: offering.createdAt,
    );
    return await localDataSource.addOffering(model);
  }

  @override
  Future<int> updateOffering(Offering offering) async {
    final model = OfferingModel(
      id: offering.id,
      practitionerName: offering.practitionerName,
      title: offering.title,
      description: offering.description,
      category: offering.category,
      duration: offering.duration,
      type: offering.type,
      price: offering.price,
      createdAt: offering.createdAt,
    );
    return await localDataSource.updateOffering(model);
  }

  @override
  Future<int> deleteOffering(int id) async {
    return await localDataSource.deleteOffering(id);
  }
}