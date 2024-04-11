import { Controller } from "@hotwired/stimulus"
import swal from 'sweetalert';
// Connects to data-controller="turbo-modal"
export default class extends Controller {
  static targets = ['modal']
  connect() {
    console.log('conectado al turbo-modal');
  }

  hideModal(){
    this.element.parentElement.removeAttribute("src")
    this.modalTarget.remove()
  }

  submitEnd(e){
    console.log(e);
    if(e.detail.success){
      this.hideModal()
      swal({
        title: "Buen Trabajo",
        text: "La Acción se ha hecho exitosamente",
        icon: "success",
        button: "Salir",
      })
    }
  }

 
}
