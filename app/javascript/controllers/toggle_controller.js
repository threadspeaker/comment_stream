// app/javascript/controllers/toggle_controller.js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["editForm"]

  toggle(event) {
    event.preventDefault()

    // Check if we have the target
    if (this.hasEditFormTarget) {
      // Toggle the hidden class
      this.editFormTarget.classList.toggle("hidden")
    } else {
      console.error("No editForm target found")
    }
  }
}
