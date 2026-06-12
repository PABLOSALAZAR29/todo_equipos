import { Controller } from "@hotwired/stimulus"
import Sortable from "sortablejs"

export default class extends Controller {
  connect() {
    this.sortable = Sortable.create(this.element, {
      animation: 150,
      ghostClass: "bg-blue-50",
      onEnd: this.onEnd.bind(this)
    })
  }

  disconnect() {
    this.sortable.destroy()
  }

  onEnd(event) {
    // Recoge el id de la tarea movida y su nueva posición
    const taskId = event.item.dataset.taskId
    const listId = event.item.dataset.listId
    const newPosition = event.newIndex + 1

    // Envía la nueva posición al servidor
    fetch(`/lists/${listId}/tasks/${taskId}/reorder`, {
      method: "PATCH",
      headers: {
        "Content-Type": "application/json",
        "X-CSRF-Token": document.querySelector('meta[name="csrf-token"]').content
      },
      body: JSON.stringify({ position: newPosition })
    })
  }
}