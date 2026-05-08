# CONTEXTO GENERAL MODIFICADO - PROYECTO ASCEND

## DECISIÓN TÉCNICA FINAL

Ascend se desarrolla como **app Flutter mobile-first** con **Firebase** como backend.

No se migrará a una app web en esta fase.

### Motivo
El producto principal ocurre desde el celular:

- El usuario ve su rutina.
- Inicia entrenamiento.
- Avanza ejercicio por ejercicio.
- Registra peso y repeticiones.
- Usa cronómetro de descanso.
- Guarda historial.
- El coach revisa progreso.

Una app web puede servir más adelante como panel administrativo o panel para coaches, pero **no es prioridad del MVP**.

---

## STACK TECNOLÓGICO CERRADO

- **Frontend:** Flutter
- **Backend:** Firebase
  - Firebase Authentication
  - Cloud Firestore
  - Firebase Storage, solo cuando se necesiten imágenes
  - Firebase Security Rules
- **Estado:** Provider, si ya está usado en el proyecto
- **Arquitectura:** MVC

---

## DISEÑO GLOBAL

Ascend debe seguir `docs/codex/GUIA_DISENO.md`.

Reglas clave:

- Diseño minimalista, moderno y similar a shadcn ui.
- Usar blanco y negro como base visual.
- Usar matices de gris solo para bordes, fondos secundarios y texto secundario.
- Usar verde solo como acento puntual.
- No usar gradientes decorativos ni paletas de color adicionales.
- La app debe permitir cambiar entre modo claro y modo oscuro.

---

## PRINCIPIO DE DESARROLLO

El proyecto ya no se organiza por semanas.  
Se organiza por **etapas cerradas**.

Una etapa se termina antes de iniciar la siguiente.

### Orden recomendado

1. Fundación y conexión Firebase
2. Autenticación, roles y navegación protegida
3. Solicitudes de rutina
4. Banco de ejercicios y gestión de rutinas
5. Ejecución de rutina y registro de entrenamiento
6. Progreso de usuario y progreso para coach
7. Suscripciones y Plan Pro
8. Comunidad básica
9. IA para coaches, pulido y lanzamiento

---

## AJUSTE IMPORTANTE DE NEGOCIO

Se agrega una etapa nueva: **Solicitudes de rutina**.

Esta etapa conecta el flujo real del negocio:

```text
Usuario crea perfil
↓
Usuario solicita rutina llenando formulario
↓
Coach ve solicitud
↓
Coach revisa respuestas
↓
Coach crea o asigna rutina
↓
Usuario ejecuta rutina desde celular
```

---

## REGLA DE PLANES AJUSTADA

### Usuario Basic

Puede:

- Registrarse.
- Iniciar sesión.
- Ver perfil.
- Solicitar una rutina.
- Ver estado de su solicitud.
- Ver información general del Plan Pro.
- Ver comunidad en modo solo lectura, si ya está implementada.

No puede:

- Iniciar rutinas.
- Usar cronómetro.
- Registrar pesos.
- Guardar progreso.
- Dar likes.
- Publicar en comunidad.
- Usar herramientas activas.

### Usuario Pro

Puede:

- Ejecutar rutinas.
- Usar cronómetro.
- Registrar pesos y repeticiones.
- Guardar progreso.
- Ver historial avanzado.
- Interactuar en comunidad.
- Usar funciones activas del sistema.

### Coach y Admin

No pagan suscripción.

Tienen acceso completo según su rol.

---

## ROLES

### Admin

Puede:

- Ver todos los usuarios.
- Asignar coaches.
- Gestionar usuarios.
- Ver solicitudes.
- Ver rutinas.
- Acceso completo.

### Coach

Puede:

- Ver sus clientes.
- Ver solicitudes de sus clientes.
- Crear banco de ejercicios.
- Crear rutinas.
- Asignar rutinas.
- Ver progreso de sus clientes.
- Usar funciones de usuario sin pagar.

### Usuario

Puede:

- Crear perfil.
- Solicitar rutina.
- Ver rutinas asignadas.
- Ejecutar rutinas solo si es Pro.
- Registrar progreso solo si es Pro.

---

## FLUJO CENTRAL DEL MVP

El MVP no es comunidad ni IA.  
El MVP es este:

```text
Registro
↓
Asignación de coach
↓
Solicitud de rutina
↓
Creación/asignación de rutina
↓
Ejecución desde celular
↓
Registro de pesos/reps
↓
Progreso visible para usuario y coach
```

---

## FUERA DE ALCANCE DEL MVP INICIAL

No hacer al inicio:

- Comunidad avanzada.
- IA.
- Web admin separada.
- Automatización excesiva.
- Pagos antes de validar el flujo de entrenamiento.
- Analytics avanzado.
- Chat interno.
- Notificaciones push complejas.

---

## ESTRUCTURA MVC

```text
lib/
├── models/
├── views/
├── controllers/
├── services/
└── utils/
```

---

## COLECCIONES FIRESTORE PRINCIPALES

```text
users
coaches
routine_requests
bank_exercises
routines
workout_sessions
posts
```

---

## COLECCIÓN NUEVA: routine_requests

Sirve para guardar solicitudes de rutina hechas por usuarios.

### Campos sugeridos

```text
id: String
userId: String
coachId: String
status: String // pending, reviewed, assigned, rejected
goal: String
experienceLevel: String
trainingDaysAvailable: int
trainingPlace: String // casa, gimnasio, ambos
equipment: List<String>
limitations: String?
injuriesOrNotes: String?
answers: Map<String, dynamic>
createdAt: DateTime
reviewedAt: DateTime?
assignedRoutineId: String?
coachNotes: String?
```

### Estados

```text
pending   → solicitud enviada por usuario
reviewed  → coach ya la revisó
assigned  → coach asignó una rutina
rejected  → coach la rechazó o pidió corrección
```

---

## CRITERIO DE TERMINACIÓN DE CADA ETAPA

Una etapa está terminada solo si:

- Compila sin errores.
- `flutter analyze` no reporta errores críticos.
- El flujo principal se puede probar manualmente.
- Las reglas de Firestore protegen los datos.
- No se rompió una etapa anterior.
- No se agregaron funcionalidades fuera de alcance.


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
