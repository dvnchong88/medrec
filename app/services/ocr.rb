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

  def self.locate_text(file_path, patient)
    require "google/cloud/vision"
    vision = Google::Cloud::Vision.image_annotator
    image = vision.text_detection(image: URI.open(file_path))
    name_info = image.responses.first.text_annotations.find { |ano| ano.description == "Name" }
    nationality_info = image.responses.first.text_annotations.find { |ano| ano.description == "国籍" }
    age_info = image.responses.first.text_annotations.find { |ano| ano.description == "Age" }
    address_info = image.responses.first.text_annotations.find { |ano| ano.description == "Address" }
    tel_info = image.responses.first.text_annotations.find { |ano| ano.description == "Tel" }
    birth_info = image.responses.first.text_annotations.find { |ano| ano.description == "Birth" }
    insurance_info = image.responses.first.text_annotations.find { |ano| ano.description == "Insurance" }
    symptom_info = image.responses.first.text_annotations.find { |ano| ano.description == "ache" }
    puts
    puts
    puts
    puts
    puts
    puts
    puts
    [
      {
        description: name_info.description,
        text: "#{patient.first_name} #{patient.last_name}",
        location: [name_info.bounding_poly.vertices[1].y, name_info.bounding_poly.vertices[1].x]
      },
      {
        description: birth_info.description,
        text: "#{patient.date_of_birth.year}____________ #{patient.date_of_birth.month} _____#{patient.date_of_birth.day}",
        location: [birth_info.bounding_poly.vertices[1].y, birth_info.bounding_poly.vertices[1].x]
      },
      {
        description: age_info.description,
        text:  "#{Time.now.utc.to_date.year - patient.date_of_birth.year - ((Time.now.utc.to_date.month > patient.date_of_birth.month || (Time.now.utc.to_date.month == patient.date_of_birth.month && Time.now.utc.to_date.day >= patient.date_of_birth.day)) ? 0 : 1) }",
        location: [age_info.bounding_poly.vertices[1].y, age_info.bounding_poly.vertices[1].x]
      },
      {
        description: address_info.description,
        text: patient.address,
        location: [address_info.bounding_poly.vertices[1].y, address_info.bounding_poly.vertices[1].x]
      },
      {
        description: tel_info.description,
        text: patient.phone_number,
        location: [tel_info.bounding_poly.vertices[1].y, tel_info.bounding_poly.vertices[1].x]
      },
      {
        description: nationality_info.description,
        text: patient.nationality,
        location: [nationality_info.bounding_poly.vertices[1].y, nationality_info.bounding_poly.vertices[1].x]
      },
      {
        description: insurance_info.description,
        text: "✔️",
        location: [insurance_info.bounding_poly.vertices[1].y, insurance_info.bounding_poly.vertices[1].x]
      },
      {
        description: symptom_info.description,
        text: "✔️",
        location: [symptom_info.bounding_poly.vertices[0].y, symptom_info.bounding_poly.vertices[0].x]
      }
    ]
  end
end
