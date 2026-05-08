# ETAPA 6 - PROGRESO DE USUARIO Y COACH

## OBJETIVO

Mostrar progreso personal al usuario y progreso de clientes al coach.

---

## DEPENDE DE

- Workout sessions guardadas.
- Rutinas ejecutadas.
- Usuario asignado a coach.

---

## PANTALLAS

Usuario:

```text
lib/views/user/progress_screen.dart
```

Coach:

```text
lib/views/coach/client_progress_screen.dart
```

---

## CONTROLADOR

Crear:

```text
lib/controllers/progress_controller.dart
```

Métodos:

```text
getLastSession(userId)
getPersonalRecords(userId)
getRecentSessions(userId, limit)
compareWithPrevious(currentSession, previousSession)
getClientProgressForCoach(coachId, userId)
```

---

## DATOS A MOSTRAR

### Usuario

- Última sesión.
- Rutina ejecutada.
- Ejercicios con peso/reps.
- Comparación con sesión anterior.
- Récords personales por ejercicio.
- Últimas 10 sesiones.

### Coach

- Última sesión del cliente.
- Récords del cliente.
- Evolución.
- Total entrenamientos.
- Consistencia básica.
- Señales simples: mejorando, manteniendo o bajando.

---

## RESTRICCIONES

Usuario Basic:

- No puede ver progreso activo.
- Mostrar bloqueo Plan Pro.

Usuario Pro:

- Ve su progreso.

Coach:

- Solo ve progreso de sus clientes.

Admin:

- Puede ver todo.

---

## VALIDACIÓN

- [ ] Usuario Pro ve progreso.
- [ ] Usuario Basic bloqueado.
- [ ] Coach ve progreso de sus clientes.
- [ ] Coach no ve clientes ajenos.
- [ ] Cálculos son correctos.
- [ ] `flutter analyze` sin errores críticos.

---

## PROMPT PARA CODEX

```text
Implementa la ETAPA 6: Progreso de usuario y coach.

Contexto:
- Proyecto Flutter + Firebase con MVC.
- Ya existen workout_sessions.
- No reestructurar.
- Seguir GUIA_DISENO.md.
- Basic no ve progreso activo.
- Pro ve su progreso.
- Coach ve solo progreso de sus clientes.

Tareas:
1. Crear lib/controllers/progress_controller.dart.
2. Implementar:
   - getLastSession
   - getPersonalRecords
   - getRecentSessions
   - compareWithPrevious
   - getClientProgressForCoach
3. Crear lib/views/user/progress_screen.dart.
4. Crear lib/views/coach/client_progress_screen.dart.
5. Agregar acceso desde UserHome a Mi Progreso.
6. Agregar botón Ver Progreso en clientes del CoachDashboard.
7. Validar Plan Pro para usuario regular.
8. Validar coachId para que coach vea solo sus clientes.
9. Actualizar Security Rules si hace falta.
10. Ejecuta flutter analyze y corrige errores.

Criterios:
- Última sesión se muestra.
- Récords personales se calculan por exerciseName.
- Últimas sesiones se ordenan por fecha.
- Coach no puede ver datos de clientes ajenos.
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
