# ETAPA 9 - IA, PULIDO Y LANZAMIENTO

## OBJETIVO

Agregar IA como apoyo al coach, pulir la app y preparar lanzamiento.

---

## IA COMO APOYO

La IA no crea rutinas automáticamente en esta etapa.

Solo puede:

- Resumir progreso.
- Dar insights simples.
- Ayudar al coach a interpretar datos.
- Generar recomendaciones generales que el coach revisa.

No puede:

- Modificar Firestore directamente.
- Asignar rutinas.
- Cambiar planes.
- Tomar decisiones por el coach.
- Ver clientes ajenos.

---

## SERVICIO IA

Crear:

```text
lib/services/ai_service.dart
```

Métodos:

```text
generateProgressSummary(userId, timeframe)
generateInsights(sessions)
generateGeneralAdvice(userData, recentProgress)
```

Recomendación producción:

- No guardar API keys en Flutter.
- Usar backend/Cloud Functions para llamar IA.

---

## PANTALLA COACH

Crear:

```text
lib/views/coach/client_insights_screen.dart
```

Debe mostrar:

- Resumen.
- Consistencia.
- Mejoras destacadas.
- Áreas de atención.
- Sugerencias generales.
- Disclaimer: "Generado por IA. Úsalo como referencia."

---

## PULIDO FINAL

Revisar:

- Auth.
- Roles.
- Solicitudes.
- Rutinas.
- Ejecución.
- Progreso.
- Plan Pro.
- Comunidad.
- Security Rules.
- Performance.
- Diseño.
- Mensajes de error.
- Estados vacíos.

---

## LANZAMIENTO

Preparar:

- Iconos.
- Splash.
- Screenshots.
- Política de privacidad.
- Términos.
- Descripción app.
- Build Android.
- Build iOS.
- Testing en dispositivo real.

---

## VALIDACIÓN

- [ ] IA no modifica datos.
- [ ] Coach ve insights solo de sus clientes.
- [ ] API key no está hardcodeada.
- [ ] App estable.
- [ ] Flujos críticos probados.
- [ ] Build release generado.
- [ ] `flutter analyze` sin errores críticos.

---

## PROMPT PARA CODEX

```text
Implementa la ETAPA 9: IA, pulido y lanzamiento.

Contexto:
- Proyecto Flutter + Firebase con MVC.
- El flujo principal ya funciona.
- No reestructurar.
- Seguir GUIA_DISENO.md.
- La IA solo apoya al coach. No toma decisiones.

Tareas IA:
1. Crear AIService.
2. Crear ClientInsightsScreen.
3. Obtener datos de workout_sessions de un cliente del coach.
4. Procesar métricas básicas:
   - total entrenamientos
   - frecuencia
   - ejercicios más frecuentes
   - progreso de pesos
   - consistencia
5. Generar texto de insights.
6. Mostrar disclaimer.
7. No permitir que IA escriba en Firestore.
8. No hardcodear API key en Flutter.

Tareas pulido:
1. Revisar estados vacíos.
2. Revisar loading states.
3. Revisar mensajes de error.
4. Revisar navegación.
5. Revisar Security Rules.
6. Revisar performance.
7. Ejecutar flutter analyze.

Tareas lanzamiento:
1. Verificar configuración Android/iOS.
2. Preparar checklist de build.
3. No subir credenciales.
4. Documentar pendientes reales.

Criterios:
- Coach ve insights solo de sus clientes.
- IA no modifica datos.
- App compila estable.
- Flujos críticos no se rompen.
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
