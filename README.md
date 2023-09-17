# Template Propuesta/Informe de memoria DCC FCFM

> [Typst](https://typst.app) es software relativamente nuevo que está creciendo muy rápidamente. Por esto, no puedo asegurar retrocompatibilidad entre versiones del template.

Puedes ver un ejemplo de documento en [example.pdf](example.pdf).

Basado en la plantilla para LaTeX U-Memoria v1.5 de Nikolas Tapia M. modificada por Aidan Hogan.

## Ejemplo de uso

```typ
#import "conf.typ": conf, pronombre
#show: conf.with(
    titulo: "El Título de mi Tema",
    autor: (nombre: "Estudiante DCC", pronombre: pronombre.el),
    profesores: ((nombre: "Profesora 1", pronombre: pronombre.ella),),
)

... el resto del documento empieza aquí ...
```

Puedes ver un ejemplo más completo en [example.typ](example.typ). Para aprender la sintáxis de Typst existe la [documentación oficial](https://typst.app/docs).

## Parámetros de configuración

La función `conf` recibe los siguientes parámetros:

| Parámetro          | Descripción                                                                                                                                     |
| ------------------ | ----------------------------------------------------------------------------------------------------------------------------------------------- |
| `título`           | El título del tema                                                                                                                              |
| `autor`            | Diccionario* con Nombre completo de estudiante y pronombre                                                                                      |
| `informe`          | `false` si es la propuesta de tema, `true` si es el informe final                                                                               |
| `codigo`           | Omitir si es la propuesta de tema. <br> Si es el informe final, colocar el código del ramo. (CC6908 para malla v3, CC6907 para malla v5)        |
| `modalidad`        | Modalidad del trabajo. Puede ser \"Memoria\", \"Práctica extendida\", \"Titulación con Magíster\" o \"Doble Titulación de Dos Especialidades\"  |
| `profesores`       | Lista de profesores guías. Si es uno: (Diccionario*,). Si son dos: (Diccionario1*,Diccionario2*)                                                |
| `coguias`          | Lista de profesores co-guías. Si es uno: (Diccionario*,). Si son dos: (Diccionario1*,Diccionario2*)                                             |
| `supervisor`       | Diccionario* con Nombre y pronombre del supervisor en caso de práctica extendida                                                                |
| `anno`             | Año en que se entrega el informe. Por defecto se usa el año actual.                                                                             |
| `espaciado_titulo` | espacio extra que rodea al título y al nombre en la portada, 1fr es lo mismo que el resto de espacios, 2fr es el doble, 0.5fr es la mitad, etc. |

*Nota: El diccionario debe contener los campos `nombre` y `pronombre` con el nombre completo y pronombre de la persona. El pronombre puede ser `pronombre.el`, `pronombre.ella` o `pronombre.elle` y para usarse debe ser importado con `#import "conf.typ": pronombre`.

## Cómo usar el template

### Opción 1: Usar el template de forma local

[Instalar Typst CLI](https://github.com/typst/typst#instalación), clonar el repositorio y trabajar de manera local en un editor. Adicionalmente, puedes instalar un [LSP](https://github.com/nvarner/typst-lsp).

### Opción 2: Usar en la app web

Esta opción no se recomienda del todo, ya que no siempre estará actualizada con la última versión del template.

1. Crear cuenta o iniciar sesión en [Typst.app](https://typst.app/)
2. Abrir el siguiente [Proyecto](https://typst.app/project/rlXex0o5Qilf1gycQycqiH)
3. En el [Dashboard](https://typst.app/) podrás ver el proyecto "Template Memoria DCC FCFM" en la sección "Shared with me". Puedes presionar el botón `Duplicate` (aparece al posicionar el mouse sobre el proyecto) para crear una copia del proyecto en tu cuenta.

## Changelog

### v1.2.0

* Se modifica el espaciado entre elementos de la portada para que sea uniforme.
* Se agrega parámetro `espaciado_titulo` para modificar el espaciado extra al rededor del título en la portada.

### v1.1.1

* Arreglado `else` en `#if` que no funcionaba en typst v0.8.0

### v1.1.0

* Se agrega uso de pronombres para portada (BREAKING CHANGE)
* Se agrega parámetro `coguias` para profesores co-guías
* Formato de párrafos corregido

### v1.0.0

* Primera versión