# ORDEN PROPUESTO - APP FLUTTER (ASCEND)

> Documento para ordenar la app Flutter sin romper MVC ni adelantar etapas.

## 1) Estructura objetivo

```text
lib/
├── app/
│   ├── app.dart
│   ├── routes/
│   └── theme/
├── models/
├── views/
│   ├── screens/
│   ├── widgets/
│   └── shared/
├── controllers/
├── services/
├── utils/
└── main.dart
```

## 2) Reglas de orden

- Mantener MVC.
- No mover archivos funcionales sin actualizar imports.
- No introducir patrones nuevos (Bloc/Riverpod/Clean Architecture) sin autorización.
- Un archivo por responsabilidad.
- Nombrado en `snake_case.dart`.

## 3) Orden por etapas

### Etapa 1 (actual)

- Definir modelos base en `lib/models/`.
- Definir servicios base en `lib/services/`.
- Mantener UI mínima.

### Etapa 2+

- Agregar pantallas por módulo en `views/screens/`.
- Reutilizar widgets en `views/widgets/`.
- Centralizar helpers en `utils/`.

## 4) Checklist de orden

- [ ] `lib/models` contiene solo modelos de datos.
- [ ] `lib/services` contiene acceso a Firebase/APIs.
- [ ] `lib/controllers` contiene lógica de flujo.
- [ ] `lib/views` contiene UI (pantallas/widgets).
- [ ] `main.dart` solo arranque e inyección base.
