# TechAnalytica Test - Flutter Ride Booking App

A comprehensive Flutter mobile application demonstrating a ride-sharing/transportation booking system with modern UI/UX design and clean architecture.

## 📱 Project Overview

This project is a **Flutter Assessment Application** that implements a ride-booking mobile app based on Figma designs. The app showcases modern Flutter development practices including state management, clean architecture, and responsive design.

### 🎯 Key Features

- **User Authentication**: Phone/Email login with country code selection
- **Trip Management**: View upcoming, completed, and cancelled trips
- **Trip Details**: Comprehensive trip information with driver details and payment breakdown
- **Search & Filter**: Real-time trip search functionality
- **Map Integration**: Google Maps integration for route visualization (requires API key)
- **Responsive Design**: Pixel-perfect UI implementation following Figma specifications

## 🏗️ Architecture

The app follows **Clean Architecture** principles with feature-based modularization:

```
lib/
├── core/                 # Shared utilities, themes, routing
├── features/            # Feature modules
│   ├── auth/           # Authentication (Login/Signup)
│   ├── splash/         # App initialization
│   ├── onboarding/     # User onboarding
│   └── home/           # Trip management & dashboard
```

### 🛠️ Tech Stack

- **Framework**: Flutter 3.8.1+
- **State Management**: Riverpod + Hooks
- **Routing**: Go Router
- **UI**: Material Design with custom theming
- **Maps**: Google Maps Flutter
- **Networking**: Dio HTTP client
- **Local Storage**: SharedPreferences
- **Architecture**: Clean Architecture with Repository Pattern

## 🚀 Getting Started

### Prerequisites
- Flutter SDK 3.8.1 or higher
- Dart 3.0+
- Android Studio / VS Code
- Google Maps API Key (for map functionality)

### Installation

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd techanalyticatest
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Configure Google Maps (Optional)**
   - Get a Google Maps API key from [Google Cloud Console](https://console.cloud.google.com/)
   - Add the key to `android/app/src/main/AndroidManifest.xml` and `ios/Runner/AppDelegate.swift`

4. **Run the app**
   ```bash
   flutter run
   ```

## 📱 App Flow

1. **Splash Screen** → App initialization with branding
2. **Onboarding** → Welcome screen with login/signup options
3. **Authentication** → Phone/Email login with validation
4. **Home Dashboard** → Trip management with status tabs (Upcoming/Past/Cancelled)
5. **Trip Details** → Comprehensive trip information with map, driver details, and payment breakdown

## 🔥 Notable Features

- **Mock Data Implementation**: Complete trip data with realistic scenarios
- **Responsive Design**: Adaptive UI for different screen sizes using ScreenUtil
- **Error Handling**: Comprehensive error states and loading indicators
- **Clean Code**: Well-documented, maintainable codebase with proper separation of concerns
- **Modern UI**: Sleek design with smooth animations and transitions

## 📋 Current Status

✅ **Completed Features:**
- Authentication flow with phone/email toggle
- Trip dashboard with status filtering
- Trip search and filtering
- Detailed trip views with driver information
- Payment breakdown and receipt download
- Navigation and routing
- Responsive UI implementation

⚠️ **Known Limitations:**
- Google Maps requires API key configuration for full functionality
- Uses mock data for demonstration purposes
- Real-time features are simulated

## 🔧 Development Notes

This project demonstrates proficiency in:
- Modern Flutter development patterns
- State management with Riverpod
- Clean architecture implementation
- Responsive UI development
- Navigation and routing
- API integration patterns
- Error handling and user experience
