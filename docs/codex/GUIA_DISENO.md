# GUIA DE DISENO - ASCEND

## Principio visual

Ascend debe verse minimalista, moderna y sobria, con una interfaz cercana a
shadcn ui:

- Superficies limpias.
- Bordes definidos.
- Componentes simples.
- Jerarquia tipografica clara.
- Espaciado consistente.
- Nada decorativo que no ayude al flujo.

## Paleta

La app debe usar solo:

- Blanco.
- Negro.
- Matices de gris derivados de blanco/negro para bordes, fondos y texto secundario.
- Verde como acento puntual.

El verde se reserva para:

- Estados positivos.
- Acciones principales cuando convenga destacar.
- Indicadores de progreso o confirmacion.
- Pequenos acentos visuales.

No usar paletas moradas, azules, beige, naranjas ni gradientes decorativos.

## Modo claro y oscuro

La app debe permitir cambiar entre modo claro y modo oscuro.

Reglas:

- El modo claro usa fondo blanco, texto negro y bordes grises.
- El modo oscuro usa fondo negro, texto blanco y bordes grises oscuros.
- El verde debe funcionar en ambos modos.
- El cambio de tema debe estar disponible desde la interfaz principal.

## Componentes

- Botones con borde de radio maximo de 8 px.
- Cards planas, con borde visible y sin elevacion decorativa.
- Inputs con borde definido.
- AppBars limpias, sin color fuerte de fondo.
- Iconos simples para acciones frecuentes.
- Evitar bloques grandes de texto explicativo dentro de la app.

## Regla para nuevas pantallas

Toda pantalla nueva debe reutilizar el tema global de Flutter. No definir
paletas locales salvo que sea estrictamente necesario y siga esta guia.
