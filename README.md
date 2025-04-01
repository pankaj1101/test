# Firebase Authentication & Push Notification

This Flutter project implements Firebase Push Notifications, a Login Screen, and stores user credentials (email & password) in Firestore.

## Features
- Firebase Authentication for login
- Storing user email and password securely in Firestore
- Implementing Firebase Cloud Messaging (FCM) for push notifications

## Prerequisites
Ensure you have the following set up before proceeding:
- Flutter installed
- Firebase project set up with Firestore and Firebase Authentication enabled
- Firebase Cloud Messaging (FCM) configured

## Installation
1. Clone the repository:
   ```sh
   git clone https://github.com/pankaj1101/test.git
   cd test
   ```

2. Install dependencies:
   ```sh
   flutter pub get
   ```

3. Set up Firebase:
   - Download `google-services.json` (Android) and `GoogleService-Info.plist` (iOS) from Firebase Console.
   - Place them in the respective directories:
     - `android/app/google-services.json`

4. Run the project:
   ```sh
   flutter run
   ```

## Firebase Configuration
- Add the necessary dependencies in `pubspec.yaml`:
  ```yaml
  dependencies:
    firebase_core: latest_version
    firebase_auth: latest_version
    cloud_firestore: latest_version
    firebase_messaging: latest_version
  ```
- Initialize Firebase in `main.dart`:
  ```dart
  void main() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    runApp(MyApp());
  }
  ```

## Implementation
### Login Screen
- Users can log in with email and password.
- On successful login, credentials are stored in Firestore.

### Firestore Database Structure
```
users (Collection)
  |-- user_id (Document)
       |-- email: "user@example.com"
       |-- password: "hashed_password"
```

### Firebase Push Notifications
- Users receive notifications via Firebase Cloud Messaging (FCM).
- Ensure proper permission handling for Android.

## Screenshots
Login Screen ![Screenshot_2025-04-01-10-30-39-854_com example task](https://github.com/user-attachments/assets/a3d62f5b-f348-465a-971f-95676a989709)
Notification Screen ![image](https://github.com/user-attachments/assets/81976aa6-adad-4cd7-8bea-81eb14c03a20)



## License
This project is open-source and free to use.
