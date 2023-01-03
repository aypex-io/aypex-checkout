/* eslint-disable no-undef */

import { Controller } from '@hotwired/stimulus'
import { useIntersection } from 'stimulus-use'

export default class extends Controller {
  connect () {
    useIntersection(this)

    this.toast = new bootstrap.Toast(this.element)
    this.toast.show()
  }

  disconnect () {
    this.toast.dispose()
  }

  disappear (entry) {
    const toast = entry.target
    toast.remove()
  }
}
