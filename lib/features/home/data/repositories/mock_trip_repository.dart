import '../../../../core/utils/constant/enums.dart';
import '../../domain/entities/trip.dart';
import '../../domain/repositories/trip_repository.dart';

/// Mock implementation of TripRepository for demo purposes
class MockTripRepository implements TripRepository {
  /// Mock trips data for demonstration
  static final List<Trip> _mockTrips = [
    // Upcoming Trips
    Trip(
      id: '1',
      bookingNumber: 'BK001',
      pickupLocation: 'Dhanmondi 27, Dhaka',
      destinationLocation: 'Gulshan 2, Dhaka',
      pickupTime: DateTime.now().add(const Duration(hours: 2)),
      status: TripStatus.upcoming,
      driverName: 'Ahmed Rahman',
      driverRating: 4.8,
      vehicleType: 'Toyota Corolla',
      estimatedFare: 250.0,
      tripType: TripType.regular,
      distance: 8.5,
      duration: const Duration(minutes: 25),
      driverPhone: '+8801712345678',
      paymentMethod: 'Cash',
      pickupLatitude: 23.7465,
      pickupLongitude: 90.3763,
      destinationLatitude: 23.7806,
      destinationLongitude: 90.4193,
    ),
    Trip(
      id: '2',
      bookingNumber: 'BK002',
      pickupLocation: 'Uttara Sector 10, Dhaka',
      destinationLocation: 'Motijheel, Dhaka',
      pickupTime: DateTime.now().add(const Duration(hours: 5)),
      status: TripStatus.scheduled,
      driverName: 'Rafiq Islam',
      driverRating: 4.6,
      vehicleType: 'Honda City',
      estimatedFare: 420.0,
      tripType: TripType.express,
      distance: 15.2,
      duration: const Duration(minutes: 45),
      driverPhone: '+8801812345679',
      paymentMethod: 'Card',
      pickupLatitude: 23.8759,
      pickupLongitude: 90.3795,
      destinationLatitude: 23.7330,
      destinationLongitude: 90.4172,
    ),

    // Completed Trips
    Trip(
      id: '3',
      bookingNumber: 'BK003',
      pickupLocation: 'Banani, Dhaka',
      destinationLocation: 'Old Dhaka',
      pickupTime: DateTime.now().subtract(const Duration(days: 2)),
      status: TripStatus.completed,
      driverName: 'Karim Uddin',
      driverRating: 4.9,
      vehicleType: 'Nissan Sunny',
      estimatedFare: 300.0,
      actualFare: 285.0,
      tripType: TripType.regular,
      distance: 12.0,
      duration: const Duration(minutes: 38),
      driverPhone: '+8801912345680',
      paymentMethod: 'Cash',
      receiptUrl: 'https://example.com/receipt/BK003',
      pickupLatitude: 23.7936,
      pickupLongitude: 90.4066,
      destinationLatitude: 23.7104,
      destinationLongitude: 90.4074,
    ),
    Trip(
      id: '4',
      bookingNumber: 'BK004',
      pickupLocation: 'Mirpur 1, Dhaka',
      destinationLocation: 'TSC, Dhaka University',
      pickupTime: DateTime.now().subtract(const Duration(days: 5)),
      status: TripStatus.completed,
      driverName: 'Shahid Hasan',
      driverRating: 4.7,
      vehicleType: 'Toyota Axio',
      estimatedFare: 180.0,
      actualFare: 175.0,
      tripType: TripType.regular,
      distance: 6.8,
      duration: const Duration(minutes: 22),
      driverPhone: '+8801612345681',
      paymentMethod: 'Mobile Banking',
      receiptUrl: 'https://example.com/receipt/BK004',
      pickupLatitude: 23.7956,
      pickupLongitude: 90.3537,
      destinationLatitude: 23.7285,
      destinationLongitude: 90.3906,
    ),

    // Cancelled Trips
    Trip(
      id: '5',
      bookingNumber: 'BK005',
      pickupLocation: 'Wari, Dhaka',
      destinationLocation: 'Tejgaon, Dhaka',
      pickupTime: DateTime.now().subtract(const Duration(days: 1)),
      status: TripStatus.cancelled,
      driverName: 'Nasir Ahmed',
      driverRating: 4.5,
      vehicleType: 'Honda Civic',
      estimatedFare: 200.0,
      tripType: TripType.regular,
      distance: 7.2,
      duration: const Duration(minutes: 28),
      driverPhone: '+8801512345682',
      paymentMethod: 'Card',
      pickupLatitude: 23.7197,
      pickupLongitude: 90.4203,
      destinationLatitude: 23.7539,
      destinationLongitude: 90.3923,
    ),
  ];

  @override
  Future<List<Trip>> getAllTrips() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));
    return List.from(_mockTrips);
  }

  @override
  Future<List<Trip>> getTripsByStatus(TripStatus status) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 300));

    return _mockTrips.where((trip) {
      switch (status) {
        case TripStatus.upcoming:
          return trip.isUpcoming;
        case TripStatus.completed:
          return trip.isCompleted;
        case TripStatus.cancelled:
          return trip.isCancelled;
        case TripStatus.scheduled:
          return trip.status == TripStatus.scheduled;
        case TripStatus.inProgress:
          return trip.isInProgress;
      }
    }).toList();
  }

  @override
  Future<List<Trip>> searchTrips(String query) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 400));

    final lowercaseQuery = query.toLowerCase();

    return _mockTrips.where((trip) {
      return trip.bookingNumber.toLowerCase().contains(lowercaseQuery) ||
          trip.pickupLocation.toLowerCase().contains(lowercaseQuery) ||
          trip.destinationLocation.toLowerCase().contains(lowercaseQuery) ||
          trip.driverName.toLowerCase().contains(lowercaseQuery);
    }).toList();
  }

  @override
  Future<Trip?> getTripById(String tripId) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 200));

    try {
      return _mockTrips.firstWhere((trip) => trip.id == tripId);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<void> updateTripStatus(String tripId, TripStatus newStatus) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 300));

    final tripIndex = _mockTrips.indexWhere((trip) => trip.id == tripId);
    if (tripIndex != -1) {
      _mockTrips[tripIndex] = _mockTrips[tripIndex].copyWith(status: newStatus);
    }
  }
}
