import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/utils/constant/enums.dart';
import '../../data/repositories/mock_trip_repository.dart';
import '../../domain/entities/trip.dart';
import '../../domain/repositories/trip_repository.dart';
import '../../domain/usecases/get_trips_by_status_usecase.dart';
import '../../domain/usecases/search_trips_usecase.dart';

part 'trip_providers.g.dart';

/// Trip repository provider
@riverpod
TripRepository tripRepository(Ref ref) {
  return MockTripRepository();
}

/// Get trips by status use case provider
@riverpod
GetTripsByStatusUseCase getTripsByStatusUseCase(Ref ref) {
  return GetTripsByStatusUseCase(ref.watch(tripRepositoryProvider));
}

/// Search trips use case provider
@riverpod
SearchTripsUseCase searchTripsUseCase(Ref ref) {
  return SearchTripsUseCase(ref.watch(tripRepositoryProvider));
}

/// Provider for trips by status
@riverpod
Future<List<Trip>> tripsByStatus(Ref ref) {
  final status = ref.watch(selectedTripTabProvider);
  final useCase = ref.watch(getTripsByStatusUseCaseProvider);
  return useCase(status);
}

/// Provider for searching trips
@riverpod
Future<List<Trip>> searchTrips(Ref ref) {
  final query = ref.watch(searchQueryProvider);
  final useCase = ref.watch(searchTripsUseCaseProvider);
  return useCase(query);
}

/// State provider for current selected tab
@riverpod
class SelectedTripTab extends _$SelectedTripTab {
  @override
  TripStatus build() => TripStatus.upcoming;

  void selectTab(TripStatus status) {
    state = status;
  }
}

/// State provider for search query
@riverpod
class SearchQuery extends _$SearchQuery {
  @override
  String build() => '';

  void updateQuery(String query) {
    state = query;
  }

  void clearQuery() {
    state = '';
  }
}

/// Provider for the combined trips
@riverpod
Future<List<Trip>> combinedTrips(Ref ref) async {
  final searchQuery = ref.watch(searchQueryProvider);
  final tripsAsync = searchQuery.isEmpty
      ? await ref.watch(tripsByStatusProvider.future)
      : await ref.watch(searchTripsProvider.future);

  return tripsAsync;
}

/// Provider for getting a trip by ID
@riverpod
Future<Trip?> tripById(Ref ref, String tripId) async {
  final repository = ref.watch(tripRepositoryProvider);
  return repository.getTripById(tripId);
}
