# ROADMAP POR ETAPAS - ASCEND

## OBJETIVO GENERAL

Construir Ascend como una app móvil de entrenamiento personalizada donde:

- El usuario crea un perfil.
- Solicita una rutina.
- El coach revisa la solicitud.
- El coach crea/asigna una rutina.
- El usuario ejecuta la rutina desde el celular.
- El usuario registra pesos y repeticiones.
- El coach ve el progreso.

---

## ETAPA 1: Fundación y Firebase

### Objetivo
Dejar el proyecto Flutter + Firebase funcional, con MVC estable y modelos base.

### Resultado esperado
Proyecto compila, Firebase queda conectado, estructura MVC lista.

---

## ETAPA 2: Autenticación, roles y navegación

### Objetivo
Permitir login, registro, recuperación de contraseña, roles y navegación protegida.

### Resultado esperado
Admin, coach y usuario entran a pantallas diferentes según su rol.

---

## ETAPA 3: Solicitudes de rutina

### Objetivo
Permitir que el usuario solicite una rutina llenando un formulario y que el coach vea esas solicitudes.

### Resultado esperado
Colección `routine_requests` funcionando.

Este flujo se agrega antes de crear rutinas completas porque es la conexión real entre usuario y coach.

---

## ETAPA 4: Banco de ejercicios y rutinas

### Objetivo
Permitir que el coach cree ejercicios reutilizables y rutinas completas.

### Resultado esperado
Coach puede crear, editar, duplicar, eliminar y asignar rutinas.

---

## ETAPA 5: Ejecución y registro

### Objetivo
Permitir que el usuario ejecute una rutina desde el celular.

### Resultado esperado
Usuario puede iniciar rutina, avanzar ejercicios, registrar peso/reps y guardar sesión.

---

## ETAPA 6: Progreso

### Objetivo
Mostrar progreso al usuario y al coach.

### Resultado esperado
Usuario ve su historial; coach ve progreso de sus clientes.

---

## ETAPA 7: Suscripciones

### Objetivo
Activar Plan Pro después de validar el flujo principal.

### Resultado esperado
Plan Basic limitado y Plan Pro con ejecución, cronómetro, registro y progreso.

---

## ETAPA 8: Comunidad

### Objetivo
Agregar comunidad básica tipo feed.

### Resultado esperado
Basic lee; Pro interactúa.

---

## ETAPA 9: IA y lanzamiento

### Objetivo
Agregar IA como apoyo al coach, pulir app y preparar stores.

### Resultado esperado
App estable, probada y lista para lanzamiento.

---

## PRIORIDAD REAL

1. Solicitud de rutina.
2. Rutina asignada.
3. Ejecución de rutina.
4. Registro de progreso.
5. Visualización de progreso.

Todo lo demás es secundario.


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
