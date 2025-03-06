import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["editForm"]
  
  toggle(event) {
    event.preventDefault()
    this.editFormTarget.classList.toggle("hidden")
  }
}
