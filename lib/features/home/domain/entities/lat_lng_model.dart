import 'dart:convert';

import 'package:equatable/equatable.dart';

class LatLngModel extends Equatable {
  final double latitude;
  final double longitude;
  const LatLngModel({required this.latitude, required this.longitude});

  LatLngModel copyWith({double? latitude, double? longitude}) {
    return LatLngModel(
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
    );
  }

  Map<String, dynamic> toMap() {
    return {'latitude': latitude, 'longitude': longitude};
  }

  factory LatLngModel.fromMap(Map<String, dynamic> map) {
    return LatLngModel(
      latitude: map['latitude']?.toDouble() ?? 0.0,
      longitude: map['longitude']?.toDouble() ?? 0.0,
    );
  }

  String toJson() => json.encode(toMap());

  factory LatLngModel.fromJson(String source) =>
      LatLngModel.fromMap(json.decode(source));

  @override
  String toString() =>
      'LatLngModel(latitude: $latitude, longitude: $longitude)';

  @override
  List<Object> get props => [latitude, longitude];
}
