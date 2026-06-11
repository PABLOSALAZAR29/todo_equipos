// app/javascript/controllers/filtro_controller.js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["input", "tarea"]
  //                  ↑ el buscador   ↑ cada tarea

  filtrar() {
    const busqueda = this.inputTarget.value.toLowerCase()

    this.tareaTargets.forEach(tarea => {
      const texto = tarea.dataset.titulo.toLowerCase()

      if (texto.includes(busqueda)) {
        tarea.classList.remove("hidden")  // mostrar
      } else {
        tarea.classList.add("hidden")     // ocultar
      }
    })
  }
}