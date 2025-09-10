
# PMG Engineering Assignment - Flutter Mobile App

A Flutter mobile application with Firebase authentication and posts management using BLoC state management pattern.

## Features

- ✅ **Firebase Authentication** - Email/password login with forgot password functionality
- ✅ **Posts Management** - Fetch and display posts from JSONPlaceholder API
- ✅ **BLoC State Management** - Clean architecture with separation of concerns
- ✅ **Error Handling** - Retry functionality for failed API calls
- ✅ **Responsive UI** - Professional blue-white theme with animations
- ✅ **Loading States** - Shimmer effects and loading indicators
- ✅ **Form Validation** - Email format and password length validation

## Screenshots

<div align="center">
  <img src="https://github.com/user-attachments/assets/484c21d5-f565-4505-82e3-2b4bd77020d2" alt="Posts Screen" width="300" height="600">
  <img src="https://github.com/user-attachments/assets/d4110d98-b047-47ff-86f0-e659ee214351" alt="App Features" width="300" height="600">
</div>



## Getting Started

### Prerequisites

- Flutter SDK (3.0.0 or higher)
- Dart SDK
- Android Studio / VS Code
- Firebase project setup

### Installation

1. Clone the repository
```
git clone https://github.com/Chandu-geesala/pmg.git
cd pmg
```

2. Install dependencies
```
flutter pub get
```

3. Configure Firebase
- Add your `google-services.json` (Android) to `android/app/`
- Add your `GoogleService-Info.plist` (iOS) to `ios/Runner/`

4. Run the app
```
flutter run
```

## Build APK

```
# Debug APK
flutter build apk --debug

# Release APK
flutter build apk --release
```

## Login Credentials

For testing purposes:
- **Email:** chandugeesala0@gmail.com
- **Password:** 111111

## API Integration

The app fetches posts from [JSONPlaceholder](https://jsonplaceholder.typicode.com/posts)

## Project Structure

```
lib/
├── main.dart
├── models/
│   └── post.dart
├── repositories/
│   └── posts_repository.dart
├── services/
│   └── auth_service.dart
├── blocs/
│   ├── auth/
│   └── posts/
├── screens/
│   ├── login_screen.dart
│   └── posts_screen.dart
└── widgets/
    ├── post_card.dart
    └── shimmer_loading.dart
```

## Dependencies

- `firebase_core` - Firebase initialization
- `firebase_auth` - Authentication
- `flutter_bloc` - State management
- `http` - API calls
- `equatable` - Value equality

## CI/CD

GitHub Actions workflow automatically builds APK on push to master branch.

## Author

**Chandu Geesala**
- Phone: +91 7731888943
- LinkedIn: [chandu-geesala](https://www.linkedin.com/in/chandu-geesala-b64b342bb)
- GitHub: [Chandu-geesala](https://github.com/Chandu-geesala)
- Portfolio: [chandu-geesala.github.io](https://chandu-geesala.github.io/resume/)

## License

This project is licensed under the MIT License.
