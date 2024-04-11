class Admin::PacientsController < AdminPanelController
  layout 'admin'
  before_action :set_pacient, only: %i[ show edit update destroy ]

  # GET /pacients or /pacients.json
  def index
    
    @pacients = Pacient.all
  end

  # GET /pacients/1 or /pacients/1.json
  def show
    respond_to do |format|
      format.html
      format.pdf do
        # pdf_string = render_to_string template:"admin/pacients/pdfs/pacient", layout: 'pdf', formats: [:html]
        # pdf= WickedPdf.new.pdf_from_string(pdf_string)
        # Shared::ExportPdfsJob.perform_async("#{@pacient.first_name}","admin/pacients/pdfs/pacient")
        # render pdf: [@pacient.id, @pacient.first_name].join('-'),template: "admin/pacients/pdfs/pacient",formats: [:html],layout: 'pdf'
        # send_data pdf, filename: 'file.pdf'
        Shared::ExportPdfsJob.perform_async('admin/pacients/pdfs/pacient',[@pacient.first_name, @pacient.last_name].join('-'))
        redirect_to root_path, notice: 'PDF generation started successfully.'
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
        format.html { redirect_to pacient_url(@pacient), notice: "Pacient was successfully created." }
        format.json { render :show, status: :created, location: @pacient }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @pacient.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pacients/1 or /pacients/1.json
  def update
    respond_to do |format|
      if @pacient.update(pacient_params)
        format.turbo_stream
        format.html { redirect_to pacient_url(@pacient), notice: "Pacient was successfully updated." }
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
      format.turbo_stream { render turbo_stream: turbo_stream.remove(@pacient)  }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pacient
      @pacient = Pacient.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def pacient_params
      params.require(:pacient).permit(:first_name, :last_name, :run, :age, :phone, :email,appointments_params: %i[start_time description ])
    end
end
