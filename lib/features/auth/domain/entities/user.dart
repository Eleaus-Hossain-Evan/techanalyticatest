import 'package:equatable/equatable.dart';

/// User entity representing authenticated user data
class User extends Equatable {
  const User({
    required this.id,
    required this.name,
    required this.email,
    this.phone,
    this.profileImage,
    required this.isEmailVerified,
    required this.isPhoneVerified,
    required this.createdAt,
  });

  final String id;
  final String name;
  final String email;
  final String? phone;
  final String? profileImage;
  final bool isEmailVerified;
  final bool isPhoneVerified;
  final DateTime createdAt;

  @override
  List<Object?> get props => [id, name, email, phone, profileImage, isEmailVerified, isPhoneVerified, createdAt];

  User copyWith({
    String? id,
    String? name,
    String? email,
    String? phone,
    String? profileImage,
    bool? isEmailVerified,
    bool? isPhoneVerified,
    DateTime? createdAt,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      profileImage: profileImage ?? this.profileImage,
      isEmailVerified: isEmailVerified ?? this.isEmailVerified,
      isPhoneVerified: isPhoneVerified ?? this.isPhoneVerified,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
