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
    begin
      image = vision.text_detection(image: URI.open(file_path))
      name_info = image.responses.first.text_annotations.find { |ano| ano.description == "Name" }
      nationality_info = image.responses.first.text_annotations.find { |ano| ano.description == "国籍" }
      age_info = image.responses.first.text_annotations.find { |ano| ano.description == "Age" }
      address_info = image.responses.first.text_annotations.find { |ano| ano.description == "Address" }
      tel_info = image.responses.first.text_annotations.find { |ano| ano.description == "Tel" }
      birth_info = image.responses.first.text_annotations.find { |ano| ano.description == "Birth" }
      insurance_info = image.responses.first.text_annotations.find { |ano| ano.description == "Insurance" }
      other_info = image.responses.first.text_annotations.find { |ano| ano.description == "Others" }
      problem_since_info = image.responses.first.text_annotations.find { |ano| ano.description == "start" }
      big_no_infos = image.responses.first.text_annotations.find { |ano| ano.description == "N" }
      no_infos = image.responses.first.text_annotations.select { |ano| ano.description == "no" }

      infos = [
        {
          description: name_info&.description,
          text: "#{patient.first_name} #{patient.last_name}",
          location: get_location(name_info),
          class: "mark",
          style: "margin-left: 200px;"
        },
        {
          description: birth_info&.description,
          text: "#{patient.date_of_birth.year}_______#{patient.date_of_birth.month}________#{patient.date_of_birth.day}",
          location: get_location(birth_info),
          class: "",
          style: "margin-left: 450px;"
        },
        {
          description: age_info&.description,
          text:  "#{Time.now.utc.to_date.year - patient.date_of_birth.year - ((Time.now.utc.to_date.month > patient.date_of_birth.month || (Time.now.utc.to_date.month == patient.date_of_birth.month && Time.now.utc.to_date.day >= patient.date_of_birth.day)) ? 0 : 1) }",
          location: get_location(age_info),
          class: "mark",
          style: "margin-left: 200px;"
        },
        {
          description: address_info&.description,
          text: "#{patient.address}",
          location: get_location(address_info),
          class: "mark",
          style: "margin-left: 200px;"
        },
        {
          description: tel_info&.description,
          text: "#{patient.phone_number}",
          location: get_location(tel_info),
          class: "mark",
          style: "margin-left: 300px;"
        },
        {
          description: nationality_info&.description,
          text: "#{patient.nationality}",
          location: get_location(nationality_info),
          class: "mark",
          style: "margin-left: 80px;"
        },
        {
          description: insurance_info&.description,
          text: "✔️",
          location: get_location(insurance_info),
          class: "mark",
          style: "margin-left: 200px;"
        },
        {
          description: other_info&.description,
          text: "<input type='text' name='medical_record[symptoms][]' value='#{medical_record.symptoms.join(', ')}'>".html_safe,
          location: get_location(other_info),
          class: "mark",
          style: "margin-top: 75px; margin-left: -200px; background-color: transparent"
        },
        {
          description: problem_since_info&.description,
          text: "<input type='date' name='medical_record[problem_since]' value='#{medical_record.problem_since}'>".html_safe,
          location: get_location(problem_since_info),
          class: "mark",
          style: "margin-left: 200px; background-color: transparent"
        },
        {
          description: 'Submit',
          text: "<input type='submit' class='btn btn-primary' value='Update'>".html_safe,
          location: [2300, 3700],
          class: "",
          style: ""
        }
      ]
      no_infos&.each do |no_question|
        infos << {
          description: no_question&.description,
          text: "⭕️",
          location: get_location(no_question),
          class: "",
          style: ""
        }
      end
      big_no_infos&.each do |big_no_question|
        infos << {
          description: big_no_question&.description,
          text: "⭕️",
          location: get_location(big_no_question),
          class: "",
          style: ""
        }
      end
      return infos
    rescue OpenURI::HTTPError
      return []
    end
  end

  def self.get_location(info)
    return [] unless info

    [info.bounding_poly.vertices[1].x, info.bounding_poly.vertices[1].y]
  end
end
