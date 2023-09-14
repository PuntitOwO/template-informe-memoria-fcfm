#let logos = (
    escudo: "imagenes/institucion/escudoU2014.svg",
    fcfm: "imagenes/institucion/fcfm.svg"
)

#let guia(visible: true, body) = if visible [
    #set rect(width: 100%, stroke: black)
    #block(breakable: false)[#stack(dir: ttb,
        rect(fill: black, radius: (top: 5pt, bottom: 0pt), text(fill: white, "Guía (deshabilitar antes de entregar)")),
        rect(fill: luma(230), radius: (top: 0pt, bottom: 5pt), body)
    )]] else []

#let conf(
    titulo: none,
    autor: none,
    informe: false, // false para propuesta, true para informe
    codigo: "CC6908", // CC6908 para malla v3, CC6907 para malla v5
    modalidad: "Memoria", // puede ser Memoria, Práctica Extendida, Doble Titulación con Magíster,Doble Titulación de Dos Especialidades
    profesores: (), // si es solo un profesor guia, una lista de un elemento es ("nombre apellido",)
    supervisor: none, // solo en caso de práctica extendida llenar esto, en otro caso none
    anno: none, // si no se especifica, se usa el año actual
    doc,
) = {
    // Formato de página
    set page(
        paper: "us-letter",
        number-align: center,
        numbering: none,
        margin: (left: 3cm, rest: 2cm,)
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
    let _documento = [#if informe [#_informe] else [#_propuesta] PARA OPTAR AL TÍTULO DE \ INGENIERO CIVIL EN COMPUTACIÓN]
    let _modalidad = [MODALIDAD: \ #modalidad]
    let _profesor = "PROFESOR GUÍA"
    let _supervisor = "SUPERVISOR"
    let _ciudad = "SANTIAGO DE CHILE"
    let _anno = if anno != none [#anno] else [#datetime.today().year()]

    let portada = align(center)[
        #stack(dir: ttb, spacing: 17mm,
            v(2mm),
            titulo,
            _documento,
            autor,
            _modalidad,
            if profesores.len() == 0 [#v(-34mm)]
            else if profesores.len() == 1 [#_profesor: \ #profesores.at(0)]
            else [#_profesor: \ #profesores.at(0) \ #_profesor 2: \ #profesores.at(1)],
            if supervisor == none [#v(-34mm)]
            else [#_supervisor: \ #supervisor],
        )
        #align(bottom,[#_ciudad \ #_anno])
    ]
    // Portada
    header
    portada
    // Comienza el documento, en página 1
    set page(numbering: "1") // Activar numeración de páginas
    set par(
        justify: true,
        first-line-indent: 15pt,
    ) // Formato de párrafos
    show par: set block(spacing: 2em) // Espacio entre párrafos
    show heading: it => {
        it
        par(text(size:0.35em, h(0.0em)))
    } // Workaround para que se aplique la indentación al primer párrafo luego de un heading
    pagebreak(weak: true) // Salto de página
    counter(page).update(1) // Reestablecer el contador de páginas
    doc
}