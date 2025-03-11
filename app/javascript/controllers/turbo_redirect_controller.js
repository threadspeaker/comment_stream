import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    connect() {
        document.addEventListener("turbo:before-stream-render", this.handleRedirect)
    }

    disconnect() {
        document.removeEventListener("turbo:before-stream-render", this.handleRedirect)
    }

    handleRedirect = (event) => {
        const streamElement = event.target
        if (streamElement.action === "redirect") {
            event.preventDefault()
            Turbo.visit(streamElement.getAttribute("url"))
        }
    }
}
