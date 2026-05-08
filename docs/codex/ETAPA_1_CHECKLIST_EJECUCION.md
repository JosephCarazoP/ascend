# ETAPA 1 - CHECKLIST DE EJECUCIÓN (ASCEND)

Fecha: 2026-05-08

## Alcance

Este checklist se usa para ejecutar la **ETAPA 1 (Fundación y Firebase)** sin adelantar etapas.

## Estado real del repositorio (verificado)

En este repositorio actualmente **solo hay documentación** y no se encontraron:

- `pubspec.yaml`
- carpeta `lib/`
- carpetas móviles (`android/`, `ios/`)

Por lo tanto, la implementación técnica de la etapa 1 queda **bloqueada** hasta contar con el proyecto Flutter base.

## Checklist técnico de Etapa 1

### A. Estructura MVC

- [ ] Verificar que exista:
  - [ ] `lib/models/`
  - [ ] `lib/views/`
  - [ ] `lib/controllers/`
  - [ ] `lib/services/`
  - [ ] `lib/utils/`

### B. Dependencias mínimas

- [ ] Verificar en `pubspec.yaml`:
  - [ ] `firebase_core`
  - [ ] `firebase_auth`
  - [ ] `cloud_firestore`
  - [ ] `provider`

### C. Modelos base

- [ ] `user.dart`
- [ ] `coach.dart`
- [ ] `routine.dart`
- [ ] `exercise.dart`
- [ ] `workout_session.dart`
- [ ] `exercise_log.dart`

Cada modelo debe incluir:

- [ ] constructor
- [ ] `toJson()`
- [ ] `fromJson()`
- [ ] `copyWith()`

### D. Servicios base

- [ ] `auth_service.dart`
- [ ] `user_service.dart`
- [ ] `routine_service.dart`
- [ ] `workout_service.dart`
- [ ] `subscription_service.dart` (versión básica en etapa 1)

### E. Validación

- [ ] `flutter pub get`
- [ ] `flutter analyze`
- [ ] Confirmación de inicialización Firebase

## Siguiente paso sugerido

Cuando se agregue el proyecto Flutter real al repositorio, ejecutar este checklist en orden y registrar resultados en este mismo archivo.
