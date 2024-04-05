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
      format.pdf do 
        render pdf: "#{Dashboard::PacientDecorator.new(@pacient).full_name.split("  ").join}",
                page_size: "A4",
                template: "admin/pacients/pacient.pdf.erb",
                formats: [:html],
                layout: 'pdf'
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
    @pacient.destroy!

    respond_to do |format|
      format.html { redirect_to pacients_url, notice: "Pacient was successfully destroyed." }
      format.json { head :no_content }
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
