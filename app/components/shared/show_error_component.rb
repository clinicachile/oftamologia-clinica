# frozen_string_literal: true

class Shared::ShowErrorComponent < ViewComponent::Base
  def initialize(object:)
    @object = object
  end

  def render?
    @object.errors.any?
  end

end
