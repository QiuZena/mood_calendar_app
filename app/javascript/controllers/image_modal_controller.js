import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["modal", "img"]

  open(event) {
    const src = event.currentTarget.querySelector("img").src
    this.imgTarget.src = src
    this.modalTarget.classList.remove("hidden")
  }

  close() {
    this.modalTarget.classList.add("hidden")
  }
}
