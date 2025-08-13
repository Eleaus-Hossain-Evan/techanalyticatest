import '../entities/trip.dart';
import '../repositories/trip_repository.dart';

/// Use case for searching trips
class SearchTripsUseCase {
  const SearchTripsUseCase(this._repository);

  final TripRepository _repository;

  /// Execute the use case
  Future<List<Trip>> call(String query) {
    if (query.trim().isEmpty) {
      return _repository.getAllTrips();
    }
    return _repository.searchTrips(query);
  }
}
