import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_local_datasource.dart';
import '../datasources/auth_mock_datasource.dart';
import '../models/login_request_model.dart';
import '../models/user_model.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl({required this.mockDataSource, required this.localDataSource});

  final AuthMockDataSource mockDataSource;
  final AuthLocalDataSource localDataSource;

  @override
  Future<void> login(LoginRequest request) async {
    try {
      final authResponse = await mockDataSource.login(request);

      if (!authResponse['success']) {
        throw Exception(authResponse['message'] ?? 'Login failed');
      }

      // Convert user data to model
      final userModel = UserModel.fromJson(authResponse['user']);

      // Store authentication data locally
      await localDataSource.storeAuthData(user: userModel, accessToken: authResponse['access_token']);

      return;
    } catch (e) {
      // Ensure local data is cleared on login failure
      await localDataSource.clearUserData();

      rethrow;
    }
  }

  @override
  Future<void> logout() async {
    try {
      await localDataSource.clearUserData();
      return;
    } catch (e) {
      await localDataSource.clearUserData();
      rethrow;
    }
  }

  @override
  Future<bool> isAuthenticated() async {
    try {
      return await localDataSource.isAuthenticated();
    } catch (e) {
      return false;
    }
  }

  @override
  Future<User?> getUser() async {
    try {
      final token = await localDataSource.getAccessToken();
      if (token == null && token!.isEmpty) return null;

      final model = await mockDataSource.getUser(token);
      return model?.toEntity();
    } catch (e) {
      rethrow;
    }
  }
}
