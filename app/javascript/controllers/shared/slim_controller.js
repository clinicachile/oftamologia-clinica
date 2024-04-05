import { Controller } from "@hotwired/stimulus"
import SlimSelect from 'slim-select'
// Connects to data-controller="shared--slim"
export default class extends Controller {
  static targets= ['field']

  connect() {
    console.log('conectado a slim');
    new SlimSelect({
      select: this.element,
    })
  }
}
