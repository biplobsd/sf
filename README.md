# StackFood

Multi Restaurant - Food Delivery App with Flutter and Dart, integrating with Laravel Admin and Restaurant Panel.

## 🎯 Features

- **MVVM Architecture**: Clean separation of concerns for maintainable code
- **Riverpod State Management**: Efficient and type-safe state management solution
- **Routing**: Declarative routing with go_router
- **Web and Mobile Support**: Built with Flutter for cross-platform compatibility
- **Responsive Design**: Adapts to different screen sizes and orientations

## 🚀 Demo

- **Web App**: [biplobsd.me/sf](https://biplobsd.me/sf)
- **Mobile App**: [Download APK](https://github.com/biplobsd/sf/releases/latest/download/sf.apk)

## 📱 Screenshots

| Splash                                                     | Home                                       |
|------------------------------------------------------------|--------------------------------------------|
| ![Splash](/screenshots/splash.jpg)                         | ![Home](/screenshots/home.jpg)             |

| Loading                              | Error                            |
|--------------------------------------|----------------------------------|
| ![Loading](/screenshots/loading.jpg) | ![Error](/screenshots/error.jpg) |

| Under Construction                                         | Web Home                          |
|------------------------------------------------------------|-----------------------------------|
| ![Under Construction](/screenshots/under_construction.jpg) | ![Web Home](/screenshots/web.png) |

## 🎥 Video Demo

https://github.com/user-attachments/assets/c759e60c-072d-42bb-bc85-0c9b41ad221f

## 🔧 Tech Stack

- **Framework**: Flutter for cross-platform mobile development
- **State Management**: Riverpod with code generation
- **Architecture**: MVVM (Model-View-ViewModel)
- **Routing**: Go Router for declarative routing
- **UI Components**: Custom responsive widgets with Flutter ScreenUtil

## 📦 Core Dependencies

- `flutter_riverpod` & `riverpod_annotation`: Reactive state management
- `go_router`: Navigation and routing
- `flutter_screenutil`: Responsive UI scaling
- `envied`: Secure environment variable management
- `freezed`: Immutable state models
- `font_awesome_flutter`: FontAwesome icons for UI
- `cached_network_image`: Efficient image caching
- `carousel_slider`: Image carousel for featured items
- `skeletonizer`: Skeleton loading animations
- `gap`: Flexible spacing widget
- `lottie`: Lottie animations for engaging UI
- `dio`: HTTP client for network requests
- `connectivity_plus`: Network connectivity checks

## 🏗️ Project Structure

```
lib/
│   ├───constants               # App constants and configurations
│   ├───extensions              # Extension methods
│   ├───features                # Feature modules
│   │   ├───common              # Shared components
│   │   │   ├───remote          # API and remote data access
│   │   │   └───ui              # Common UI components
│   │   │       ├───providers   # Common providers
│   │   │       └───widgets     # Reusable widgets
│   │   ├───home                # Home feature
│   │   │   ├───model           # Data models
│   │   │   ├───repository      # Data repositories
│   │   │   └───ui              # UI components
│   │   │       ├───providers   # State providers
│   │   │       ├───state       # State definitions
│   │   │       ├───view_model  # View models
│   │   │       └───widgets     # UI widgets
│   │   ├───home_layout         # Layout for home screen
│   │   │   └───ui
│   │   │       ├───state       # State management
│   │   │       └───view_model  # View models
│   │   └───onboarding          # Onboarding flow
│   │       └───ui              # Onboarding UI
│   ├───routing                 # Route configurations
│   ├───theme                   # Theme configurations
│   └───utils                   # Utility functions
```

## 🔌 Backend API

The application connects to the following endpoints:

- **Base URL**: `https://stackfood-admin.6amtech.com`
- **API Endpoints**:
    - Configuration/Settings: `/api/v1/config` (Contains all image base URLs)
    - Banners: `/api/v1/banners`
    - Categories: `/api/v1/categories`
    - Popular Food: `/api/v1/products/popular`
    - Food Campaigns: `/api/v1/campaigns/item`
    - Restaurants: `/api/v1/restaurants/get-restaurants/all?offset=1&limit=10` (Paginated)

- **API Headers**:
  ```json
  {
    "Content-Type": "application/json; charset=UTF-8",
    "zoneId": "[1]",
    "latitude": "23.735129",
    "longitude": "90.425614"
  }
  ```

## 🚀 Getting Started

### Prerequisites

- Flutter SDK 3.32.6 or higher

### Setup

1. Clone this repository
```bash
git clone https://github.com/biplobsd/sf.git
cd sf
```

2. Install dependencies
```bash
flutter pub get
```

3. Generate code
```bash
dart run build_runner build --delete-conflicting-outputs
```

4. Run the app
```bash
# For debug mode
flutter run

# For release mode
flutter run --release

# For web
flutter run -d chrome

# or for release mode web
flutter run -d chrome --release
```

## 📱 Building for Production

### Building Optimized APK/App Bundle

For the smallest possible APK:
```bash
flutter build apk --release --target-platform android-arm,android-arm64 --split-per-abi
```

For Google Play Store:
```bash
flutter build appbundle --release
```

## 👨‍💻 Development

### Team
- **Developer**: [Biplob Kumar Sutradhar](https://github.com/biplobsd) (biplobsd11@gmail.com)

### Template used
This project is built using the [flutter_mvvm_riverpod](https://github.com/namanh11611/flutter_mvvm_riverpod) template, which provides a solid foundation with MVVM architecture and Riverpod state management.

### Report Issues
For bug reports and feature requests, please open an issue on GitHub with a detailed description and screenshots if applicable.
