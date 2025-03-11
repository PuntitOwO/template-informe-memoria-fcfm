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

    let _memoria = [MEMORIA PARA OPTAR AL TÍTULO DE \ INGENIER#metadata.autoria.pronombre.titulo CIVIL EN #metadata.grado-titulo]
    let _tesis = [TESIS PARA OPTAR AL GRADO DE \ MAGÍSTER EN CIENCIAS, MENCIÓN #metadata.final.grado-magister]
    let _guia(gen: pronombre.el) = [PROFESOR#gen.guia GUÍA]
    let _coguia(gen: pronombre.el) = [PROFESOR#gen.guia CO-GUÍA]
    let _comision = "MIEMBROS DE LA COMISIÓN:"
    let _auspicio = "Este trabajo ha sido parcialmente financiado por " + metadata.final.auspicio
    let _ciudad = "SANTIAGO DE CHILE"
    let _anno = if metadata.anno != none [#metadata.anno] else [#datetime.today().year()]

    let portada = align(center)[
        #stack(dir: ttb, spacing: 1fr,
            ..(
            metadata.espaciado_titulo,
            metadata.titulo,
            0.5fr,
            if metadata.final.tesis [#_tesis],
            if metadata.final.memoria [#_memoria],
            metadata.espaciado_titulo,
            upper(metadata.autoria.nombre),
            metadata.espaciado_titulo,
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
            if metadata.final.comision.len() == 0 [#none]
            else if metadata.final.comision.len() == 1
                [#_comision \ #metadata.final.comision.at(0)]
            else if metadata.final.comision.len() == 2
                [#_comision \ #metadata.final.comision.at(0) \ #metadata.final.comision.at(1)]
            else
                [#_comision \ #metadata.final.comision.at(0) \ #metadata.final.comision.at(1) \ #metadata.final.comision.at(2)],
            if metadata.final.auspicio == none [#none] else [#_auspicio],
            [#_ciudad \ #_anno],
            ).filter(it => it != [#none]),
        )
    ]
    // Portada
    header
    portada
    // Comienza el frontmatter del documento, en página i
    set page(
        numbering: "i",
        margin: (left: 3cm, rest: 2cm,),
    ) // Activar numeración de páginas y márgenes
    set par(
        justify: true,
        first-line-indent: 15pt,
        spacing: 2em, // Espacio entre párrafos
    ) // Formato de párrafos
    
    set cite(style: "council-of-science-editors") // esto deja las citas contiguas como [1, 2] o [1-3]
    pagebreak(weak: true) // Salto de página
    counter(page).update(1) // Reestablecer el contador de páginas
    counter(<capitulo>).update(1) // Iniciar el contador de capítulos
    doc
}

#let frontmatter-section(title: "", doc) = {
    show heading: set text(size: 24pt)
    v(85pt)
    heading(title, numbering: none, outlined: false)
    v(45pt)
    doc
    pagebreak(weak: true)
}

#let mainmatter-section(title, label, doc) = {
    let cnt = counter(heading)
    show heading.where(level: 1): it => text(size: 24pt, weight: "bold")[Capítulo #cnt.display("1") \ \ #it.body]
    v(85pt)
    [#heading(
        title,
        numbering: "1.", 
        outlined: true,
        supplement: "Capítulo",
    ) #label] // Para añadir la label, debe estar en modo markup
    v(30pt)
    doc
    pagebreak(weak: true)
}

#let backmatter-section(title, label, doc) = {
    let cnt = counter(heading)
    show heading.where(level: 1): it => text(size: 24pt, weight: "bold")[Anexo #cnt.display("A") \ \ #it.body]
    v(85pt)
    [#heading(
        title,
        numbering: "A.",
        outlined: true,
        supplement: "Anexo",
    ) #label] // Para añadir la label, debe estar en modo markup
    v(30pt)
    doc
    pagebreak(weak: true)
}

#let resumen(
    metadata: (:), // metadata del documento
    doc,
) = {
    let _memoria = [MEMORIA PARA OPTAR AL TÍTULO DE INGENIER#metadata.autoria.pronombre.titulo CIVIL EN #metadata.grado-titulo]
    let _tesis = [TESIS PARA OPTAR AL GRADO DE MAGÍSTER EN CIENCIAS, MENCIÓN #metadata.final.grado-magister]
    let _doble = [TESIS PARA OPTAR AL TÍTULO DE INGENIER#metadata.autoria.pronombre.titulo CIVIL EN #metadata.grado-titulo Y MAGÍSTER EN CIENCIAS, MENCIÓN #metadata.final.grado-magister]
    let _documento = if metadata.final.tesis and metadata.final.memoria [#_doble] 
    else if metadata.final.tesis [#_tesis] 
    else [#_memoria]
    let _resumen = [RESUMEN DE LA #_documento]
    let _anno = if metadata.anno != none [#metadata.anno] else [#datetime.today().year()]
    // añadir bloque de resumen
    stack(dir: ltr,
        1fr,
        block(
            width: 60%,
            [#set text(size: 11pt, hyphenate: false); #_resumen \ POR: #upper(metadata.autoria.nombre) \ FECHA: #_anno \ PROF. GUIA: #metadata.profesores.at(0).nombre],
        )
    )
    show heading: it => {set text(size: 12pt, hyphenate: false); align(center, it)}
    heading(metadata.titulo, numbering: none, outlined: false)
    doc
    pagebreak(weak: true)
}

#let agradecimientos(doc) = {
    frontmatter-section(title: "Agradecimientos", doc)
}

#let abstract(doc) = {
    frontmatter-section(title: "Abstract", doc)
}

#let dedicatoria(doc) = {
    set text(style: "italic")
    stack(dir: ttb, 
        1fr,
        align(right, doc),
        2fr
    )
    pagebreak(weak: true)
}

#let toc = {
    set outline.entry(fill: none)
    show outline.entry.where(level: 1): it => box(height: 20pt, align(bottom, strong(it)))
    show outline.entry.where(level: 2): it => box(height: 10pt, h(15pt) + it)
    frontmatter-section(
        title: "Tabla de Contenido",
        {
            v(10pt)
            outline(title: none, depth: 2)
        },
    )
}

#let tot = {
    frontmatter-section(
        title: "Índice de Tablas",
        outline(title: none, target: figure.where(kind: table)),
    )
}

#let toi = {
    frontmatter-section(
        title: "Índice de Ilustraciones",
        outline(title: none, target: figure.where(kind: image)),
    )
}

#let start-doc(doc) = {
    toc
    tot
    toi
    set page(numbering: "1")
    set heading(numbering: "1.1.")
    counter(page).update(1)
    doc
}

#let end-doc(bib-file: "bibliografia.yml", doc) = {
    bibliography(bib-file, title: "Bibliografía", style: "ieee")
    counter(heading).update(0)
    pagebreak(weak: true)
    doc
}

#let capitulo(title: "", label: none, doc) = {
    mainmatter-section(title, label, doc)
}

#let apendice(title: "", label: none, doc) = {
    backmatter-section(title, label, doc)
}