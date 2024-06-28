#import "final.typ": conf, guia, pronombre, resumen, dedicatoria, agradecimientos, start-doc, capitulo
#let mostrar_guias = true
#show: conf.with(
    titulo: "TÍTULO DE LA MEMORIA/TESIS",
    autor: (nombre: "MARÍA ECHÓN", pronombre: pronombre.elle),
    profesores: ((nombre: "JUAN PÉREZ", pronombre: pronombre.el),),
    coguias: ((nombre: "JUAN PÉREZ", pronombre: pronombre.ella),),
    comision: ("NOMBRE COMPLETO UNO", "NOMBRE COMPLETO DOS", "NOMBRE COMPLETO TRES"),
    anno: "2023",
    espaciado_titulo: 2fr,
)

#resumen[
    #lorem(150)
    
    #lorem(100)
    
    #lorem(100)
]

#dedicatoria[
    Una dedicatoria especial para alguien especial.
]

#agradecimientos[
    #lorem(150)
    
    #lorem(100)
    
    #lorem(100)
]

#show: start-doc

#capitulo(title: "Introducción")[
    #lorem(100)
    
    #lorem(100)
    
    #lorem(100)
]

#capitulo(title: "Segundo")[
    #lorem(100)
    
    #lorem(50)

    #figure(
        table(
            columns: 3,
            "Campo 1", "Campo 2", "Num",
            "Valor 1a", "Valor 2a", "3",
            "Valor 1b", "Valor 2b", "3",
        ),
        caption: "Tabla 1",
    )

    #figure(
        table(
            columns: 3,
            "Campo 1", "Campo 2", "Num",
            "Valor 1a", "Valor 2a", "3",
            "Valor 1b", "Valor 2b", "3",
        ),
        caption: "Tabla 2",
    )
    
    #lorem(100)
]

#capitulo(title: "Tercero")[
    #lorem(100)
    
    #lorem(50)

    #figure(
        image("imagenes/institucion/fcfm.svg", width: 20%),
        caption: "Logo de la facultad",
    )
    
    #lorem(100)
]

#capitulo(title: "Conclusión")[
    #lorem(100)
    
    #lorem(100)
    
    #lorem(100)
]

#bibliography(
    "bibliografia.yml",
    title: "Referencias",
    style: "ieee",
)