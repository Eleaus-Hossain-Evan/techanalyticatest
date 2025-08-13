import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/core.dart';
import '../../domain/entities/lat_lng_model.dart';
import '../../domain/entities/route_model.dart';
import '../providers/map_notifier.dart';

class ReusableMapWidget extends HookConsumerWidget {
  final LatLngModel pickupLocation;
  final LatLngModel destinationLocation;
  final double height;
  final double width;
  final String? mapId;
  final VoidCallback? onRouteLoaded;
  final Function(String error)? onError;
  final EdgeInsetsGeometry? margin;
  final BorderRadius? borderRadius;

  const ReusableMapWidget({
    super.key,
    required this.pickupLocation,
    required this.destinationLocation,
    required this.height,
    required this.width,
    this.mapId,
    this.onRouteLoaded,
    this.onError,
    this.margin,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mapIdentifier =
        mapId ??
        'default_map_${pickupLocation.hashCode}_${destinationLocation.hashCode}';
    final mapController = useState<GoogleMapController?>(null);
    final asyncValue = ref.watch(mapAsyncNotifierProvider(mapIdentifier));
    final notifier = ref.read(mapAsyncNotifierProvider(mapIdentifier).notifier);

    // Load route when widget is built or locations change
    useEffect(() {
      print(
        '*********************************\nLoading route from ${pickupLocation.toJson()} to ${destinationLocation.toJson()}',
      );
      WidgetsBinding.instance.addPostFrameCallback((_) {
        notifier.loadRoute(
          pickup: pickupLocation,
          destination: destinationLocation,
        );
      });
      return null;
    }, [pickupLocation, destinationLocation]);

    // Handle state changes with callbacks
    useEffect(() {
      asyncValue.when(
        data: (route) {
          if (route != null) {
            onRouteLoaded?.call();
          }
        },
        error: (error, stackTrace) {
          onError?.call(error.toString());
        },
        loading: () {
          // Loading state, no callback needed
        },
      );
      return null;
    }, [asyncValue]);

    ref.listen(mapAsyncNotifierProvider(mapIdentifier), (previous, next) {
      if (next.hasError) {
        onError?.call(next.error.toString());
      } else if (next.hasValue) {
        onRouteLoaded?.call();
        final bounds = _calculateBounds([
          next.value!.pickupLocation,
          next.value!.destinationLocation,
        ]);
        mapController.value?.animateCamera(
          CameraUpdate.newLatLngBounds(bounds, 10),
        );
      }
    });

    return AbsorbPointer(
      child: Container(
        height: height,
        width: width,
        margin: margin,
        decoration: BoxDecoration(
          borderRadius: borderRadius ?? BorderRadius.circular(0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: borderRadius ?? BorderRadius.circular(0),
          child: Stack(
            children: [
              GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: LatLng(
                    pickupLocation.latitude,
                    pickupLocation.longitude,
                  ),
                  zoom: 12,
                ),
                onMapCreated: (GoogleMapController controller) {
                  mapController.value = controller;
                },
                markers: _buildMarkers(asyncValue),
                polylines: _buildPolylines(asyncValue),
                myLocationEnabled: false,
                myLocationButtonEnabled: false,
                zoomControlsEnabled: false,
                mapToolbarEnabled: false,
              ),
              _buildLoadingOverlay(notifier, asyncValue),
              // _buildRouteInfo(asyncValue),
            ],
          ),
        ),
      ),
    );
  }

  Set<Marker> _buildMarkers(AsyncValue<RouteModel?> asyncValue) {
    return asyncValue.when(
      data: (route) {
        if (route != null) {
          return {
            Marker(
              markerId: const MarkerId('pickup'),
              position: LatLng(
                route.pickupLocation.latitude,
                route.pickupLocation.longitude,
              ),
              icon: BitmapDescriptor.defaultMarkerWithHue(
                BitmapDescriptor.hueGreen,
              ),
              infoWindow: const InfoWindow(title: 'Pickup Location'),
            ),
            Marker(
              markerId: const MarkerId('destination'),
              position: LatLng(
                route.destinationLocation.latitude,
                route.destinationLocation.longitude,
              ),
              icon: BitmapDescriptor.defaultMarkerWithHue(
                BitmapDescriptor.hueRed,
              ),
              infoWindow: const InfoWindow(title: 'Destination'),
            ),
          };
        }
        return _getDefaultMarkers();
      },
      loading: () => _getDefaultMarkers(),
      error: (_, __) => _getDefaultMarkers(),
    );
  }

  Set<Marker> _getDefaultMarkers() {
    return {
      Marker(
        markerId: const MarkerId('pickup'),
        position: LatLng(pickupLocation.latitude, pickupLocation.longitude),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
        infoWindow: const InfoWindow(title: 'Pickup Location'),
      ),
      Marker(
        markerId: const MarkerId('destination'),
        position: LatLng(
          destinationLocation.latitude,
          destinationLocation.longitude,
        ),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
        infoWindow: const InfoWindow(title: 'Destination'),
      ),
    };
  }

  Set<Polyline> _buildPolylines(AsyncValue<RouteModel?> asyncValue) {
    return asyncValue.when(
      data: (route) {
        if (route != null) {
          return {
            Polyline(
              polylineId: const PolylineId('route'),
              points: route.polylinePoints
                  .map((point) => LatLng(point.latitude, point.longitude))
                  .toList(),
              color: AppColors.primary,
              width: 4,
              patterns: [],
            ),
          };
        }
        return {};
      },
      loading: () => {},
      error: (_, __) => {},
    );
  }

  Widget _buildLoadingOverlay(
    MapAsyncNotifier notifier,
    AsyncValue<RouteModel?> asyncValue,
  ) {
    return asyncValue.when(
      data: (_) => const SizedBox.shrink(),
      loading: () => Container(
        color: Colors.black.withOpacity(0.3),
        child: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
              SizedBox(height: 16),
              Text(
                'Loading route...',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
      error: (error, stackTrace) => Container(
        color: Colors.red.withOpacity(0.1),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error, color: Colors.red, size: 48),
              const SizedBox(height: 16),
              Text(
                'Error loading route',
                style: TextStyle(
                  color: Colors.red[800],
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  error.toString(),
                  textAlign: TextAlign.center,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: Colors.red[600], fontSize: 12),
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: () {
                  // Retry loading

                  notifier.loadRoute(
                    pickup: pickupLocation,
                    destination: destinationLocation,
                  );
                },
                icon: const Icon(Icons.refresh),
                label: const Text('Retry'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRouteInfo(AsyncValue<RouteModel?> asyncValue) {
    return asyncValue.when(
      data: (route) {
        if (route != null) {
          return Positioned(
            top: 16,
            left: 16,
            right: 16,
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildInfoItem(Icons.straighten, 'Distance', route.distance),
                  Container(height: 30, width: 1, color: Colors.grey[300]),
                  _buildInfoItem(Icons.access_time, 'Duration', route.duration),
                ],
              ),
            ),
          );
        }
        return const SizedBox.shrink();
      },
      loading: () => const SizedBox.shrink(),
      error: (_, __) => const SizedBox.shrink(),
    );
  }

  Widget _buildInfoItem(IconData icon, String label, String value) {
    return Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: Colors.grey[600]),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  void _fitMapToRoute(GoogleMapController controller, RouteModel route) {
    final bounds = _calculateBounds([
      route.pickupLocation,
      route.destinationLocation,
    ]);

    controller.animateCamera(CameraUpdate.newLatLngBounds(bounds, 100.0));
  }

  LatLngBounds _calculateBounds(List<LatLngModel> points) {
    double minLat = points.first.latitude;
    double maxLat = points.first.latitude;
    double minLng = points.first.longitude;
    double maxLng = points.first.longitude;

    for (final point in points) {
      minLat = minLat < point.latitude ? minLat : point.latitude;
      maxLat = maxLat > point.latitude ? maxLat : point.latitude;
      minLng = minLng < point.longitude ? minLng : point.longitude;
      maxLng = maxLng > point.longitude ? maxLng : point.longitude;
    }

    return LatLngBounds(
      southwest: LatLng(minLat, minLng),
      northeast: LatLng(maxLat, maxLng),
    );
  }
}
