# frozen_string_literal: true

class Shared::BodyTableComponent < ViewComponent::Base
  
  def initialize(data:, model:, partial:)
    @data = data
    @model = model
    @partial = partial
  end

end
