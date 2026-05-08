# ETAPA 1 - CHECKLIST DE EJECUCIÓN (ASCEND)

Fecha: 2026-05-08

## Alcance

Este checklist se usa para ejecutar la **ETAPA 1 (Fundación y Firebase)** sin adelantar etapas.

## Estado real del repositorio (verificado)

El repositorio actualmente contiene un proyecto Flutter base con:

- `pubspec.yaml`
- carpeta `lib/`
- carpetas móviles (`android/`, `ios/`)
- `lib/firebase_options.dart`
- `android/app/google-services.json`

La implementación técnica local de la etapa 1 fue ejecutada. Quedan pendientes
solo verificaciones externas de Firebase Console que no se pueden confirmar desde
el código local.

## Checklist técnico de Etapa 1

### A. Estructura MVC

- [x] Verificar que exista:
  - [x] `lib/models/`
  - [x] `lib/views/`
  - [x] `lib/controllers/`
  - [x] `lib/services/`
  - [x] `lib/utils/`

### B. Dependencias mínimas

- [x] Verificar en `pubspec.yaml`:
  - [x] `firebase_core`
  - [x] `firebase_auth`
  - [x] `cloud_firestore`
  - [x] `provider`

### C. Modelos base

- [x] `user.dart`
- [x] `coach.dart`
- [x] `routine.dart`
- [x] `exercise.dart`
- [x] `workout_session.dart`
- [x] `exercise_log.dart`

Cada modelo debe incluir:

- [x] constructor
- [x] `toJson()`
- [x] `fromJson()`
- [x] `copyWith()`

### D. Servicios base

- [x] `auth_service.dart`
- [x] `user_service.dart`
- [x] `routine_service.dart`
- [x] `workout_service.dart`
- [x] `subscription_service.dart` (versión básica en etapa 1)

### E. Validación

- [x] `flutter pub get`
- [x] `flutter analyze`
- [x] `flutter test`
- [x] Confirmación de inicialización Firebase en `main.dart`
- [ ] Confirmar en Firebase Console que Authentication está activo
- [ ] Confirmar en Firebase Console que Cloud Firestore está activo
- [ ] Confirmar si el flujo iOS requiere `ios/Runner/GoogleService-Info.plist`

## Siguiente paso sugerido

Confirmar en Firebase Console que Auth y Firestore están activos. Si se va a
probar iOS con configuración manual, agregar el `GoogleService-Info.plist` real
descargado desde Firebase Console.
