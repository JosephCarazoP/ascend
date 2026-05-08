# ETAPA 1 - FUNDACIÓN Y FIREBASE

## OBJETIVO

Dejar el proyecto Flutter + Firebase funcionando con arquitectura MVC estable.

---

## ESTADO ACTUAL DETECTADO

Ya existe avance inicial:

- Proyecto Flutter creado.
- Compatibilidad Android/iOS revisada.
- Estructura MVC creada.
- Dependencias Firebase agregadas.
- Firebase inicializado en `main.dart`.
- `flutter analyze` pasó sin errores.

Pendiente:

- Crear o confirmar proyecto real en Firebase Console.
- Activar Firebase Authentication.
- Activar Cloud Firestore.
- Descargar:
  - `google-services.json`
  - `GoogleService-Info.plist`
- Probar conexión real.

---

## TAREAS

### 1. Validar estructura

Confirmar que existe:

```text
lib/
├── models/
├── views/
├── controllers/
├── services/
└── utils/
```

### 2. Validar dependencias

Confirmar en `pubspec.yaml`:

```yaml
firebase_core
firebase_auth
cloud_firestore
provider
```

Agregar `firebase_storage` solo si ya se va a trabajar con imágenes en etapas posteriores.  
No agregar dependencias por adelantado sin necesidad.

### 3. Modelos base

Crear o validar:

```text
user.dart
coach.dart
routine.dart
exercise.dart
workout_session.dart
exercise_log.dart
```

Cada modelo debe tener:

```text
constructor
toJson()
fromJson()
copyWith()
```

### 4. Servicios base

Crear o validar:

```text
auth_service.dart
user_service.dart
routine_service.dart
workout_service.dart
subscription_service.dart
```

`subscription_service.dart` puede quedar simple en esta etapa, solo con validación de `planType`.

---

## VALIDACIÓN

- [ ] Proyecto compila.
- [ ] Firebase inicializa.
- [ ] MVC no se altera.
- [ ] Modelos tienen `toJson`, `fromJson`, `copyWith`.
- [ ] Servicios base existen.
- [ ] `flutter analyze` sin errores críticos.

---

## PROMPT PARA CODEX

```text
Estamos trabajando en Ascend, una app Flutter + Firebase con arquitectura MVC.

Implementa o valida la ETAPA 1: Fundación y Firebase.

Reglas:
- No reestructures carpetas.
- No borres código funcional.
- Mantén MVC.
- No implementes pantallas complejas todavía.
- No agregues funcionalidades fuera de esta etapa.
- Revisa el estado actual del proyecto antes de modificar.

Tareas:
1. Verifica estructura lib/models, lib/views, lib/controllers, lib/services, lib/utils.
2. Verifica dependencias Firebase en pubspec.yaml.
3. Crea o completa los modelos base:
   - User
   - Coach
   - Routine
   - Exercise
   - WorkoutSession
   - ExerciseLog
4. Cada modelo debe tener constructor, toJson, fromJson y copyWith.
5. Crea o completa servicios base:
   - AuthService
   - UserService
   - RoutineService
   - WorkoutService
   - SubscriptionService
6. No implementes UI todavía salvo que ya exista algo mínimo.
7. Ejecuta flutter analyze y corrige errores.

Entrega:
- Resumen de archivos modificados.
- Errores encontrados.
- Confirmación de si la etapa queda lista.
```


## REGLAS PARA CODEX

Estas reglas aplican a toda etapa:

- Mantener Flutter + Firebase.
- Mantener arquitectura MVC existente.
- No reestructurar carpetas.
- No borrar código funcional.
- No duplicar lógica si ya existe un servicio/controlador reutilizable.
- No meter funcionalidades fuera de la etapa activa.
- No cambiar nombres de colecciones ya usadas sin necesidad.
- No cambiar diseño global fuera de `GUIA_DISENO.md`.
- Antes de modificar, inspeccionar archivos relacionados.
- Al finalizar, ejecutar:
  - `flutter analyze`
  - pruebas/manual checklist de la etapa si aplica.
- Si falta Firebase Console, archivos reales o credenciales, dejar TODO claro y no inventar configuración.
