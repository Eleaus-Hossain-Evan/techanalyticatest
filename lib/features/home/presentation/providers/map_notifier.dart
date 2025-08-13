import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/models/route_request.dart';
import '../../domain/entities/lat_lng_model.dart';
import '../../domain/entities/route_model.dart';
import '../../domain/repositories/map_repository.dart';
import 'map_providers.dart';

part 'map_notifier.g.dart';

@riverpod
class MapAsyncNotifier extends _$MapAsyncNotifier {
  late MapRepository _repository;

  @override
  Future<RouteModel?> build(String identifier) async {
    _repository = ref.read(mapRepositoryProvider);
    return null; // Initial state is null
  }

  Future<void> loadRoute({
    required LatLngModel pickup,
    required LatLngModel destination,
  }) async {
    final request = RouteRequest(pickup: pickup, destination: destination);

    // Set loading state
    state = const AsyncValue.loading();

    // Load route
    state = await AsyncValue.guard(() async {
      return await _repository.getRoute(request);
    });
  }

  void reset() {
    state = const AsyncValue.data(null);
  }

  void clearError() {
    if (state.hasError) {
      state = const AsyncValue.data(null);
    }
  }
}
