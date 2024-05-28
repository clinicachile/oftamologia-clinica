import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="shared--formated-number"
export default class extends Controller {
 
  connect() {
    
    console.log(this.element.textContent);
    this.element.textContent = this.numberWithCommas(this.element.textContent)
  }
  numberWithCommas(x) {  
    var parts = x.toString().split(".");
    parts[0] = parts[0].replace(/\B(?=(\d{3})+(?!\d))/g, ".");
    return parts.join(".");
  }
}
