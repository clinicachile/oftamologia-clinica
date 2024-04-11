class Shared::ExportPdfJob < ApplicationJob
  queue_as :default

  def perform(name, url,format,layout)
    render pdf: name,template: url,formats: [:html]

  end
end
