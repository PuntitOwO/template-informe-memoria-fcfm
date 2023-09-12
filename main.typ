#import "conf.typ": conf
#show: conf.with(
  titulo: "Plataforma para auditoria de cumplimiento de Sistema General de Seguridad de Información",
  autor: "Gabriel Rojas Chamorro",
  profesores: ("Eduardo Godoy Vega",),
  supervisor: "Mauricio Castro García",
  modalidad: "Práctica Extendida",
  informe: false,
)

#include "includes/introduccion.typ"
#include "includes/situacion_actual.typ"
#include "includes/objetivos.typ"
#include "includes/solucion.typ"
#include "includes/plan_de_trabajo.typ"

#bibliography(
  "bibliography.bib",
  title: "Referencias",
  style: "ieee",
)
