# ETAPA 8 - COMUNIDAD BÁSICA

## OBJETIVO

Crear una comunidad simple tipo feed de texto.

No debe distraer del producto principal.

---

## COLECCIÓN

```text
posts
```

---

## MODELO

Crear:

```text
lib/models/post.dart
```

Campos:

```text
id
userId
userName
userPlanType
content
timestamp
likesCount
likedBy
```

---

## SERVICIO

Crear:

```text
lib/services/community_service.dart
```

Métodos:

```text
createPost
getPosts
likePost
unlikePost
deletePost
```

---

## PANTALLAS

Crear:

```text
lib/views/community/community_screen.dart
lib/views/community/create_post_screen.dart
```

---

## RESTRICCIONES

Basic:

- Puede leer.
- No puede publicar.
- No puede dar like.

Pro:

- Puede leer.
- Puede publicar.
- Puede dar/quitar like.
- Puede eliminar sus posts.

Coach/Admin:

- Acceso completo.

---

## VALIDACIÓN

- [ ] Feed carga.
- [ ] Posts ordenados.
- [ ] Basic solo lectura.
- [ ] Pro publica.
- [ ] Pro da like.
- [ ] Autor elimina su post.
- [ ] Admin elimina posts.
- [ ] `flutter analyze` sin errores críticos.

---

## PROMPT PARA CODEX

```text
Implementa la ETAPA 8: Comunidad básica.

Contexto:
- Proyecto Flutter + Firebase con MVC.
- No reestructurar.
- Seguir GUIA_DISENO.md.
- Basic solo lectura.
- Pro puede interactuar.
- Coach/Admin tienen acceso completo.

Tareas:
1. Crear modelo Post con toJson, fromJson y copyWith.
2. Crear CommunityService con:
   - createPost
   - getPosts paginado
   - likePost
   - unlikePost
   - deletePost
3. Crear CommunityScreen:
   - feed
   - pull to refresh
   - infinite scroll básico
   - cards de posts
4. Crear CreatePostScreen:
   - máximo 500 caracteres
   - contador
   - botón publicar
5. Integrar navegación desde UserHome/BottomNav si existe.
6. Aplicar restricciones Basic/Pro.
7. Actualizar Security Rules de posts.
8. No implementes comentarios, chat ni imágenes.
9. Ejecuta flutter analyze y corrige errores.

Criterios:
- Basic lee pero no interactúa.
- Pro publica y da like.
- Autor elimina sus posts.
- Seguridad backend activa.
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
