import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "input", "counter" ]
  
  connect() {
    this.count()
  }
  
  count() {
    const length = this.inputTarget.value.length
    const maxLength = 500
    this.counterTarget.textContent = `${length}/${maxLength}`
    
    if (length > maxLength) {
      this.counterTarget.classList.add("text-red-500")
    } else {
      this.counterTarget.classList.remove("text-red-500")
    }
  }
  
  reset() {
    this.inputTarget.value = ""
    this.count()
  }
}
