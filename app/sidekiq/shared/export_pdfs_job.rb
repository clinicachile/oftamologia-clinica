class Shared::ExportPdfsJob
  include Sidekiq::Worker

  def perform(url, name)
    # renderizar a string un pdf
    # render pdf: [@pacient.id, @pacient.first_name].join('-'),template: "admin/pacients/pdfs/pacient",formats: [:html],layout: 'pdf'

    WickedPdf.new.pdf_from_string(
      ApplicationController.renderer.new.render(
        template: "#{url}",
        layout: 'pdf',
        formats: [:html]
      )
    )
  rescue Exception => e
    puts '---------------------------------------'
    puts e.message
    puts '-----------------------------------------'
  end
end
