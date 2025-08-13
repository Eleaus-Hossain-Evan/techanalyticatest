import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/datasources/google_directions_datasource.dart';
import '../../data/repositories/map_repository_impl.dart';
import '../../domain/repositories/map_repository.dart';

part 'map_providers.g.dart';

@riverpod
String googleMapsApiKey(Ref ref) {
  return 'AIzaSyA0y82hvYQpAYdusasMnFiQOgy-D5rPYWA'; // Replace with your actual API key
}

@riverpod
GoogleDirectionsDataSource googleDirectionsDataSource(Ref ref) {
  return GoogleDirectionsDataSourceImpl(
    dio: Dio(),
    apiKey: ref.read(googleMapsApiKeyProvider),
  );
}

@riverpod
MapRepository mapRepository(Ref ref) {
  return MapRepositoryImpl(ref.read(googleDirectionsDataSourceProvider));
}
