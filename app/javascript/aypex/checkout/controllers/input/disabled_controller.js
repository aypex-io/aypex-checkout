import { Controller } from '@hotwired/stimulus'
import { useIntersection } from 'stimulus-use'

export default class extends Controller {
  connect () {
    useIntersection(this)
  }

  appear (entry) {
    const input = entry.target
    input.disabled = false
  }

  disappear (entry) {
    const input = entry.target
    input.disabled = true
  }
}
