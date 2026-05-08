# README - CÓMO USAR ESTOS MARKDOWNS CON CODEX

## USO RECOMENDADO

No le des a Codex todo el proyecto y le digas “haceme la app”.

Usá una etapa a la vez.

Para cada etapa:

1. Abrí el proyecto en Codex.
2. Adjuntá o copiá:
   - `00_CONTEXTO_GENERAL_MODIFICADO.md`
   - `01_ROADMAP_ETAPAS.md`
   - El archivo de la etapa activa.
   - `99_PROMPTS_CODEX_POR_ETAPA.md`
3. Pegá el prompt específico de esa etapa.
4. Revisá el diff.
5. Ejecutá o pedile que ejecute `flutter analyze`.
6. No avances hasta que esa etapa quede estable.

---

## REGLA PRÁCTICA

Codex trabaja mejor con tareas concretas.

Mal prompt:

```text
Haceme toda la app Ascend.
```

Buen prompt:

```text
Implementa la Etapa 3: Solicitudes de rutina.
No reestructures el proyecto.
Crea solo los modelos, servicios, pantallas y reglas indicadas.
Al final ejecuta flutter analyze.
```

---

## ORDEN DE TRABAJO

1. `ETAPA_1_FUNDACION.md`
2. `ETAPA_2_AUTENTICACION_ROLES.md`
3. `ETAPA_3_SOLICITUDES_RUTINA.md`
4. `ETAPA_4_BANCO_Y_RUTINAS.md`
5. `ETAPA_5_EJECUCION_REGISTRO.md`
6. `ETAPA_6_PROGRESO.md`
7. `ETAPA_7_SUSCRIPCIONES.md`
8. `ETAPA_8_COMUNIDAD.md`
9. `ETAPA_9_IA_LANZAMIENTO.md`

---

## CONSEJO DIRECTO

Primero sacá el flujo de negocio:

```text
usuario solicita rutina → coach la revisa → coach asigna rutina → usuario la ejecuta
```

Después metés pagos, comunidad e IA.
