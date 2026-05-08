# CONEXIÓN FIREBASE + FLUTTER (ASCEND)

## Requisitos

- Cuenta de Firebase y proyecto creado en Firebase Console.
- Flutter SDK instalado.
- Proyecto Flutter inicializado.

## Paso a paso

1. Instalar Firebase CLI y FlutterFire CLI:

```bash
dart pub global activate flutterfire_cli
```

2. Login en Firebase:

```bash
firebase login
```

3. Desde la raíz del proyecto Flutter, configurar Firebase:

```bash
flutterfire configure
```

Esto genera `lib/firebase_options.dart` y registra plataformas.

4. Dependencias mínimas en `pubspec.yaml`:

```yaml
dependencies:
  firebase_core: ^latest
  firebase_auth: ^latest
  cloud_firestore: ^latest
  provider: ^latest
```

5. Inicializar Firebase en `main.dart`:

```dart
await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
);
```

6. Android:
- Verificar aplicación registrada.
- Si usas flujo manual, confirmar `android/app/google-services.json`.

7. iOS:
- Verificar app iOS registrada.
- Si usas flujo manual, confirmar `ios/Runner/GoogleService-Info.plist`.

8. Validación:

```bash
flutter pub get
flutter analyze
flutter run
```

## Verificación rápida

- Firebase inicializa sin excepción.
- Auth y Firestore responden en una prueba simple.
- No hay errores críticos en `flutter analyze`.
