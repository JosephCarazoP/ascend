# ETAPA 3 - SOLICITUDES DE RUTINA

## OBJETIVO

Crear el flujo donde el usuario solicita una rutina y el coach revisa esa solicitud.

Esta etapa es clave porque conecta el negocio real:

```text
usuario → formulario → solicitud → coach → rutina asignada
```

---

## COLECCIÓN FIRESTORE

```text
routine_requests
```

---

## MODELO

Crear:

```text
lib/models/routine_request.dart
```

### Campos

```text
id: String
userId: String
coachId: String
status: String
goal: String
experienceLevel: String
trainingDaysAvailable: int
trainingPlace: String
equipment: List<String>
limitations: String?
injuriesOrNotes: String?
answers: Map<String, dynamic>
createdAt: DateTime
reviewedAt: DateTime?
assignedRoutineId: String?
coachNotes: String?
```

### Estados permitidos

```text
pending
reviewed
assigned
rejected
```

---

## SERVICIO

Crear:

```text
lib/services/routine_request_service.dart
```

### Métodos

```text
createRequest(RoutineRequest request)
getRequest(String requestId)
getRequestsByUser(String userId)
getRequestsByCoach(String coachId)
updateRequestStatus(String requestId, String status)
assignRoutineToRequest(String requestId, String routineId)
addCoachNotes(String requestId, String notes)
```

---

## CONTROLADOR

Crear:

```text
lib/controllers/routine_request_controller.dart
```

Debe manejar:

- Loading.
- Error.
- Lista de solicitudes.
- Crear solicitud.
- Cambiar estado.
- Asignar rutina.

---

## PANTALLAS USUARIO

Crear:

```text
lib/views/user/request_routine_screen.dart
lib/views/user/my_routine_requests_screen.dart
```

### request_routine_screen.dart

Formulario con:

- Objetivo principal.
- Nivel de experiencia.
- Días disponibles por semana.
- Lugar de entrenamiento.
- Equipo disponible.
- Limitaciones.
- Lesiones/notas.
- Preguntas adicionales en `answers`.

### my_routine_requests_screen.dart

Muestra solicitudes del usuario:

- Estado.
- Fecha.
- Objetivo.
- Coach asignado.
- Rutina asignada si ya existe.

---

## PANTALLAS COACH

Crear:

```text
lib/views/coach/routine_requests_screen.dart
lib/views/coach/routine_request_detail_screen.dart
```

### routine_requests_screen.dart

Lista solicitudes de clientes asignados al coach:

- Usuario.
- Estado.
- Objetivo.
- Fecha.
- Botón ver detalle.

### routine_request_detail_screen.dart

Muestra:

- Respuestas del usuario.
- Limitaciones.
- Equipo.
- Objetivo.
- Estado.
- Notas del coach.
- Acción marcar como revisada.
- Acción asignar rutina existente.
- Enlace futuro a crear rutina.

---

## REGLAS DE NEGOCIO

- Usuario puede crear solicitud propia.
- Usuario puede ver sus solicitudes.
- Coach puede ver solicitudes de sus clientes.
- Coach puede actualizar estado.
- Coach puede asociar una rutina a una solicitud.
- Admin puede ver y modificar todo.
- Usuario Basic sí puede solicitar rutina.
- Usuario Basic no puede ejecutar rutina ni registrar progreso.

---

## SECURITY RULES SUGERIDAS

Agregar en `firestore.rules`:

```javascript
match /routine_requests/{requestId} {
  allow read: if isAuthenticated() &&
    (
      resource.data.userId == request.auth.uid ||
      isCoachOfClient(resource.data.userId) ||
      isAdmin()
    );

  allow create: if isAuthenticated() &&
    request.resource.data.userId == request.auth.uid &&
    request.resource.data.status == 'pending';

  allow update: if isAuthenticated() &&
    (
      isAdmin() ||
      isCoachOfClient(resource.data.userId)
    );

  allow delete: if isAdmin();
}
```

Nota: si las reglas actuales usan helpers con nombres distintos, adaptar sin duplicar helpers.

---

## VALIDACIÓN

- [ ] Usuario crea solicitud.
- [ ] Usuario ve sus solicitudes.
- [ ] Coach ve solicitudes de sus clientes.
- [ ] Coach no ve solicitudes de clientes ajenos.
- [ ] Coach cambia estado.
- [ ] Coach asigna rutina existente.
- [ ] Admin puede gestionar.
- [ ] Security Rules bloquean accesos indebidos.
- [ ] `flutter analyze` sin errores críticos.

---

## PROMPT PARA CODEX

```text
Implementa la ETAPA 3: Solicitudes de rutina.

Contexto:
- Proyecto Flutter + Firebase.
- Arquitectura MVC obligatoria.
- Ya existen roles admin, coach y usuario.
- Admin asigna coach a usuario mediante coachId.
- Usuario Basic puede solicitar rutina, pero NO puede ejecutar rutina ni registrar progreso.
- No reestructures el proyecto.
- Sigue GUIA_DISENO.md.

Objetivo:
Crear el flujo para que un usuario solicite una rutina llenando un formulario y el coach pueda revisar esa solicitud.

Tareas:
1. Crear modelo lib/models/routine_request.dart con:
   - id
   - userId
   - coachId
   - status
   - goal
   - experienceLevel
   - trainingDaysAvailable
   - trainingPlace
   - equipment
   - limitations
   - injuriesOrNotes
   - answers
   - createdAt
   - reviewedAt
   - assignedRoutineId
   - coachNotes
   Incluye constructor, toJson, fromJson y copyWith.

2. Crear lib/services/routine_request_service.dart con:
   - createRequest
   - getRequest
   - getRequestsByUser
   - getRequestsByCoach
   - updateRequestStatus
   - assignRoutineToRequest
   - addCoachNotes

3. Crear lib/controllers/routine_request_controller.dart para manejar loading, errores, creación, listado y actualización.

4. Crear pantallas de usuario:
   - lib/views/user/request_routine_screen.dart
   - lib/views/user/my_routine_requests_screen.dart

5. Crear pantallas de coach:
   - lib/views/coach/routine_requests_screen.dart
   - lib/views/coach/routine_request_detail_screen.dart

6. Integrar navegación desde UserHome hacia solicitar rutina y mis solicitudes.
7. Integrar navegación desde CoachDashboard hacia solicitudes.
8. Actualizar Firestore Security Rules para la colección routine_requests.
9. No implementes creación avanzada de rutinas en esta etapa.
10. No implementes ejecución de rutinas en esta etapa.
11. Ejecuta flutter analyze y corrige errores.

Criterios de aceptación:
- Usuario autenticado crea solicitud propia.
- Usuario ve sus solicitudes.
- Coach ve solo solicitudes de sus clientes.
- Coach puede marcar como reviewed, rejected o assigned.
- Coach puede asociar assignedRoutineId si ya existe una rutina.
- Admin puede acceder a todo.
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
