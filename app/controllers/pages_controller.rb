class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home, :dashboard]

  def home
    @hide_navbar = true
    @hide_footer = true
  end

  def dashboard
    if user_signed_in? && current_user.user_type == "patient"
      url = patient_medical_records_url(current_user.patient)
      @qr_code = RQRCode::QRCode.new(url)
      @svg = @qr_code.as_svg(
        offset: 0,
        color: '000',
        shape_rendering: 'crispEdges',
        standalone: true,
        use_path: true
      )
    end
  end
end
