# ETAPA 5 - EJECUCIÓN DE RUTINA Y REGISTRO

## OBJETIVO

Permitir que el usuario ejecute una rutina desde el celular, registre pesos/reps y guarde una sesión.

---

## DEPENDE DE

- Usuario autenticado.
- Usuario con rutina asignada.
- Rutina con ejercicios válidos.
- Validación Plan Pro para ejecutar y guardar progreso.

---

## PANTALLAS USUARIO

Crear o validar:

```text
lib/views/user/user_home_screen.dart
lib/views/user/routine_list_screen.dart
lib/views/user/routine_detail_screen.dart
lib/views/user/workout_screen.dart
lib/views/user/workout_summary_screen.dart
```

---

## FLUJO

```text
Mis rutinas
↓
Detalle de rutina
↓
Iniciar rutina
↓
Ejercicio actual
↓
Registrar peso/reps
↓
Descanso con cronómetro
↓
Siguiente ejercicio
↓
Finalizar entrenamiento
↓
Guardar sesión
↓
Resumen
```

---

## WORKOUT SESSION

Colección:

```text
workout_sessions
```

Estructura:

```text
id
userId
routineId
date
exercises
completed
durationSeconds
createdAt
```

### ExerciseLog

```text
exerciseId
exerciseName
weight
reps
completed
timestamp
```

---

## CRONÓMETRO

El cronómetro usa `restTimeSeconds` del ejercicio.

Debe permitir:

- Iniciar.
- Pausar.
- Reanudar.
- Saltar descanso.
- Aviso visual al terminar.
- Vibración/sonido solo si ya existe soporte simple y seguro.

---

## VALIDACIÓN PLAN PRO

Usuario Basic:

- Puede ver detalle con bloqueo visual.
- No puede iniciar.
- No puede registrar peso.
- No puede guardar sesión.

Usuario Pro:

- Puede ejecutar y guardar.

Coach/Admin:

- Pueden ejecutar sin suscripción.

---

## VALIDACIÓN

- [ ] Usuario ve rutinas asignadas.
- [ ] Basic no puede iniciar.
- [ ] Pro inicia rutina.
- [ ] Se muestra ejercicio actual.
- [ ] Registra peso/reps.
- [ ] Cronómetro funciona.
- [ ] Avanza ejercicios.
- [ ] Guarda sesión.
- [ ] Security Rules bloquean escritura Basic.
- [ ] `flutter analyze` sin errores críticos.

---

## PROMPT PARA CODEX

```text
Implementa la ETAPA 5: Ejecución de rutina y registro.

Contexto:
- Proyecto Flutter + Firebase con MVC.
- Ya existen usuarios, roles, solicitudes, rutinas y asignación de rutinas.
- No reestructurar.
- Seguir GUIA_DISENO.md.
- Plan Basic NO puede ejecutar ni guardar progreso.
- Usuario Pro sí puede ejecutar.
- Coach/Admin pueden ejecutar sin suscripción.

Tareas:
1. Crear o completar pantallas de usuario:
   - user_home_screen.dart
   - routine_list_screen.dart
   - routine_detail_screen.dart
   - workout_screen.dart
   - workout_summary_screen.dart
2. En routine_list_screen, listar rutinas por assignedRoutineIds.
3. En routine_detail_screen, mostrar:
   - portada
   - nombre
   - descripción
   - nivel
   - modalidad
   - días por semana
   - ejercicios
   - botón Iniciar Rutina
4. Validar Plan Pro antes de iniciar rutina.
5. Crear workout_screen:
   - indicador ejercicio X de Y
   - card ejercicio actual
   - input peso kg
   - input reps completadas
   - checkbox completado
   - cronómetro descanso
   - botón siguiente
   - botón finalizar
6. Implementar cronómetro con restTimeSeconds.
7. Guardar WorkoutSession en Firestore al finalizar.
8. Crear WorkoutSummaryScreen.
9. Actualizar WorkoutService si hace falta.
10. Validar Security Rules para workout_sessions.
11. Ejecuta flutter analyze y corrige errores.

Criterios:
- Basic queda bloqueado visual y técnicamente.
- Pro guarda sesión correctamente.
- Coach/Admin pueden ejecutar sin pagar.
- Datos persisten en workout_sessions.
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
