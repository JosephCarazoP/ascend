# PROMPTS CODEX POR ETAPA - ASCEND

## PROMPT MAESTRO

Usá este al inicio de cualquier etapa.

```text
Estás trabajando en Ascend, una app Flutter + Firebase para rutinas de entrenamiento personalizadas.

Reglas obligatorias:
- Mantener Flutter + Firebase.
- Mantener arquitectura MVC.
- No reestructurar carpetas.
- No borrar código funcional.
- No duplicar lógica existente.
- No implementar funcionalidades fuera de la etapa activa.
- Seguir GUIA_DISENO.md.
- Respetar roles: admin, coach, usuario.
- Coach/Admin no requieren Plan Pro.
- Usuario Basic puede solicitar rutina, pero no ejecutar ni guardar progreso.
- Usuario Pro puede ejecutar rutina, registrar pesos/reps y ver progreso.
- Al terminar, ejecutar flutter analyze y corregir errores.

Antes de modificar:
1. Inspecciona archivos existentes relacionados.
2. Identifica qué ya está hecho.
3. Modifica solo lo necesario.

Entrega:
- Archivos modificados.
- Cambios principales.
- Errores corregidos.
- Pendientes reales.
```

---

## ETAPA 1

```text
Implementa o valida la Etapa 1: Fundación y Firebase.

No crear UI avanzada.
Verifica estructura MVC, dependencias Firebase, modelos base y servicios base.
Crea lo faltante sin reestructurar.
Ejecuta flutter analyze.
```

---

## ETAPA 2

```text
Implementa la Etapa 2: Autenticación, roles y navegación protegida.

Crea o completa login, register, forgot password, AuthController, RoleController, NavigationController y RouteGuard.
Implementa redirección por rol.
Crea dashboard básico admin y coach si falta.
No implementes rutinas ni solicitudes todavía.
Ejecuta flutter analyze.
```

---

## ETAPA 3

```text
Implementa la Etapa 3: Solicitudes de rutina.

Crea RoutineRequest, RoutineRequestService, RoutineRequestController, pantallas de usuario para solicitar/ver solicitudes y pantallas de coach para revisar solicitudes.
Agrega Security Rules para routine_requests.
Usuario Basic puede solicitar rutina.
No implementes ejecución de rutinas.
Ejecuta flutter analyze.
```

---

## ETAPA 4

```text
Implementa la Etapa 4: Banco de ejercicios y gestión de rutinas.

Crea banco de ejercicios, CRUD de rutinas, selector de descanso, asignación de rutina a clientes y conexión con solicitudes.
Si una rutina se asigna desde una solicitud, actualiza la solicitud como assigned.
No implementes ejecución todavía.
Ejecuta flutter analyze.
```

---

## ETAPA 5

```text
Implementa la Etapa 5: Ejecución de rutina y registro.

Usuario Pro puede iniciar rutina, registrar peso/reps, usar cronómetro, avanzar ejercicios y guardar WorkoutSession.
Usuario Basic queda bloqueado.
Coach/Admin pueden ejecutar sin pagar.
Ejecuta flutter analyze.
```

---

## ETAPA 6

```text
Implementa la Etapa 6: Progreso.

Crea ProgressController, pantalla Mi Progreso y pantalla Progreso del Cliente.
Calcula última sesión, récords y últimas sesiones.
Coach solo ve sus clientes.
Ejecuta flutter analyze.
```

---

## ETAPA 7

```text
Implementa la Etapa 7: Suscripciones y Plan Pro.

Completa SubscriptionService, pantallas de plan/upgrade y bloqueos Basic/Pro.
No cambies que Coach/Admin no pagan.
No implementes comunidad ni IA.
Ejecuta flutter analyze.
```

---

## ETAPA 8

```text
Implementa la Etapa 8: Comunidad básica.

Crea Post, CommunityService, CommunityScreen y CreatePostScreen.
Basic solo lee.
Pro publica y da likes.
No implementes chat ni comentarios.
Ejecuta flutter analyze.
```

---

## ETAPA 9

```text
Implementa la Etapa 9: IA, pulido y lanzamiento.

Crea AIService y ClientInsightsScreen.
IA solo genera insights para coach y no modifica datos.
No hardcodees API keys.
Revisa flujos críticos, estados vacíos, loading, errores, Security Rules y build.
Ejecuta flutter analyze.
```

---

## PROMPT DE AUDITORÍA DESPUÉS DE CADA ETAPA

```text
Audita la etapa recién implementada.

Revisa:
- Errores de compilación.
- Errores de arquitectura.
- Código duplicado.
- Accesos inseguros.
- Inconsistencias con roles.
- Inconsistencias con Plan Basic/Pro.
- Pantallas que no siguen GUIA_DISENO.md.
- Funcionalidades fuera de alcance.

No implementes features nuevas.
Solo corrige bugs o problemas reales.
Ejecuta flutter analyze al final.
```

---

## PROMPT PARA CORREGIR ERRORES SIN INVENTAR

```text
Corrige únicamente los errores actuales.

Reglas:
- No agregues funcionalidades nuevas.
- No reestructures.
- No cambies nombres públicos salvo que sea necesario.
- No borres código funcional.
- Explica cada cambio.
- Ejecuta flutter analyze al final.
```
