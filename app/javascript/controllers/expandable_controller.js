import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["content", "toggle"]

  connect() {
    this.expanded = false

    requestAnimationFrame(() => {
      this.originalText = this.contentTarget.textContent.trim()
      this.checkOverflow()
    })
  }

  checkOverflow() {
    const content = this.contentTarget
    const initialHeight = content.clientHeight
    content.classList.remove("clamped-text")

    requestAnimationFrame(() => {
      const fullHeight = content.scrollHeight
      content.classList.add("clamped-text")

      if (fullHeight > initialHeight + 1) {
        this.toggleTarget.classList.remove("hidden")
      } else {
        this.toggleTarget.classList.add("hidden")
      }
    })
  }

  toggle() {
    this.expanded = !this.expanded
    if (this.expanded) {
      this.contentTarget.classList.remove("clamped-text")
      this.toggleTarget.textContent = "收起"
    } else {
      this.contentTarget.classList.add("clamped-text")
      this.toggleTarget.textContent = "更多"
    }
  }
}
