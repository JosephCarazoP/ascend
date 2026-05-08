# ETAPA 7 - SUSCRIPCIONES Y PLAN PRO

## OBJETIVO

Implementar el sistema de Plan Pro después de validar el flujo principal.

---

## DECISIÓN

No implementar pagos antes de que funcione:

```text
solicitud → rutina → ejecución → progreso
```

---

## PLANES

### Basic

Puede:

- Registrarse.
- Solicitar rutina.
- Ver estado de solicitud.
- Ver información general.
- Ver comunidad solo lectura si existe.

No puede:

- Ejecutar rutina.
- Usar cronómetro.
- Registrar pesos.
- Guardar progreso.
- Interactuar en comunidad.

### Pro

Puede:

- Ejecutar rutina.
- Registrar progreso.
- Ver progreso.
- Interactuar en comunidad.

---

## MÉTODOS DE PAGO

Para stores:

- Android: Google Play Billing / in_app_purchase.
- iOS: App Store In-App Purchase / in_app_purchase.

Para validación temprana fuera de stores:

- Puede mantenerse manualmente el campo `planType` desde admin.
- No automatizar cobros manuales dentro de esta etapa salvo que sea un requisito real.

---

## SERVICIO

Actualizar:

```text
lib/services/subscription_service.dart
```

Métodos:

```text
initialize()
getProducts()
purchaseSubscription()
verifyPurchase()
restorePurchases()
updateUserPlanType()
hasActiveSubscription()
validatePlanPro()
```

---

## PANTALLAS

Crear o validar:

```text
lib/views/subscription/plan_screen.dart
lib/views/subscription/upgrade_screen.dart
```

---

## VALIDACIÓN

- [ ] Basic bloqueado.
- [ ] Pro habilitado.
- [ ] Coach/Admin no pagan.
- [ ] Restore purchases funciona si aplica.
- [ ] Security Rules bloquean escritura Basic.
- [ ] `flutter analyze` sin errores críticos.

---

## PROMPT PARA CODEX

```text
Implementa la ETAPA 7: Suscripciones y Plan Pro.

Contexto:
- Proyecto Flutter + Firebase con MVC.
- El flujo principal ya funciona.
- No reestructurar.
- Seguir GUIA_DISENO.md.
- Coach y Admin nunca pagan.
- Usuario Basic puede solicitar rutina, pero no ejecutar ni guardar progreso.
- Usuario Pro sí puede ejecutar y guardar.

Tareas:
1. Revisar SubscriptionService existente.
2. Implementar o completar:
   - validatePlanPro
   - hasActiveSubscription
   - updateUserPlanType
   - restorePurchases
   - purchaseSubscription si ya está listo el producto.
3. Crear o completar:
   - plan_screen.dart
   - upgrade_screen.dart
4. Integrar bloqueo visual en:
   - routine_detail_screen
   - workout_screen
   - progress_screen
   - community interactions si existen.
5. Confirmar que Coach/Admin no requieren Plan Pro.
6. Actualizar Security Rules si hace falta.
7. No implementes comunidad ni IA en esta etapa.
8. Ejecuta flutter analyze y corrige errores.

Criterios:
- Basic no escribe workout_sessions.
- Basic no ejecuta rutinas.
- Pro ejecuta y guarda.
- Coach/Admin tienen acceso completo sin pagar.
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
