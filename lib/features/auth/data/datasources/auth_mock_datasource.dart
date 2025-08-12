import 'dart:async';
import 'dart:convert';

import '../../../../core/core.dart';
import '../models/login_request_model.dart';
import '../models/user_model.dart';

/// Mock authentication data source
///
/// Provides mock authentication functionality for testing and development.
/// Simulates API responses with realistic delays and data.
class AuthMockDataSource {
  /// Mock user data for testing different scenarios
  static final List<Map<String, dynamic>> _mockUsers = [
    {
      'id': '1',
      'name': 'John Doe',
      'email': 'john@example.com',
      'phone': '+1234567890',
      'profile_image': 'https://example.com/avatar1.jpg',
      'is_email_verified': true,
      'is_phone_verified': true,
      'created_at': '2024-01-15T10:30:00Z',
      'password': 'password123', // In real app, this would be hashed
    },
    {
      'id': '2',
      'name': 'Jane Smith',
      'email': 'jane@example.com',
      'phone': '+1987654321',
      'profile_image': 'https://example.com/avatar2.jpg',
      'is_email_verified': true,
      'is_phone_verified': false,
      'created_at': '2024-02-20T14:45:00Z',
      'password': 'password456',
    },
    {
      'id': '3',
      'name': 'Alex Johnson',
      'email': 'alex@example.com',
      'phone': '+1555666777',
      'profile_image': null,
      'is_email_verified': false,
      'is_phone_verified': true,
      'created_at': '2024-03-10T09:15:00Z',
      'password': 'password789',
    },
    // Demo accounts for easy testing
    {
      'id': '100',
      'name': 'Demo User',
      'email': 'demo@techanalytica.com',
      'phone': '+1234567890',
      'profile_image': null,
      'is_email_verified': true,
      'is_phone_verified': true,
      'created_at': '2024-01-01T00:00:00Z',
      'password': 'demo123',
    },
  ];

  /// Simulate network delay for realistic testing
  static const Duration _networkDelay = Duration(milliseconds: 1500);

  /// Login with email or phone
  ///
  /// Validates credentials against mock user data.
  /// Returns user data and auth tokens on success.
  /// Throws exception on invalid credentials.
  Future<Map<String, dynamic>> login(LoginRequest request) async {
    // Simulate network delay
    await Future.delayed(_networkDelay);

    // Find user by identifier (email or phone)
    final foundUser = _mockUsers
        .where(
          (user) =>
              (request.email != null && user['email'] == request.email) ||
              (request.phone != null && user['phone'] == request.phone),
        )
        .firstOrNull;

    // Check if user exists
    if (foundUser == null) {
      throw AppException('User not found. Please check your credentials.');
    }

    // Validate password
    if (foundUser['password'] != request.password) {
      throw AppException('Invalid password. Please try again.');
    }

    // Remove password from response (security)
    final userResponse = Map<String, dynamic>.from(foundUser);
    userResponse.remove('password');

    // Generate mock tokens
    final accessToken = _generateMockToken(foundUser);

    return {'success': true, 'message': 'Login successful', 'user': userResponse, 'access_token': accessToken};
  }

  /// Get user by ID (for session restoration)
  Future<UserModel?> getUser(String token) async {
    await Future.delayed(const Duration(milliseconds: 500));

    // get user ID from token
    final userId = _getUserIdFromToken(token);

    try {
      final userData = _mockUsers.firstWhere((user) => user['id'] == userId);
      final userMap = Map<String, dynamic>.from(userData);
      userMap.remove('password');
      return UserModel.fromJson(userMap);
    } catch (e) {
      return null;
    }
  }

  /// Generate mock JWT-like token
  String _generateMockToken(Map<String, dynamic> user) {
    return base64Encode(utf8.encode(jsonEncode(user)));
  }

  String _getUserIdFromToken(String token) {
    // Decode the token to extract user ID
    try {
      final decoded = utf8.decode(base64Decode(token));
      final userMap = jsonDecode(decoded) as Map<String, dynamic>;
      return userMap['id'] as String;
    } catch (e) {
      throw AppException('Invalid token format');
    }
  }
}
