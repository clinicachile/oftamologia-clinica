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
    send_data(pdf.render, filename: 'hello.pdf', type: 'application/pdf', disposition: 'inline')
  end

  private

  def pacient_find
    @pacient = Pacient.find(params[:id])
  end
end
