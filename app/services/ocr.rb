class Ocr
  def self.extract_text(file_path)
    require "google/cloud/vision"
    vision = Google::Cloud::Vision.image_annotator
    image = vision.text_detection(image: URI.open(file_path))
    text = image.responses.first.text_annotations.first.description.split("\n").map(&:downcase).map(&:capitalize)
    {
      first_name: text[4].split[2].capitalize,
      last_name: text[4].split[1].capitalize,
      address: text[10].split[1]
    }
  end
end
