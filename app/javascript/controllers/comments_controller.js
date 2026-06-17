import { Controller } from "@hotwired/stimulus"

// Este controlador maneja mostrar y ocultar los comentarios
// data-controller="comments" en el elemento contenedor
export default class extends Controller {
  // targets son elementos del DOM que el controlador puede manipular
  // los defines con data-comments-target="nombre"
  static targets = ["section", "toggleBtn"]

  connect() {
    // Al conectar, los comentarios están ocultos por defecto
    this.isOpen = false
  }

  // Este método se llama con data-action="click->comments#toggle"
  toggle() {
    this.isOpen = !this.isOpen

    if (this.isOpen) {
      // Muestra la sección de comentarios
      this.sectionTarget.classList.remove("hidden")
      this.toggleBtnTarget.textContent = "Ocultar comentarios"
    } else {
      // Oculta la sección de comentarios
      this.sectionTarget.classList.add("hidden")
      this.toggleBtnTarget.textContent = "Ver comentarios"
    }
  }
}