#import "intro.typ": conf, pronombre

// Aquí se importan las guías para ayudar a escribir.
// Se pueden desactivar cambiando el valor de la variable `mostrar_guias` a `false`.
#import "intro_guias.typ": *
#let mostrar_guias = true

#show: conf.with(
    titulo: "El Título de mi Tema",
    autor: (nombre: "María Echón", pronombre: pronombre.elle),
    profesores: ((nombre: "Juan Pérez", pronombre: pronombre.el),),
    coguias: ((nombre: "Juana Pérez", pronombre: pronombre.ella),),
    supervisor: (nombre: "María Gómez", pronombre: pronombre.ella),
    anno: "2023",
    espaciado_titulo: 2fr,
)

#guia(visible: mostrar_guias, guia_meta)

= Introducción

#guia(visible: mostrar_guias, guia_intro)

= Situación Actual

#guia(visible: mostrar_guias, guia_actual)

Ejemplos de referencias:
- Conferencia: @CorlessJK97
- Revista y Tesis: @NewmanT42 @Turing38 

= Objetivos

#guia(visible: mostrar_guias, guia_objetivos)

== Objetivo General

#guia(visible: mostrar_guias, guia_objetivo_general)

== Objetivos Específicos

#guia(visible: mostrar_guias, guia_objetivos_especificos)

+ ...
+ ...

== Evaluación

#guia(visible: mostrar_guias, guia_evaluacion)

= Solución Propuesta

#guia(visible: mostrar_guias, guia_solucion)

= Plan de Trabajo (Preliminar)

#guia(visible: mostrar_guias, guia_plan)

+ ...
+ ...

#bibliography(
    "bibliografia.yml",
    title: "Referencias",
    style: "ieee",
)