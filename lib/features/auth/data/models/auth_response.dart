import 'package:equatable/equatable.dart';

/// Authentication response model
class AuthResponse extends Equatable {
  const AuthResponse({required this.success, required this.message, this.user, this.accessToken, this.refreshToken});

  final bool success;
  final String message;
  final Map<String, dynamic>? user;
  final String? accessToken;
  final String? refreshToken;

  @override
  List<Object?> get props => [success, message, user, accessToken, refreshToken];

  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    return AuthResponse(
      success: json['success'] as bool,
      message: json['message'] as String,
      user: json['user'] as Map<String, dynamic>?,
      accessToken: json['access_token'] as String?,
      refreshToken: json['refresh_token'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'user': user,
      'access_token': accessToken,
      'refresh_token': refreshToken,
    };
  }
}
