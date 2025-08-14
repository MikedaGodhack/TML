
# Track My Love (TML) — Flutter + Firebase

**Includes**
- Firebase Email/Password + Phone auth
- Google Sign-In
- Firestore-ready
- Android release config
- Codemagic workflow

## Firebase (required)
1) Firebase Console → Create project.
2) Add Android app with package **com.tml.app**.
3) Download **google-services.json** and replace the placeholder at `android/app/google-services.json`.
4) In **Authentication**: enable Email/Password, Phone, and Google.
5) Rebuild.

## Codemagic (recommended)
- Connect repo → choose Flutter Android release.
- Output: `build/app/outputs/flutter-apk/app-release.apk`.

## Local
```bash
flutter pub get
flutter build apk --release
```
