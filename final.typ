#let logos = (
    escudo: "imagenes/institucion/escudoU2014.svg",
    fcfm: "imagenes/institucion/fcfm.svg"
)

#let pronombre = (
    el:   (titulo: "O", guia: ""),
    ella: (titulo: "A", guia: "A"),
    elle: (titulo: "E", guia: "E"),
)

#let guia(visible: true, body) = if visible [
    #set rect(width: 100%, stroke: black)
    #set par(justify: true, first-line-indent: 0pt)
    #block(breakable: false)[#stack(dir: ttb,
        rect(fill: black, radius: (top: 5pt, bottom: 0pt), text(fill: white, "Guía (deshabilitar antes de entregar)")),
        rect(fill: luma(230), radius: (top: 0pt, bottom: 5pt), body)
    )]] else []

#let conf(
    titulo: none,
    autor: none, // diccionario con nombre y pronombre, (nombre: "", pronombre: pronombre.<el/ella/elle>) 
    tesis: false, // false para memoria, true para tesis
    grado-titulo: "???", // especificar el grado o título al que se opta
    profesores: (), // si es solo un profesor guía, una lista de un elemento es ((nombre: "nombre apellido", pronombre: pronombre.<el/ella/elle>),)
    coguias: (), // si es solo un profesor co-guía, una lista de un elemento es ((nombre: "nombre apellido", pronombre: pronombre.<el/ella/elle>),)
    comision: (), // por cada miembro de la comisión, ("nombre completo",)
    auspicio: none, // si no se especifica, no se muestra
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

    let _memoria = [MEMORIA PARA OPTAR AL TÍTULO DE \ INGENIER#autor.pronombre.titulo CIVIL EN #grado-titulo]
    let _tesis = [TESIS PARA OPTAR AL GRADO DE \ MAGÍSTER EN #grado-titulo]
    let _documento = if tesis [#_tesis] else [#_memoria]
    let _guia(gen: pronombre.el) = [PROFESOR#gen.guia GUÍA]
    let _coguia(gen: pronombre.el) = [PROFESOR#gen.guia CO-GUÍA]
    let _comision = "MIEMBROS DE LA COMISIÓN:"
    let _auspicio = "Este trabajo ha sido parcialmente financiado por " + auspicio
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
            if comision.len() == 0 [#none]
            else if comision.len() == 1
                [#_comision \ #comision.at(0)]
            else if comision.len() == 2
                [#_comision \ #comision.at(0) \ #comision.at(1)]
            else
                [#_comision \ #comision.at(0) \ #comision.at(1) \ #comision.at(2)],
            if auspicio == none [#none] else [#_auspicio],
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
    ) // Formato de párrafos
    show par: set block(spacing: 2em) // Espacio entre párrafos

    // Workaround para que se aplique la indentación al primer párrafo luego de un heading
    // show heading: it => {
    //     it
    //     par(text(size:0.35em, h(0.0em)))
    // } 
    
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

#let mainmatter-section(title, doc) = {
    show heading: set text(size: 24pt)
    let cnt = counter(<capitulo>)
    v(85pt)
    text(size: 24pt, weight: "bold")[Capítulo #cnt.display()]
    v(13pt)
    [#heading(title, numbering: none, outlined: true) <capitulo>]
    v(45pt)
    cnt.step()
    doc
    pagebreak(weak: true)
}

#let resumen(doc) = {
    frontmatter-section(title: "Resumen", doc)
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
    set outline(fill: none)
    show outline.entry: it => {
        box(height: 10pt, stroke: black, strong(it))
    }
    frontmatter-section(
        title: "Tabla de Contenido",
        {
            v(20pt)
            outline(title: none, target: <capitulo>)
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
    show page: set page(numbering: "1")
    counter(page).update(1)
    doc
}

#let capitulo(title: "", doc) = {
    mainmatter-section(title, doc)
}