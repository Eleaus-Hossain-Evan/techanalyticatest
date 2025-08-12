import 'package:equatable/equatable.dart';

/// Authentication status enum for state management
enum AuthStatus { initial, loading, authenticated, unauthenticated, error }

/// Authentication state containing user and status information
class AuthState extends Equatable {
  const AuthState({this.status = AuthStatus.initial, this.user, this.errorMessage, this.isLoading = false});

  final AuthStatus status;
  final dynamic user; // Will be User entity when authenticated
  final String? errorMessage;
  final bool isLoading;

  @override
  List<Object?> get props => [status, user, errorMessage, isLoading];

  AuthState copyWith({AuthStatus? status, dynamic user, String? errorMessage, bool? isLoading}) {
    return AuthState(
      status: status ?? this.status,
      user: user ?? this.user,
      errorMessage: errorMessage ?? this.errorMessage,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  /// Factory constructors for common states
  factory AuthState.loading() => const AuthState(status: AuthStatus.loading, isLoading: true);

  factory AuthState.authenticated(dynamic user) =>
      AuthState(status: AuthStatus.authenticated, user: user, isLoading: false);

  factory AuthState.unauthenticated() => const AuthState(status: AuthStatus.unauthenticated, isLoading: false);

  factory AuthState.error(String message) =>
      AuthState(status: AuthStatus.error, errorMessage: message, isLoading: false);
}
