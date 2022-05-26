import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "drawer" ]

  open() {
    this.drawerTarget.classList.toggle("active");
  }
}
