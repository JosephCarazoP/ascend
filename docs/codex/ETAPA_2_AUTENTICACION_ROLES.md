# ETAPA 2 - AUTENTICACIÓN, ROLES Y NAVEGACIÓN

## OBJETIVO

Implementar login, registro, recuperación de contraseña, roles y navegación protegida.

---

## ROLES

```text
admin
coach
usuario
```

## JERARQUÍA

```text
Admin = Admin + Coach + Usuario
Coach = Coach + Usuario
Usuario = Usuario
```

Admin y coach no requieren Plan Pro.

---

## TAREAS

### 1. Pantallas Auth

Crear o validar:

```text
lib/views/auth/login_screen.dart
lib/views/auth/register_screen.dart
lib/views/auth/forgot_password_screen.dart
```

### 2. Controlador Auth

Crear o validar:

```text
lib/controllers/auth_controller.dart
```

Métodos:

```text
login(email, password)
register(email, password, rol)
logout()
resetPassword(email)
```

### 3. RoleController

Crear o validar:

```text
lib/controllers/role_controller.dart
```

Métodos:

```text
checkRole(userId)
isAdmin(userId)
isCoach(userId)
isUsuario(userId)
hasPermission(userId, action)
requiresSubscription(userId, action)
```

### 4. NavigationController

Crear o validar:

```text
lib/controllers/navigation_controller.dart
```

Rutas:

```text
admin  → /admin/dashboard
coach  → /coach/dashboard
usuario → /user/home
```

### 5. RouteGuard

Crear o validar:

```text
lib/utils/route_guard.dart
```

### 6. Panel Admin básico

Admin debe poder:

- Ver usuarios.
- Ver roles.
- Ver planType.
- Asignar coach a usuario.

### 7. Panel Coach básico

Coach debe poder:

- Ver sus clientes asignados.
- Ver acceso a solicitudes en etapa siguiente.
- Ver acceso futuro a rutinas.

---

## VALIDACIÓN

- [ ] Login funcional.
- [ ] Registro funcional.
- [ ] Recuperación funcional.
- [ ] Redirección según rol.
- [ ] Rutas protegidas.
- [ ] Admin puede asignar coach.
- [ ] Coach ve sus clientes.
- [ ] Usuario no entra a admin/coach.
- [ ] `flutter analyze` sin errores críticos.

---

## PROMPT PARA CODEX

```text
Implementa la ETAPA 2: Autenticación, roles y navegación protegida.

Contexto:
- Proyecto Flutter + Firebase.
- Arquitectura MVC obligatoria.
- Ya debe existir base de modelos y servicios.
- No reestructurar carpetas.
- Seguir GUIA_DISENO.md.

Tareas:
1. Crear o completar pantallas:
   - login_screen.dart
   - register_screen.dart
   - forgot_password_screen.dart
2. Crear o completar AuthController con login, register, logout y resetPassword.
3. Crear o completar RoleController con jerarquía acumulativa:
   - admin tiene todo
   - coach tiene permisos de coach + usuario
   - usuario solo usuario
4. Crear o completar NavigationController.
5. Crear o completar RouteGuard.
6. Implementar redirección:
   - admin → /admin/dashboard
   - coach → /coach/dashboard
   - usuario → /user/home
7. Crear o validar AdminDashboard básico para listar usuarios y asignar coach.
8. Crear o validar CoachDashboard básico para listar clientes asignados.
9. No implementes rutinas, solicitudes, pagos, comunidad ni IA en esta etapa.
10. Ejecuta flutter analyze y corrige errores.

Entrega:
- Archivos modificados.
- Flujo probado.
- Cualquier pendiente real.
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
