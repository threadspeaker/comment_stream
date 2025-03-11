import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["input", "counter"]
  static values = { maxLength: Number }

  connect() {
    // Set default maximum length to 500
    this.maxLength = 500
    // Check if a custom max length is specified
    if (this.element.hasAttribute("data-max-length")) {
      this.maxLength = parseInt(this.element.getAttribute("data-max-length"))
    }

    // Add event listener to handle form validation on submit
    this.input = this.inputTarget
    const form = this.input.closest("form")
    if (form) {
      form.addEventListener("submit", this.validateOnSubmit.bind(this))
    }

    this.count()
  }

  count() {
    const length = this.inputTarget.value.length
    this.counterTarget.textContent = `${length}/${this.maxLength}`

    if (length > this.maxLength) {
      this.counterTarget.classList.add("text-danger")
    } else {
      this.counterTarget.classList.remove("text-danger")
    }
  }

  validateOnSubmit(event) {
    const length = this.inputTarget.value.length

    if (length > this.maxLength) {
      event.preventDefault()
      // Add some visual indication
      this.inputTarget.classList.add("exceeded-limit")
      // Flash the counter
      this.counterTarget.classList.add("flash-warning")

      // Remove the flash class after animation completes
      setTimeout(() => {
        this.counterTarget.classList.remove("flash-warning")
      }, 1000)
    }
  }

  reset() {
    this.inputTarget.value = ""
    this.count()
  }
}