import '../../data/models/login_request_model.dart';
import '../entities/user.dart';

abstract class AuthRepository {
  Future<void> login(LoginRequest request);
  Future<void> logout();
  Future<bool> isAuthenticated();
  Future<User?> getUser();
}
