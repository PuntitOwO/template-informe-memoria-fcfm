# Template Propuesta/Informe de memoria DCC FCFM

> [Typst](https://typst.app) es software relativamente nuevo que está creciendo muy rápidamente. Por esto, no puedo asegurar retrocompatibilidad entre versiones del template, ni compatibilidad con la última versión de Typst.

Puedes ver un ejemplo de los documentos en [example_intro.pdf](example_intro.pdf) para el documento de propuesta e informe de memoria para intro al trabajo de título, y en [example_final.pdf](example_final.pdf) para el documento de de memoria y tesis final.

Basado en la plantilla para LaTeX U-Memoria v1.5 de Nikolas Tapia M. modificada por Aidan Hogan.

## Ejemplo de uso

Primero crea un diccionario con los parámetros de configuración de tu trabajo, y luego usa la función `conf` de `intro.typ` para generar el documento correspondiente:

```typ
#import "intro.typ": conf
#import "constants.typ": pronombre

#let data = (
    titulo: "EL TÍTULO DE MI TEMA",
    autoria: (nombre: "ESTUDIANTE DCC", pronombre: pronombre.el),
    profesores: ((nombre: "PROFESORA 1", pronombre: pronombre.ella),),
)

#show: conf.with(metadata: data)

... el resto del documento empieza aquí ...
```

Para el caso de la memoria y tesis final, se usa `final.typ`:

```typ
#import "final.typ": conf, resumen, dedicatoria, agradecimientos, start-doc, capitulo, end-doc, apendice
#import "constants.typ": pronombre

#let data = (
    titulo: "EL TÍTULO DE MI TEMA",
    autoria: (nombre: "ESTUDIANTE DCC", pronombre: pronombre.el),
    profesores: ((nombre: "PROFESORA 1", pronombre: pronombre.ella),),
)

#show: conf.with(metadata: data)

#resumen(metadata: data)[... resumen ...]

#dedicatoria[... dedicatoria ...]

#show: start-doc

#capitulo(title: "Introducción")[... introducción ...]

#show: end-doc

#apendice(title: "Anexo")[... apéndice ...]
```

Puedes ver un ejemplo más completo en [example_intro.typ](example_intro.typ) y [example_final.typ](example_final.typ). Para aprender la sintáxis de Typst existe la [documentación oficial](https://typst.app/docs).

## Parámetros de configuración

El diccionario de configuración se detalla a continuación. Es importante notar que el diccionario es compartido entre los distintos métodos de `intro.typ` y `final.typ`, por lo que se puede reutilizar.

| Parámetro          | Descripción                                                                                                                                     |
| ------------------ | ----------------------------------------------------------------------------------------------------------------------------------------------- |
| `titulo`           | El título del tema                                                                                                                              |
| `autoria`          | Diccionario* con Nombre completo de estudiante y pronombre                                                                                      |
| `profesores`       | Lista de Diccionarios* de profesores guías.                                                                                                     |
| `coguias`          | Lista de Diccionarios* de profesores co-guías.                                                                                                  |
| `grado-titulo`     | Título a obtener. Por defecto se espera que sea "COMPUTACIÓN"                                                                                   |
| `anno`             | Año en que se entrega el informe. Si es none, se usa el año actual.                                                                             |
| `espaciado_titulo` | Espacio extra que rodea al título y al nombre en la portada, 1fr es lo mismo que el resto de espacios, 2fr es el doble, 0.5fr es la mitad, etc. |
| `intro`            | Configuración específica para el informe del ramo de introducción al trabajo de título.                                                         |
| `final`            | Configuración específica para el informe final.                                                                                                 |

*Nota: El diccionario debe contener los campos `nombre` y `pronombre` con el nombre completo (con ambos apellidos) y pronombre de la persona. El pronombre puede ser `pronombre.el`, `pronombre.ella` o `pronombre.elle` y para usarse debe ser importado con `#import "constants.typ": pronombre`.

### Parámetros específicos de `intro`

| Parámetro          | Descripción                                                                                                                                     |
| ------------------ | ----------------------------------------------------------------------------------------------------------------------------------------------- |
| `informe`          | `false` si es la propuesta de tema, `true` si es el informe final                                                                               |
| `codigo`           | Omitir si es la propuesta de tema. <br> Si es el informe final, colocar el código del ramo. (CC6908 para malla v3, CC6907 para malla v5)        |
| `modalidad`        | Modalidad del trabajo. Puede ser \"Memoria\", \"Práctica extendida\", \"Titulación con Magíster\" o \"Doble Titulación de Dos Especialidades\"  |
| `supervision`      | Diccionario* con Nombre y pronombre de la persona supervisora en caso de práctica extendida                                                     |

### Parámetros específicos de `final`

| Parámetro          | Descripción                                                                                                                                     |
| ------------------ | ----------------------------------------------------------------------------------------------------------------------------------------------- |
| `tesis`            | `false` si es una memoria, `true` si es una tesis de magíster o doble titulación                                                                |
| `memoria`          | `true` si es una memoria o doble titulación, `false` si es solo una tesis de magíster                                                           |
| `auspicio`         | Un string o contenido con el auspicio en caso de que la tesis sea auspiciada por alguna institución. Puede ser `none` si no hay auspicio.       |
| `grado-magister`   | Grado de magíster a obtener. Por defecto se espera que sea "COMPUTACIÓN"                                                                        |
| `comision`         | Lista de nombres (No diccionarios, ya que sus pronombres no se usan) de profesores de la comisión.                                              |

## Cómo usar el template

### Opción 1: Usar el template de forma local

[Instalar Typst CLI](https://github.com/typst/typst#installation), clonar este repositorio y trabajar de manera local en un editor. En VSCode, puedes usar la extensión [Tinymist Typst](https://marketplace.visualstudio.com/items?itemName=myriad-dreamin.tinymist).

### Opción 2: Usar en la app web de Typst

> [!WARNING]
> La última versión del proyecto disponible es la v1.2.0. Si deseas utilizar la última versión, deberás subir manualmente el proyecto a la [web app](https://typst.app/).

1. Crear cuenta o iniciar sesión en [Typst.app](https://typst.app/)
2. Abrir el siguiente [Proyecto](https://typst.app/project/rlXex0o5Qilf1gycQycqiH)
3. En el [Dashboard](https://typst.app/) podrás ver el proyecto "Template Memoria DCC FCFM" en la sección "Shared with me". Puedes presionar el botón `Duplicate` (aparece al posicionar el mouse sobre el proyecto) para crear una copia del proyecto en tu cuenta.

## Changelog

### v2.0.0

* Se actualiza soporte para Typst v0.13.0
* Se añade soporte para doble titulación
* Se reemplazan los parámetros de los métodos por un diccionario de configuración por reutilización

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