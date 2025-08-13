import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'lat_lng_model.dart';

class RouteModel extends Equatable {
  final List<LatLngModel> polylinePoints;
  final String distance;
  final String duration;
  final LatLngModel pickupLocation;
  final LatLngModel destinationLocation;
  const RouteModel({
    required this.polylinePoints,
    required this.distance,
    required this.duration,
    required this.pickupLocation,
    required this.destinationLocation,
  });

  RouteModel copyWith({
    List<LatLngModel>? polylinePoints,
    String? distance,
    String? duration,
    LatLngModel? pickupLocation,
    LatLngModel? destinationLocation,
  }) {
    return RouteModel(
      polylinePoints: polylinePoints ?? this.polylinePoints,
      distance: distance ?? this.distance,
      duration: duration ?? this.duration,
      pickupLocation: pickupLocation ?? this.pickupLocation,
      destinationLocation: destinationLocation ?? this.destinationLocation,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'polylinePoints': polylinePoints.map((x) => x.toMap()).toList(),
      'distance': distance,
      'duration': duration,
      'pickupLocation': pickupLocation.toMap(),
      'destinationLocation': destinationLocation.toMap(),
    };
  }

  factory RouteModel.fromMap(Map<String, dynamic> map) {
    return RouteModel(
      polylinePoints: List<LatLngModel>.from(
        map['polylinePoints']?.map((x) => LatLngModel.fromMap(x)) ?? const [],
      ),
      distance: map['distance'] ?? '',
      duration: map['duration'] ?? '',
      pickupLocation: LatLngModel.fromMap(map['pickupLocation']),
      destinationLocation: LatLngModel.fromMap(map['destinationLocation']),
    );
  }

  String toJson() => json.encode(toMap());

  factory RouteModel.fromJson(String source) =>
      RouteModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'RouteModel(polylinePoints: $polylinePoints, distance: $distance, duration: $duration, pickupLocation: $pickupLocation, destinationLocation: $destinationLocation)';
  }

  @override
  List<Object> get props {
    return [
      polylinePoints,
      distance,
      duration,
      pickupLocation,
      destinationLocation,
    ];
  }
}
