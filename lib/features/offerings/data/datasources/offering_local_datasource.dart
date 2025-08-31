import '../../../../core/database/database_helper.dart';
import '../models/offering_model.dart';

class OfferingLocalDataSource {
  final DatabaseHelper _databaseHelper;

  OfferingLocalDataSource(this._databaseHelper);

  Future<List<OfferingModel>> getAllOfferings() async {
    final maps = await _databaseHelper.queryAll();
    return maps.map((map) => OfferingModel.fromMap(map)).toList();
  }

  Future<int> addOffering(OfferingModel offering) async {
    final map = offering.toMap();
    map.remove('id');
    return await _databaseHelper.insert(map);
  }

  Future<int> updateOffering(OfferingModel offering) async {
    final map = offering.toMap();
    map.remove('id');
    return await _databaseHelper.update(offering.id!, map);
  }

  Future<int> deleteOffering(int id) async {
    return await _databaseHelper.delete(id);
  }
}