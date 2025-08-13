import 'package:dio/dio.dart';

import '../../../../core/core.dart';
import '../../domain/entities/lat_lng_model.dart';
import '../../domain/entities/route_model.dart';

abstract class GoogleDirectionsDataSource {
  Future<RouteModel> getDirections({
    required LatLngModel pickup,
    required LatLngModel destination,
  });
}

class GoogleDirectionsDataSourceImpl implements GoogleDirectionsDataSource {
  final Dio _dio;
  final String _apiKey;

  GoogleDirectionsDataSourceImpl({required Dio dio, required String apiKey})
    : _dio = dio,
      _apiKey = apiKey;

  @override
  Future<RouteModel> getDirections({
    required LatLngModel pickup,
    required LatLngModel destination,
  }) async {
    try {
      final response = await _dio.get(
        'https://maps.googleapis.com/maps/api/directions/json',
        queryParameters: {
          'origin': '${pickup.latitude},${pickup.longitude}',
          'destination': '${destination.latitude},${destination.longitude}',
          'key': _apiKey,
        },
      );

      if (response.data['status'] != 'OK') {
        throw Exception('Failed to get directions: ${response.data['status']}');
      }

      final route = response.data['routes'][0];
      final leg = route['legs'][0];

      // Decode polyline points
      final polylinePoints = _decodePolyline(
        route['overview_polyline']['points'],
      );

      return RouteModel(
        polylinePoints: polylinePoints,
        distance: leg['distance']['text'],
        duration: leg['duration']['text'],
        pickupLocation: pickup,
        destinationLocation: destination,
      );
    } on DioException catch (e) {
      throw AppException('Network error: ${e.message}');
    } catch (e) {
      throw AppException('Failed to get directions: $e');
    }
  }

  List<LatLngModel> _decodePolyline(String encoded) {
    List<LatLngModel> polylinePoints = [];
    int index = 0;
    int len = encoded.length;
    int lat = 0;
    int lng = 0;

    while (index < len) {
      int b;
      int shift = 0;
      int result = 0;

      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);

      int dlat = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lat += dlat;

      shift = 0;
      result = 0;

      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);

      int dlng = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lng += dlng;

      polylinePoints.add(
        LatLngModel(latitude: lat / 1E5, longitude: lng / 1E5),
      );
    }

    return polylinePoints;
  }
}
