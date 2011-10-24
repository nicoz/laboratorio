class PaginasController < ApplicationController
  def inicio
  	@title = "Inicio"
  end

  def contacto
  	@title = "Contacto"
  end

  def acerca
  	@title = "Acerca de"
  end

end
