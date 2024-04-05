class ApplicationController < ActionController::Base

  def mostrar_producto
    render html: "TODOS LOS PRODUCTOS"
  end

end
