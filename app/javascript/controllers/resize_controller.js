import { Controller } from "stimulus"

export default class extends Controller {

  connect() {
    const resizeImage = () => {
      const wrapper = document.querySelector(".resize-wrapper");
      const imgDiv = document.querySelector(".resize-element");
      const ratio = wrapper.clientWidth / imgDiv.scrollWidth;
      const transformation = `scale(${ratio}) translate(-${(imgDiv.scrollWidth - wrapper.clientWidth) / 2}px, -${(imgDiv.scrollHeight - imgDiv.scrollHeight * ratio) / 2}px)`;
      imgDiv.style.transform = transformation;
      wrapper.style.height = `${imgDiv.scrollHeight * ratio}px`;
    };
    resizeImage();
  }
}
