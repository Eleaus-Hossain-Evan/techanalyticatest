import '../../../../core/utils/constant/enums.dart';
import '../entities/trip.dart';
import '../repositories/trip_repository.dart';

/// Use case for getting trips by status
class GetTripsByStatusUseCase {
  const GetTripsByStatusUseCase(this._repository);

  final TripRepository _repository;

  /// Execute the use case
  Future<List<Trip>> call(TripStatus status) {
    return _repository.getTripsByStatus(status);
  }
}
