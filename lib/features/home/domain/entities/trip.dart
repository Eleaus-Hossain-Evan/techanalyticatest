import 'package:equatable/equatable.dart';

import '../../../../core/utils/constant/enums.dart';

/// Trip entity representing a booking/trip
class Trip extends Equatable {
  const Trip({
    required this.id,
    required this.bookingNumber,
    required this.pickupLocation,
    required this.destinationLocation,
    required this.pickupTime,
    required this.status,
    required this.driverName,
    required this.driverRating,
    required this.vehicleType,
    required this.estimatedFare,
    this.actualFare,
    this.tripType = TripType.regular,
    this.distance,
    this.duration,
    this.driverPhone,
    this.paymentMethod,
    this.receiptUrl,
    this.pickupLatitude,
    this.pickupLongitude,
    this.destinationLatitude,
    this.destinationLongitude,
  });

  final String id;
  final String bookingNumber;
  final String pickupLocation;
  final String destinationLocation;
  final DateTime pickupTime;
  final TripStatus status;
  final String driverName;
  final double driverRating;
  final String vehicleType;
  final double estimatedFare;
  final double? actualFare;
  final TripType tripType;
  final double? distance; // in kilometers
  final Duration? duration;
  final String? driverPhone;
  final String? paymentMethod;
  final String? receiptUrl;
  final double? pickupLatitude;
  final double? pickupLongitude;
  final double? destinationLatitude;
  final double? destinationLongitude;

  /// Get fare to display (actual fare if available, otherwise estimated)
  double get displayFare => actualFare ?? estimatedFare;

  /// Check if trip is in progress
  bool get isInProgress => status == TripStatus.inProgress;

  /// Check if trip is completed
  bool get isCompleted => status == TripStatus.completed;

  /// Check if trip is cancelled
  bool get isCancelled => status == TripStatus.cancelled;

  /// Check if trip is upcoming
  bool get isUpcoming =>
      status == TripStatus.upcoming || status == TripStatus.scheduled;

  /// Check if trip has location coordinates
  bool get hasCoordinates =>
      pickupLatitude != null &&
      pickupLongitude != null &&
      destinationLatitude != null &&
      destinationLongitude != null;

  @override
  List<Object?> get props => [
    id,
    bookingNumber,
    pickupLocation,
    destinationLocation,
    pickupTime,
    status,
    driverName,
    driverRating,
    vehicleType,
    estimatedFare,
    actualFare,
    tripType,
    distance,
    duration,
    driverPhone,
    paymentMethod,
    receiptUrl,
    pickupLatitude,
    pickupLongitude,
    destinationLatitude,
    destinationLongitude,
  ];

  Trip copyWith({
    String? id,
    String? bookingNumber,
    String? pickupLocation,
    String? destinationLocation,
    DateTime? pickupTime,
    TripStatus? status,
    String? driverName,
    double? driverRating,
    String? vehicleType,
    double? estimatedFare,
    double? actualFare,
    TripType? tripType,
    double? distance,
    Duration? duration,
    String? driverPhone,
    String? paymentMethod,
    String? receiptUrl,
    double? pickupLatitude,
    double? pickupLongitude,
    double? destinationLatitude,
    double? destinationLongitude,
  }) {
    return Trip(
      id: id ?? this.id,
      bookingNumber: bookingNumber ?? this.bookingNumber,
      pickupLocation: pickupLocation ?? this.pickupLocation,
      destinationLocation: destinationLocation ?? this.destinationLocation,
      pickupTime: pickupTime ?? this.pickupTime,
      status: status ?? this.status,
      driverName: driverName ?? this.driverName,
      driverRating: driverRating ?? this.driverRating,
      vehicleType: vehicleType ?? this.vehicleType,
      estimatedFare: estimatedFare ?? this.estimatedFare,
      actualFare: actualFare ?? this.actualFare,
      tripType: tripType ?? this.tripType,
      distance: distance ?? this.distance,
      duration: duration ?? this.duration,
      driverPhone: driverPhone ?? this.driverPhone,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      receiptUrl: receiptUrl ?? this.receiptUrl,
      pickupLatitude: pickupLatitude ?? this.pickupLatitude,
      pickupLongitude: pickupLongitude ?? this.pickupLongitude,
      destinationLatitude: destinationLatitude ?? this.destinationLatitude,
      destinationLongitude: destinationLongitude ?? this.destinationLongitude,
    );
  }
}
