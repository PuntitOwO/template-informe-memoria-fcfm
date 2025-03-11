#import "constants.typ": *

#let conf(
    metadata: (:), // metadata del documento
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
    let _informe = "INFORME FINAL DE " + metadata.intro.codigo
    let _documento = [
        #if metadata.intro.informe [#_informe] else [#_propuesta] 
        PARA OPTAR AL TÍTULO DE \ INGENIER#metadata.autoria.pronombre.titulo CIVIL EN #metadata.grado-titulo]
    let _modalidad = [MODALIDAD: \ #metadata.intro.modalidad]
    let _guia(gen: pronombre.el) = [PROFESOR#gen.guia GUÍA]
    let _coguia(gen: pronombre.el) = [PROFESOR#gen.guia CO-GUÍA]
    let _supervisor(gen: pronombre.el) = [SUPERVISOR#gen.guia]
    let _ciudad = "SANTIAGO DE CHILE"
    let _anno = if metadata.anno != none [#metadata.anno] else [#datetime.today().year()]

    let portada = align(center)[
        #stack(dir: ttb, spacing: 1fr,
            ..(
            metadata.espaciado_titulo,
            metadata.titulo,
            0.5fr,
            _documento,
            metadata.espaciado_titulo,
            upper(metadata.autoria.nombre),
            metadata.espaciado_titulo,
            _modalidad,
            if metadata.profesores.len() == 0 [#none]
            else if metadata.profesores.len() == 1 
                [#_guia(gen: metadata.profesores.at(0).pronombre): \ #metadata.profesores.at(0).nombre]
            else
                [#_guia(gen: metadata.profesores.at(0).pronombre): \ #metadata.profesores.at(0).nombre \
                #_guia(gen: metadata.profesores.at(1).pronombre) 2: \ #metadata.profesores.at(1).nombre],
            if metadata.coguias.len() == 0 [#none]
            else if metadata.coguias.len() == 1
                [#_coguia(gen: metadata.coguias.at(0).pronombre): \ #metadata.coguias.at(0).nombre]
            else 
                [#_coguia(gen: metadata.coguias.at(0).pronombre): \ #metadata.coguias.at(0).nombre \
                #_coguia(gen: metadata.coguias.at(1).pronombre) 2: \ #metadata.coguias.at(1).nombre],
            if metadata.intro.supervision == none [#none]
            else [#_supervisor(gen: metadata.intro.supervision.pronombre): \ #metadata.intro.supervision.nombre],
            [#_ciudad \ #_anno],
            ).filter(it => it != [#none]),
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
    
    set cite(style: "council-of-science-editors") // esto deja las citas contiguas como [1, 2] o [1-3]
    pagebreak(weak: true) // Salto de página
    counter(page).update(1) // Reestablecer el contador de páginas
    doc
}