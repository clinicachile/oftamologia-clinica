class Admin::PdfController < ApplicationController
  def preview
    @pacient = Pacient.find(params[:id])
    pdf = Prawn::Document.new
    pdf.text "#{@pacient.first_name} #{@pacient.last_name}", size: 30, align: :center
    table_data = []
    table_data << %w[Nombre Email Telefono]

    table_data << ["#{@pacient.first_name} #{@pacient.last_name}", @pacient.email, @pacient.phone]
    pdf.table(table_data, width: 500, cell_style: { inline_format: true })
    pdf.move_down 20
    pdf.text 'Citas', size: 25, align: :left
    pdf.table(appointments_register)

    send_data(pdf.render, filename: 'hello.pdf', type: 'application/pdf', disposition: 'inline')
  end

  private

  def pacient_find
    @pacient = Pacient.find(params[:id])
  end

  def appointments_register
    [['Inicio de fecha', 'Description', 'Precio', 'Estado de Pago']] + @pacient.appointments.map do |e|
                                                                         [e.start_time.to_s, e.description.to_s, e.price.to_s,
                                                                          e.status.to_s]
                                                                       end
  end
end
