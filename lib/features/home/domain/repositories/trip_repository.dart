import '../../../../core/utils/constant/enums.dart';
import '../entities/trip.dart';

/// Repository interface for trip data operations
abstract class TripRepository {
  /// Get all trips for the current user
  Future<List<Trip>> getAllTrips();

  /// Get trips filtered by status
  Future<List<Trip>> getTripsByStatus(TripStatus status);

  /// Search trips by booking number or location
  Future<List<Trip>> searchTrips(String query);

  /// Get trip by ID
  Future<Trip?> getTripById(String tripId);

  /// Update trip status (for demo purposes)
  Future<void> updateTripStatus(String tripId, TripStatus newStatus);
}
