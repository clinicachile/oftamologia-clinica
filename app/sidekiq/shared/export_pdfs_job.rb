require 'wicked_pdf'
class Shared::ExportPdfsJob
  include Sidekiq::Worker

  def perform(url,name)
    # renderizar a string un pdf
    pdf_string = render_to_string template:url, layout: 'pdf', formats: [:html]
    pdf= WickedPdf.new.pdf_from_string(pdf_string)

    save_path = Rails.root.join('public', "PDF-{Time.now.strftime('%Y%m%d')}.pdf")
    File.open(save_path, 'wb') do |file|
      file << pdf
    end
  end
end
