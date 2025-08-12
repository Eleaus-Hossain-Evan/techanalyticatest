import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/user_model.dart';

/// Local authentication data source
///
/// Handles persistent storage of authentication data using SharedPreferences.
/// Manages user session data, tokens, and authentication state.
class AuthLocalDataSource {
  static const String _userKey = 'auth_user';
  static const String _accessTokenKey = 'auth_access_token';
  static const String _refreshTokenKey = 'auth_refresh_token';
  static const String _isAuthenticatedKey = 'auth_is_authenticated';

  /// Store user data locally
  Future<void> storeUser(UserModel user) async {
    final prefs = await SharedPreferences.getInstance();
    final userJson = jsonEncode(user.toJson());
    await prefs.setString(_userKey, userJson);
    await prefs.setBool(_isAuthenticatedKey, true);
    print('***************************\nUser stored: $userJson\n***************************');
  }

  /// Get stored user data
  Future<UserModel?> getStoredUser() async {
    final prefs = await SharedPreferences.getInstance();
    final userJson = prefs.getString(_userKey);

    if (userJson == null) return null;

    try {
      final userMap = jsonDecode(userJson) as Map<String, dynamic>;
      return UserModel.fromJson(userMap);
    } catch (e) {
      // Clear corrupted data
      await clearUserData();
      return null;
    }
  }

  /// Store access token
  Future<void> storeAccessToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_accessTokenKey, token);
    print('***************************\nAccess token stored: $token\n***************************');
  }

  /// Get stored access token
  Future<String?> getAccessToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_accessTokenKey);
  }

  /// Check if user is authenticated
  Future<bool> isAuthenticated() async {
    final prefs = await SharedPreferences.getInstance();
    final isAuth = prefs.getBool(_isAuthenticatedKey) ?? false;
    final user = await getStoredUser();
    final token = await getAccessToken();

    // User is authenticated if flag is true, user data exists, and token exists
    return isAuth && user != null && token != null;
  }

  /// Clear all authentication data
  Future<void> clearUserData() async {
    final prefs = await SharedPreferences.getInstance();
    await Future.wait([
      prefs.remove(_userKey),
      prefs.remove(_accessTokenKey),
      prefs.remove(_refreshTokenKey),
      prefs.setBool(_isAuthenticatedKey, false),
    ]);
    print('***************************\nUser data cleared\n***************************');
  }

  /// Store complete authentication data
  Future<void> storeAuthData({required UserModel user, String? accessToken}) async {
    await Future.wait([storeUser(user), if (accessToken != null) storeAccessToken(accessToken)]);
  }

  /// Get all stored authentication data
  Future<Map<String, dynamic>> getAuthData() async {
    final user = await getStoredUser();
    final accessToken = await getAccessToken();
    final isAuth = await isAuthenticated();

    return {'user': user, 'access_token': accessToken, 'is_authenticated': isAuth};
  }
}
