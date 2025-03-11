#import "constants.typ": pronombre

// nota: cuando se habla del diccionario de una persona se refiere a un diccionario con los campos nombre y pronombre. 
// se usa en la mayoría de la metadata, a excepción de la lista de integrantes de la comisión.

#let example-metadata = (
  // El título de la memoria o tesis, en mayúsculas
  titulo: "TÍTULO DE LA MEMORIA/TESIS",
  
  // El diccionario con nombre y pronombre de la persona que escribe el documento
  autoria: (
    nombre: "NOMBRE NOMBRE APELLIDO APELLIDO",
    pronombre: pronombre.elle,
  ),

  // LISTA de profesores guías, en que cada elemento es un diccionario con nombre y pronombre.
  // recordar que una lista de un solo elemento debe tener una coma al final
  profesores: (
    (
      nombre: "NOMBRE APELLIDO APELLIDO",
      pronombre: pronombre.el,
    ), // esta coma es importante para que sea una lista
  ),

  // LISTA de co-guías, en que cada elemento es un diccionario con nombre y pronombre.
  coguias: (
    (
      nombre: "NOMBRE APELLIDO APELLIDO",
      pronombre: pronombre.ella
    ), // esta coma es importante para que sea una lista
  ),

  // El título al que se opta
  grado-titulo: "COMPUTACIÓN",

  // Puede ser un string/content para un año específico o none para el año actual
  anno: none,

  // Espacio extra que rodea al título y al nombre en la portada, 1fr es lo mismo que el resto de espacios, 2fr es el doble, etc.
  espaciado_titulo: 2fr,

  // Este diccionario contiene la información que solo se usa para el informe de introducción al trabajo de título
  intro: (
    // false para propuesta, true para informe
    informe: false,

    // CC6908 para malla v3, CC6907 para malla v5
    codigo: "CC6907",

    // puede ser Memoria, Práctica Extendida, Doble Titulación con Magíster, Doble Titulación de Dos Especialidades
    modalidad: "Memoria",

    // En caso de ser modalidad práctica extendida, llenar con el diccionario correspondiente a la persona que supervisa
    supervision: none,
  ),

  // Este diccionario contiene la información que solo se usa para el informe final de memoria o tesis
  final: (
    // true para tesis o doble titulación, false para solo memoria
    tesis: false,
    
    // true para doble titulación, false para solo tesis
    memoria: true,

    // En caso de ser auspiciado por alguna institución
    auspicio: none,
  
    // El magíster al que se opta, si es tesis
    grado-magister: "COMPUTACIÓN",

    comision: (
      "NOMBRE COMPLETO UNO",
      "NOMBRE COMPLETO DOS",
      "NOMBRE COMPLETO TRES",
    ),
  ),
)