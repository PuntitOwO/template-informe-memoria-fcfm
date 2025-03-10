#import "constants.typ": *

#let conf(
    titulo: none,
    autor: none, // diccionario con nombre y pronombre, (nombre: "", pronombre: pronombre.<el/ella/elle>) 
    informe: false, // false para propuesta, true para informe
    codigo: "CC6908", // CC6908 para malla v3, CC6907 para malla v5
    modalidad: "Memoria", // puede ser Memoria, Práctica Extendida, Doble Titulación con Magíster,Doble Titulación de Dos Especialidades
    profesores: (), // si es solo un profesor guía, una lista de un elemento es ((nombre: "nombre apellido", pronombre: pronombre.<el/ella/elle>),))
    coguias: (), // si es solo un profesor co-guía, una lista de un elemento es ((nombre: "nombre apellido", pronombre: pronombre.<el/ella/elle>),))
    supervisor: none, // solo en caso de práctica extendida llenar esto, en otro caso none, (nombre: "nombre apellido", pronombre: pronombre.<el/ella/elle>)
    anno: none, // si no se especifica, se usa el año actual
    espaciado_titulo: 1fr, // espacio extra que rodea al título y al nombre en la portada, 1fr es lo mismo que el resto de espacios, 2fr es el doble, etc.
    doc,
) = {
    // Formato de página
    set page(
        paper: "us-letter",
        number-align: center,
        numbering: none,
        // margin: (left: 3cm, rest: 2cm,) se configura después de la portada
    )
    // Formato de texto
    set text(
        lang: "es",
        font: "New Computer Modern",
        size: 12pt,
    )
    // Formato de headings
    set heading(numbering: (..n) => {
        if n.pos().len() == 1 [#numbering("1.", ..n) #h(1em)] // Espacio extra para headings de nivel 1
        else if n.pos().len() == 2 [#none] // No numerar headings de nivel 2
        else [#numbering("1.", ..n)] // Para el resto, numerar con formato 1.1.1.
    })

    let header = [
        #set text(size: 13pt)
        #stack(dir: ltr, spacing: 15pt,
            [],
            align(bottom+left, box(width: 1.35cm, image(logos.escudo))),
            align(bottom+left, stack(dir: ttb, spacing: 5pt,
                text("UNIVERSIDAD DE CHILE"),
                text("FACULTAD DE CIENCIAS FÍSICAS Y MATEMÁTICAS"), 
                text("DEPARTAMENTO DE CIENCIAS DE LA COMPUTACIÓN"),
                v(5pt),
                ),
            )
        )
    ]

    let _propuesta = "PROPUESTA DE TEMA DE MEMORIA"
    let _informe = "INFORME FINAL DE " + codigo
    let _documento = [
        #if informe [#_informe] else [#_propuesta] 
        PARA OPTAR AL TÍTULO DE \ INGENIER#autor.pronombre.titulo CIVIL EN COMPUTACIÓN]
    let _modalidad = [MODALIDAD: \ #modalidad]
    let _guia(gen: pronombre.el) = [PROFESOR#gen.guia GUÍA]
    let _coguia(gen: pronombre.el) = [PROFESOR#gen.guia CO-GUÍA]
    let _supervisor(gen: pronombre.el) = [SUPERVISOR#gen.guia]
    let _ciudad = "SANTIAGO DE CHILE"
    let _anno = if anno != none [#anno] else [#datetime.today().year()]

    let portada = align(center)[
        #stack(dir: ttb, spacing: 1fr,
            ..(
            espaciado_titulo,
            titulo,
            0.5fr,
            _documento,
            espaciado_titulo,
            upper(autor.nombre),
            espaciado_titulo,
            _modalidad,
            if profesores.len() == 0 [#none]
            else if profesores.len() == 1 
                [#_guia(gen: profesores.at(0).pronombre): \ #profesores.at(0).nombre]
            else
                [#_guia(gen: profesores.at(0).pronombre): \ #profesores.at(0).nombre \
                #_guia(gen: profesores.at(1).pronombre) 2: \ #profesores.at(1).nombre],
            if coguias.len() == 0 [#none]
            else if coguias.len() == 1
                [#_coguia(gen: coguias.at(0).pronombre): \ #coguias.at(0).nombre]
            else 
                [#_coguia(gen: coguias.at(0).pronombre): \ #coguias.at(0).nombre \
                #_coguia(gen: coguias.at(1).pronombre) 2: \ #coguias.at(1).nombre],
            if supervisor == none [#none]
            else [#_supervisor(gen: supervisor.pronombre): \ #supervisor.nombre],
            [#_ciudad \ #_anno],).filter(it => it != [#none]),
        )
    ]
    // Portada
    header
    portada
    // Comienza el documento, en página 1
    set page(
        numbering: "1",
        margin: (left: 3cm, rest: 2cm,),
    ) // Activar numeración de páginas y márgenes
    set par(
        justify: true,
        first-line-indent: 15pt,
        spacing: 2em,
    ) // Formato de párrafos
    
    // Workaround para que se aplique la indentación al primer párrafo luego de un heading
    // show heading: it => {
    //     it
    //     par(text(size:0.35em, h(0.0em)))
    // } 
    
    set cite(style: "council-of-science-editors") // esto deja las citas contiguas como [1, 2] o [1-3]
    pagebreak(weak: true) // Salto de página
    counter(page).update(1) // Reestablecer el contador de páginas
    doc
}