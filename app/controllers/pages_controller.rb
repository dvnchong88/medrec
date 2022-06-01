class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home, :dashboard]

  def home
    @hide_navbar = true
    @hide_footer = true
  end

  def dashboard
    # patient = current_user.patient
    if user_signed_in? && current_user.patient?
      # patient = Patient.find(params[:patient_id])
      url = patient_medical_records_url(current_user.patient.id)
      @qr_code = RQRCode::QRCode.new(url)
      # raise
      @svg = @qr_code.as_svg(
        offset: 0,
        color: '000',
        shape_rendering: 'crispEdges',
        standalone: true,
        use_path: true
      )
    end
  end

  def calendar
    @user = current_user
    date = params[:start_date] ? Date.parse(params[:start_date]) : Date.today
    @events = Event.where(start_time: date.beginning_of_month..date.end_of_month, patient: current_user.patient)
    @event = Event.new
  end
end
