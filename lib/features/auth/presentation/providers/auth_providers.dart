import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/datasources/auth_local_datasource.dart';
import '../../data/datasources/auth_mock_datasource.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../../domain/repositories/auth_repository.dart';

part 'auth_providers.g.dart';

/// Provider for auth mock data source
@riverpod
AuthMockDataSource authMockDataSource(Ref ref) {
  return AuthMockDataSource();
}

/// Provider for auth local data source
@riverpod
AuthLocalDataSource authLocalDataSource(Ref ref) {
  return AuthLocalDataSource();
}

/// Provider for auth repository
@riverpod
AuthRepository authRepository(Ref ref) {
  return AuthRepositoryImpl(
    mockDataSource: ref.watch(authMockDataSourceProvider),
    localDataSource: ref.watch(authLocalDataSourceProvider),
  );
}
