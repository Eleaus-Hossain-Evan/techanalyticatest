import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/models/login_request_model.dart';
import '../../domain/entities/user.dart';
import 'auth_providers.dart';

part 'auth_state_provider.g.dart';

@riverpod
class AuthNotifier extends _$AuthNotifier {
  @override
  Future<bool> build() {
    return Future.value(false);
  }

  /// Login with email or phone and password
  Future<void> login({String? email, String? phone, required String password}) async {
    if (!ref.mounted) return;

    state = AsyncLoading();

    final request = LoginRequest(password: password, email: email, phone: phone);

    // Perform login
    final repository = ref.read(authRepositoryProvider);
    try {
      await repository.login(request);

      if (ref.mounted) {
        state = AsyncData(true);
      }
    } catch (e, st) {
      if (ref.mounted) {
        state = AsyncError(e, st);
      }
    }
  }

  /// Logout current user
  Future<void> logout() async {
    try {
      // Check if ref is still mounted before using it
      if (!ref.mounted) return;

      state = AsyncLoading();

      final repository = ref.read(authRepositoryProvider);
      await repository.logout();

      // Check again after async operation
      if (ref.mounted) {
        state = AsyncData(false);
      }
    } catch (e, st) {
      // Check if ref is still mounted before setting error state
      if (ref.mounted) {
        state = AsyncError(e, st);
      }
    }
  }
}

@riverpod
Future<bool> isAuthenticated(Ref ref) async {
  final authState = ref.read(authRepositoryProvider);
  return await authState.isAuthenticated();
}

@riverpod
FutureOr<User?> currentUser(Ref ref) async {
  final authState = ref.read(authRepositoryProvider);
  return await authState.getUser();
}
