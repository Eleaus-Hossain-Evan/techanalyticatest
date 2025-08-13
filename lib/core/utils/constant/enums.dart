import 'package:flutter/material.dart';

enum Gender {
  male('Male'),
  female('Female'),
  ratherNotSay('Rather Not Say');

  final String text;

  const Gender(this.text);
}

/// Trip status enumeration for booking management
enum TripStatus {
  upcoming('Upcoming'),
  completed('Completed'),
  cancelled('Cancelled'),
  scheduled('Scheduled'),
  inProgress('In Progress');

  const TripStatus(this.displayName);

  final String displayName;

  /// Get color for the trip status
  Color get statusColor {
    switch (this) {
      case TripStatus.upcoming:
        return const Color(0xFF4A90E2); // Blue
      case TripStatus.scheduled:
        return const Color(0xFFFFA500); // Orange
      case TripStatus.completed:
        return const Color(0xFF27AE60); // Green
      case TripStatus.cancelled:
        return const Color(0xFFE74C3C); // Red
      case TripStatus.inProgress:
        return const Color(0xFFF39C12); // Orange
    }
  }

  /// Get background color for the trip status
  Color get backgroundColor {
    return statusColor.withOpacity(0.1);
  }
}

/// Trip type enumeration
enum TripType {
  regular('Regular'),
  express('Express'),
  scheduled('Scheduled'),
  longDistance('Long Distance');

  const TripType(this.displayName);

  final String displayName;
}
