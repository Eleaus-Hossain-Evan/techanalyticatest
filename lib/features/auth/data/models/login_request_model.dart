import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

/// Login request model for authentication
class LoginRequest extends Equatable {
  final String? phone;
  final String? email;
  final String password;

  const LoginRequest({this.phone, this.email, required this.password});

  LoginRequest copyWith({ValueGetter<String?>? phone, ValueGetter<String?>? email, String? password}) {
    return LoginRequest(
      phone: phone != null ? phone() : this.phone,
      email: email != null ? email() : this.email,
      password: password ?? this.password,
    );
  }

  Map<String, dynamic> toMap() {
    return {'phone': phone, 'email': email, 'password': password};
  }

  factory LoginRequest.fromMap(Map<String, dynamic> map) {
    return LoginRequest(phone: map['phone'], email: map['email'], password: map['password'] ?? '');
  }

  String toJson() => json.encode(toMap());

  factory LoginRequest.fromJson(String source) => LoginRequest.fromMap(json.decode(source));

  @override
  String toString() => 'LoginRequest(phone: $phone, email: $email, password: $password)';

  @override
  List<Object?> get props => [phone, email, password];
}

