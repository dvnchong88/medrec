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

  def self.locate_text(file_path, medical_record)
    patient = medical_record.patient
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
    other_info = image.responses.first.text_annotations.find { |ano| ano.description == "Others" }
    big_no_info = image.responses.first.text_annotations.find { |ano| ano.description == "No" }
    no_infos = image.responses.first.text_annotations.select { |ano| ano.description == "no" }
    puts
    puts
    puts
    p name_info.description
    p name_info.bounding_poly.vertices
    puts
    puts
    p other_info.description
    p other_info.bounding_poly.vertices
    puts
    puts
    puts
    puts
    infos = [
      {
        description: name_info.description,
        text: "#{patient.first_name} #{patient.last_name}",
        location: [name_info.bounding_poly.vertices[1].x, name_info.bounding_poly.vertices[1].y],
        class: "ms-5",
        style: ""
      },
      {
        description: birth_info.description,
        text: "#{patient.date_of_birth.year}____________ #{patient.date_of_birth.month} _____#{patient.date_of_birth.day}",
        location: [birth_info.bounding_poly.vertices[1].x, birth_info.bounding_poly.vertices[1].y],
        class: "ms-5",
        style: ""
      },
      {
        description: age_info.description,
        text:  "#{Time.now.utc.to_date.year - patient.date_of_birth.year - ((Time.now.utc.to_date.month > patient.date_of_birth.month || (Time.now.utc.to_date.month == patient.date_of_birth.month && Time.now.utc.to_date.day >= patient.date_of_birth.day)) ? 0 : 1) }",
        location: [age_info.bounding_poly.vertices[1].x, age_info.bounding_poly.vertices[1].y],
        class: "ms-5",
        style: ""
      },
      {
        description: address_info.description,
        text: patient.address,
        location: [address_info.bounding_poly.vertices[1].x, address_info.bounding_poly.vertices[1].y],
        class: "ms-5",
        style: ""
      },
      {
        description: tel_info.description,
        text: patient.phone_number,
        location: [tel_info.bounding_poly.vertices[1].x, tel_info.bounding_poly.vertices[1].y],
        class: "ms-5",
        style: ""
      },
      {
        description: nationality_info.description,
        text: patient.nationality,
        location: [nationality_info.bounding_poly.vertices[1].x, nationality_info.bounding_poly.vertices[1].y],
        class: "ms-5",
        style: ""
      },
      {
        description: insurance_info.description,
        text: "✔️",
        location: [insurance_info.bounding_poly.vertices[1].x, insurance_info.bounding_poly.vertices[1].y],
        class: "ms-5",
        style: ""
      },
      {
        description: other_info.description,
        text: "<input type='text' name='medical_record[symptoms][]' value='#{medical_record.symptoms.join(', ')}'>".html_safe,
        location: [other_info.bounding_poly.vertices[1].x, other_info.bounding_poly.vertices[1].y],
        class: "mt-5",
        style: "margin-left: -200px; background-color: transparent"
      },
      {
        description: big_no_info.description,
        text: "<input type='text' name='medical_record[symptoms][]' value='#{medical_record.symptoms.join(', ')}'>".html_safe,
        location: [big_no_info.bounding_poly.vertices[1].x, big_no_info.bounding_poly.vertices[1].y],
        class: "mt-5",
        style: "margin-left: -200px; background-color: transparent"
      },
      {
        description: 'Submit',
        text: "<input type='submit' class='btn btn-primary' value='Update'>".html_safe,
        location: [500, 3700],
        class: "",
        style: ""
      }
    ]
    no_infos.each do |no_question|
      infos << {
        description: no_question.description,
        text: "⭕️",
        location: [no_question.bounding_poly.vertices[1].x, no_question.bounding_poly.vertices[1].y],
        class: "",
        style: ""
      }
    end
    return infos
  end
end
