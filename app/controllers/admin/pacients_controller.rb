class Admin::PacientsController < AdminPanelController
  layout 'admin'
  before_action :set_pacient, only: %i[show edit update destroy]

  # GET /pacients or /pacients.json
  def index
    @q = Pacient.ransack(params[:q])
    @pacients = @q.result(distinct: true)
  end

  # GET /pacients/1 or /pacients/1.json
  def show
    respond_to do |format|
      format.html
      format.pdf do
        pdf_string = render_to_string template: 'admin/pacients/pdfs/pacient', layout: 'pdf', formats: [:html]

        pdf = WickedPdf.new.pdf_from_string(pdf_string)
        # Shared::ExportPdfsJob.perform_async("#{@pacient.first_name}","admin/pacients/pdfs/pacient")
        # render pdf: [@pacient.id, @pacient.first_name].join('-'),template: "admin/pacients/pdfs/pacient",formats: [:html],layout: 'pdf'
        send_data pdf, filename: 'file.pdf'
      end
    end
  end

  def pacient_appointment
    @pacient = Pacient.new
    @pacient.appointments.build
  end

  def pacient_appointment_post
    @pacient = Pacient.new(pacient_params)
    @pacient.appointments.each do |app|
      app.user_id = current_user.id
      app.pacient_id = @pacient.id
    end
    respond_to do |format|
      if @pacient.save

        format.turbo_stream do
          render(turbo_stream: [turbo_stream.replace('appointments', partial: 'admin/appointments/partials/events',
                                                                     locals: { appointments: date_appointment })])
        end
      else
        format.html { render :pacient_appointment, status: :unprocessable_entity }
      end
    end
  end

  # GET /pacients/new
  def new
    @pacient = Pacient.new
  end

  # GET /pacients/1/edit
  def edit
  end

  # POST /pacients or /pacients.json
  def create
    @pacient = Pacient.new(pacient_params)

    respond_to do |format|
      if @pacient.save
        format.turbo_stream
        format.html { redirect_to pacient_url(@pacient), notice: 'Pacient was successfully created.' }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pacients/1 or /pacients/1.json
  def update
    respond_to do |format|
      if @pacient.update(pacient_params)
        format.turbo_stream
        format.html { redirect_to pacient_url(@pacient), notice: 'Pacient was successfully updated.' }
        format.json { render :show, status: :ok, location: @pacient }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @pacient.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pacients/1 or /pacients/1.json
  def destroy
    @pacient.destroy

    respond_to do |format|
      format.turbo_stream { render turbo_stream: turbo_stream.remove(@pacient) }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_pacient
    @pacient = Pacient.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def pacient_params
    params.require(:pacient).permit(:first_name, :last_name, :run, :age, :phone, :email,
                                    appointments_attributes: %i[start_time description status price _destroy])
  end

  def date_appointment
    start_time = params.fetch(:start_time, Date.today).to_date
    @appointments = Appointment.where(start_time: start_time.beginning_of_month.beginning_of_week..start_time.end_of_month.end_of_week)
    @appointments
  end
end
