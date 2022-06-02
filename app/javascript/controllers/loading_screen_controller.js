import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["form", "header"];

  startLoad() {
    this.headerTarget.classList.add("d-none");
    this.formTarget.insertAdjacentHTML(
      "afterend",
      '<div class="d-flex justify-content-center"><h1>Uploading</h1><p><i class="fa fa-spinner fa-spin fa-3x fa-fw"></i></p></div>'
    );
    this.formTarget.classList.add("d-none");
    this.formTarget.submit();
  }
}
