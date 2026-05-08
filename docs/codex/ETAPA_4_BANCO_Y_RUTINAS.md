# ETAPA 4 - BANCO DE EJERCICIOS Y GESTIÓN DE RUTINAS

## OBJETIVO

Permitir que el coach cree ejercicios reutilizables y rutinas completas, y que pueda asignarlas a usuarios.

---

## DEPENDE DE

- Etapa 1 lista.
- Etapa 2 lista.
- Etapa 3 lista.

No iniciar si no existen solicitudes de rutina y clientes asignados.

---

## COLECCIONES

```text
bank_exercises
routines
users.assignedRoutineIds
routine_requests.assignedRoutineId
```

---

## BANCO DE EJERCICIOS

### Modelo

Crear o validar:

```text
lib/models/bank_exercise.dart
```

Campos:

```text
id
name
description
youtubeUrl
imageUrls
coachId
createdAt
```

### Servicio

Crear o validar:

```text
lib/services/exercise_bank_service.dart
```

Métodos:

```text
createExercise
getExercise
updateExercise
deleteExercise
getExercisesByCoach
```

---

## RUTINAS

### Modelo Routine

Campos mínimos:

```text
id
name
description
coverImageUrl
level
modality
trainingDaysPerWeek
exercises
coachId
createdAt
updatedAt
```

### Modelo Exercise

Campos mínimos:

```text
id
bankExerciseId
name
sets
reps
restTimeSeconds
notes
order
```

---

## PANTALLAS COACH

Crear o validar:

```text
lib/views/coach/exercise_bank_screen.dart
lib/views/coach/create_bank_exercise_screen.dart
lib/views/coach/create_routine_screen.dart
lib/views/coach/add_exercise_to_routine_screen.dart
lib/views/coach/routine_list_screen.dart
lib/views/coach/assign_routine_screen.dart
lib/views/coach/edit_routine_screen.dart
```

---

## SELECTOR DE DESCANSO

No usar input libre.

Usar lista:

```text
0s, 5s, 10s ... 55s
1:00, 1:05 ... 5:00
```

Guardar en segundos.

---

## ASIGNACIÓN DE RUTINAS

Coach puede asignar rutinas a sus clientes.

Al asignar:

1. Agregar `routineId` a `users.assignedRoutineIds`.
2. Si viene desde una solicitud:
   - Actualizar `routine_requests.status = assigned`.
   - Actualizar `routine_requests.assignedRoutineId = routineId`.
   - Actualizar `routine_requests.reviewedAt`.

---

## VALIDACIÓN

- [ ] Coach crea ejercicios.
- [ ] Coach ve solo sus ejercicios.
- [ ] Coach crea rutina con mínimo 1 ejercicio.
- [ ] Coach edita rutina.
- [ ] Coach duplica rutina.
- [ ] Coach elimina rutina con confirmación.
- [ ] Coach asigna rutina a cliente.
- [ ] Si asigna desde solicitud, la solicitud queda assigned.
- [ ] Usuario tiene `assignedRoutineIds`.
- [ ] Security Rules protegen coachId.
- [ ] `flutter analyze` sin errores críticos.

---

## PROMPT PARA CODEX

```text
Implementa la ETAPA 4: Banco de ejercicios y gestión de rutinas.

Contexto:
- Proyecto Flutter + Firebase con MVC.
- Ya existen auth, roles, admin, coach, usuario y solicitudes de rutina.
- No reestructurar.
- Seguir GUIA_DISENO.md.
- No implementar ejecución de rutina todavía.

Tareas:
1. Crear o completar modelo BankExercise.
2. Crear o completar ExerciseBankService.
3. Crear o completar pantallas:
   - exercise_bank_screen.dart
   - create_bank_exercise_screen.dart
4. Actualizar Routine para incluir:
   - coverImageUrl
   - description
   - trainingDaysPerWeek
   - createdAt
   - updatedAt
5. Actualizar Exercise para incluir:
   - bankExerciseId
   - restTimeSeconds
   - order
6. Crear o completar pantallas:
   - create_routine_screen.dart
   - add_exercise_to_routine_screen.dart
   - routine_list_screen.dart
   - edit_routine_screen.dart
   - assign_routine_screen.dart
7. Implementar selector de descanso desde 0s hasta 5:00 en incrementos de 5s.
8. Validar mínimo 1 ejercicio por rutina.
9. Implementar asignación de rutina a clientes del coach.
10. Si se asigna rutina desde RoutineRequest, actualizar:
   - status = assigned
   - assignedRoutineId
   - reviewedAt
11. Actualizar Security Rules necesarias para bank_exercises y routines.
12. Ejecuta flutter analyze y corrige errores.

Criterios:
- Coach ve solo sus ejercicios y rutinas.
- Coach no puede editar rutinas de otros coaches.
- Usuario recibe routineId en assignedRoutineIds.
- Solicitud queda ligada si se asignó desde una solicitud.
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
