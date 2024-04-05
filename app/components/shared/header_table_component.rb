# frozen_string_literal: true

class Shared::HeaderTableComponent < ViewComponent::Base
  def initialize(headers:)
    @headers = headers
  end

end
