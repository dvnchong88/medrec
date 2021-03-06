import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ['toResize']

  connect() {
    const resizeImage = () => {
      const wrapper = this.element;
      const imgDiv = this.toResizeTarget;
      const ratio = wrapper.clientWidth / imgDiv.scrollWidth;
      const transformation = `scale(${ratio}) translate(-${(imgDiv.scrollWidth - wrapper.clientWidth) / 2}px, -${(imgDiv.scrollHeight - (imgDiv.scrollHeight * ratio)) / 2}px)`;
      imgDiv.style.transform = transformation;
      wrapper.style.height = `${imgDiv.scrollHeight * ratio}px`;
    };
    setTimeout(resizeImage, 100);
    // resizeImage()
  }
}
