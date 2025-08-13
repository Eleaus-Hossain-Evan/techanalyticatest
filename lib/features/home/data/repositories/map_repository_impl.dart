import '../../../../core/core.dart';
import '../../domain/entities/route_model.dart';
import '../../domain/repositories/map_repository.dart';
import '../datasources/google_directions_datasource.dart';
import '../models/route_request.dart';

class MapRepositoryImpl implements MapRepository {
  final GoogleDirectionsDataSource _dataSource;

  MapRepositoryImpl(this._dataSource);

  @override
  Future<RouteModel> getRoute(RouteRequest request) async {
    try {
      return await _dataSource.getDirections(
        pickup: request.pickup,
        destination: request.destination,
      );
    } catch (e) {
      throw AppException('Repository error: $e');
    }
  }
}
