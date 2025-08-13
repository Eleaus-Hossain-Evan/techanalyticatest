import '../../data/models/route_request.dart';
import '../entities/route_model.dart';

abstract class MapRepository {
  Future<RouteModel> getRoute(RouteRequest request);
}
