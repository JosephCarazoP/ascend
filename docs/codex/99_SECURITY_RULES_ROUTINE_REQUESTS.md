# SECURITY RULES - AGREGADO PARA ROUTINE REQUESTS

## OBJETIVO

Agregar reglas de seguridad para la colección nueva:

```text
routine_requests
```

---

## HELPER ESPERADO

Se asume que ya existen helpers similares a:

```javascript
function isAuthenticated() {
  return request.auth != null;
}

function getUserData(userId) {
  return get(/databases/$(database)/documents/users/$(userId)).data;
}

function isAdmin() {
  return isAuthenticated() && getUserData(request.auth.uid).rol == 'admin';
}

function isCoach() {
  return isAuthenticated() && getUserData(request.auth.uid).rol == 'coach';
}

function isCoachOfClient(clientId) {
  return isAuthenticated()
    && isCoach()
    && getUserData(clientId).coachId == request.auth.uid;
}
```

Si ya existen con otros nombres, adaptar sin duplicarlos.

---

## REGLAS SUGERIDAS

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

---

## DECISIONES

- Usuario crea su propia solicitud.
- Usuario puede leer sus solicitudes.
- Usuario no actualiza solicitudes después de enviarlas.
- Coach actualiza estado y notas de solicitudes de sus clientes.
- Coach puede ligar `assignedRoutineId`.
- Admin puede gestionar todo.

---

## PROMPT PARA CODEX

```text
Actualiza firestore.rules para agregar soporte a routine_requests.

Reglas:
- No rompas reglas existentes.
- No dupliques helpers si ya existen.
- Usa helpers existentes si ya están definidos.
- Agrega match /routine_requests/{requestId}.
- Usuario autenticado puede crear solicitud propia con status pending.
- Usuario puede leer sus solicitudes.
- Coach puede leer y actualizar solicitudes de sus clientes.
- Admin puede leer, actualizar y eliminar.
- Usuario no puede actualizar ni eliminar después de crear.
- Ejecuta o indica cómo probar reglas.

Entrega:
- Diff de firestore.rules.
- Explicación breve de cada regla.
- Casos de prueba manuales.
```
