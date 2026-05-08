# AGENTS.md - Proyecto Ascend

## Descripción del proyecto

Ascend es una aplicación Flutter + Firebase para rutinas de entrenamiento personalizadas.

El flujo principal del negocio es:

1. Usuario crea perfil.
2. Usuario solicita una rutina mediante formulario.
3. Coach revisa la solicitud.
4. Coach crea o asigna una rutina.
5. Usuario ejecuta la rutina desde el celular.
6. Usuario registra peso, repeticiones y progreso.
7. Coach puede revisar el avance del usuario.

## Stack obligatorio

- Frontend: Flutter
- Backend: Firebase
  - Firebase Authentication
  - Cloud Firestore
  - Firebase Security Rules
  - Firebase Storage cuando aplique
- Arquitectura: MVC

## Reglas obligatorias

- No reestructurar la arquitectura MVC.
- No introducir Clean Architecture, Bloc, Riverpod u otro patrón nuevo salvo autorización explícita.
- No eliminar código funcional existente.
- No duplicar lógica.
- No reescribir funcionalidades completas si se pueden extender.
- No adelantarse a etapas futuras.
- Trabajar una etapa a la vez.
- Seguir los documentos ubicados en `docs/codex/`.
- Antes de implementar una etapa, leer:
  - `docs/codex/00_CONTEXTO_GENERAL_MODIFICADO.md`
  - `docs/codex/01_ROADMAP_ETAPAS.md`
  - el archivo específico de la etapa solicitada.

## Diseño

- Seguir la guía de diseño del proyecto si existe en `docs/codex/`.
- Mantener consistencia visual.
- Respetar colores, tipografías, espaciados y componentes definidos.
- No inventar un nuevo sistema visual.

## Validación

Después de modificar código Flutter o Dart, ejecutar:

```bash
flutter pub get
flutter analyze
```
