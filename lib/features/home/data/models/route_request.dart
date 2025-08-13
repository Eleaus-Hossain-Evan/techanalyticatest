import 'package:equatable/equatable.dart';

import '../../domain/entities/lat_lng_model.dart';

class RouteRequest extends Equatable {
  final LatLngModel pickup;
  final LatLngModel destination;

  const RouteRequest({required this.pickup, required this.destination});

  @override
  List<Object?> get props => [pickup, destination];

  @override
  String toString() =>
      'RouteRequest(pickup: $pickup, destination: $destination)';
}
